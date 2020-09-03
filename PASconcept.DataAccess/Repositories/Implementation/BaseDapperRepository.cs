using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Microsoft.Extensions.Options;
using PASconcept.DataAccess.Repositories.Abstract;
using PASconcept.Domain.Dapper;
using PASconcept.Domain.Entities;
using PASconcept.Domain.Utils;

namespace PASconcept.DataAccess.Repositories.Implementation
{
    public class BaseDapperRepository : IBaseDapperRepository
    {
        protected readonly string _connString;

        public BaseDapperRepository(IOptions<AppSettings> opts)
        {
            this._connString = opts.Value.ConnectionString;
        }

        #region READ

        public T QuerySingleOrDefault<T>(string query, DynamicParameters pars, CommandType? commandType = null)
        {
            T result;

            using (var conn = new SqlConnection(_connString))
            {
                result = conn.QuerySingleOrDefault<T>(query, pars, commandType: commandType);
            }

            return result;
        }

        public async Task<T> QuerySingleOrDefaultAsync<T>(string query, DynamicParameters pars,
            CommandType? commandType = null)
        {
            T result;

            using (var conn = new SqlConnection(_connString))
            {
                result = await conn.QuerySingleOrDefaultAsync<T>(query, pars, commandType: commandType);
            }

            return result;
        }

        public IEnumerable<T> Query<T>(string query, DynamicParameters pars, CommandType? commandType = null)
        {
            IEnumerable<T> result;

            using (var conn = new SqlConnection(_connString))
            {
                result = conn.Query<T>(query, pars, commandType: commandType);
            }

            return result;
        }

        public async Task<IEnumerable<T>> QueryAsync<T>(string query, DynamicParameters pars,
            CommandType? commandType = null)
        {
            IEnumerable<T> result;

            using (var conn = new SqlConnection(_connString))
            {
                result = await conn.QueryAsync<T>(query, pars, commandType: commandType);
            }

            return result;
        }

        public int Execute(string query, DynamicParameters pars, CommandType? commandType = null)
        {
            int result;

            using (var conn = new SqlConnection(_connString))
            {
                result = conn.Execute(query, pars, commandType: commandType);
            }

            return result;
        }

        public async Task<int> ExecuteAsync(string query, DynamicParameters pars, CommandType? commandType = null)
        {
            int result;

            using (var conn = new SqlConnection(_connString))
            {
                result = await conn.ExecuteAsync(query, pars, commandType: commandType);
            }

            return result;
        }

        public DataSource<T> QueryPaged<T>(PagedQueryTemplate queryTemplate, DynamicParameters pars)
            where T : IGridViewModel
        {
            string query = this.GetPagedWithCountQuery(queryTemplate);

            DataSource<T> result = new DataSource<T>();

            using (var conn = new SqlConnection(_connString))
            {
                using (var multi = conn.QueryMultiple(query, pars))
                {
                    var response = multi.Read<T>();
                    if (response?.Any() == true)
                    {
                        result.Count = multi.ReadSingleOrDefault<int>();
                        result.Payload = response;
                    }
                }
            }

            return result;
        }

        public async Task<DataSource<T>> QueryPagedAsync<T>(PagedQueryTemplate queryTemplate, DynamicParameters pars)
            where T : IGridViewModel
        {
            string query = this.GetPagedWithCountQuery(queryTemplate);

            DataSource<T> result = new DataSource<T>();

            using (var conn = new SqlConnection(_connString))
            {
                using (var multi = await conn.QueryMultipleAsync(query, pars))
                {
                    var response = multi.Read<T>();
                    if (response?.Any() == true)
                    {
                        result.Count = multi.ReadSingleOrDefault<int>();
                        result.Payload = response;
                    }
                }
            }

            return result;
        }


        public int QueryCount(PagedQueryTemplate queryTemplate, DynamicParameters pars)
        {
            string query = QueryCount(queryTemplate);

            int result = 0;

            using (var conn = new SqlConnection(_connString))
            {
                result = conn.QuerySingleOrDefault<int>(query, pars);
            }

            return result;
        }

        public async Task<IEnumerable<object>> QueryPagedAsync(PagedQueryTemplate queryTemplate, DynamicParameters pars)
        {
            string query = QueryPaged(queryTemplate);

            IEnumerable<object> response = null;

            using (var conn = new SqlConnection(_connString))
            {
                response = await conn.QueryAsync(query, pars);
            }

            return response;
        }

        public async Task<int> QueryCountAsync(PagedQueryTemplate queryTemplate, DynamicParameters pars)
        {
            string query = QueryCount(queryTemplate);

            int result = 0;

            using (var conn = new SqlConnection(_connString))
            {
                result = await conn.QuerySingleOrDefaultAsync<int>(query, pars);
            }

            return result;
        }

        #endregion

        #region Query Children

        public IEnumerable<TResult> QueryChildList<TResult, TChild>(string query, DynamicParameters pars,
            CommandType? commandType = null, string splitOnField = "Id")
            where TResult : IEntityParentViewModel<TChild>
            where TChild : IEntityViewModel
        {
            IEnumerable<TResult> result;
            var lookup = new Dictionary<int, TResult>();

            using (var conn = new SqlConnection(_connString))
            {
                result = conn.Query<TResult, TChild, TResult>(
                        query,
                        (t, tChild) =>
                        {
                            if (lookup.TryGetValue(t.Id, out TResult tEntry) == false)
                            {
                                tEntry = t;
                                tEntry.Children1 = new List<TChild>();
                                lookup.Add(tEntry.Id, tEntry);
                            }

                            if (tChild.Id > 0)
                            {
                                tEntry.Children1.Add(tChild);
                            }

                            return tEntry;
                        },
                        pars,
                        commandType: commandType,
                        splitOn: splitOnField)
                    .Distinct()
                    .ToList();
            }

            return result;
        }

        public IEnumerable<TResult> QueryChildrenList<TResult, T1, T2>(string query, DynamicParameters pars,
            CommandType? commandType = null, string splitOnField = "Id,Id")
            where TResult : IEntityParentViewModel<T1, T2>
            where T1 : IEntityViewModel
            where T2 : IEntityViewModel
        {
            IEnumerable<TResult> result;
            var lookup = new Dictionary<int, TResult>();

            using (var conn = new SqlConnection(_connString))
            {
                result = conn.Query<TResult, T1, T2, TResult>(
                        query,
                        (t, t1, t2) =>
                        {
                            if (lookup.TryGetValue(t.Id, out TResult tEntry) == false)
                            {
                                tEntry = t;
                                tEntry.Children1 = new List<T1>();
                                tEntry.Children2 = new List<T2>();
                                lookup.Add(tEntry.Id, tEntry);
                            }

                            if (t1.Id > 0 && tEntry.Children1.Any(c => c.Id.Equals(t1.Id)) == false)
                            {
                                tEntry.Children1.Add(t1);
                            }

                            if (t2.Id > 0 && tEntry.Children2.Any(c => c.Id.Equals(t2.Id)) == false)
                            {
                                tEntry.Children2.Add(t2);
                            }

                            return tEntry;
                        },
                        pars,
                        commandType: commandType,
                        splitOn: splitOnField)
                    .Distinct()
                    .ToList();
            }

            return result;
        }

        public IEnumerable<TResult> QueryChildrenList<TResult, T1, T2, T3>(string query, DynamicParameters pars,
            CommandType? commandType = null, string splitOnField = "Id,Id,Id")
            where TResult : IEntityParentViewModel<T1, T2, T3>
            where T1 : IEntityViewModel
            where T2 : IEntityViewModel
            where T3 : IEntityViewModel
        {
            IEnumerable<TResult> result;
            var lookup = new Dictionary<int, TResult>();

            using (var conn = new SqlConnection(_connString))
            {
                result = conn.Query<TResult, T1, T2, T3, TResult>(
                        query,
                        (t, t1, t2, t3) =>
                        {
                            if (lookup.TryGetValue(t.Id, out TResult tEntry) == false)
                            {
                                tEntry = t;
                                tEntry.Children1 = new List<T1>();
                                tEntry.Children2 = new List<T2>();
                                tEntry.Children3 = new List<T3>();
                                lookup.Add(tEntry.Id, tEntry);
                            }

                            if (t1.Id > 0 && tEntry.Children1.Any(c => c.Id.Equals(t1.Id)) == false)
                            {
                                tEntry.Children1.Add(t1);
                            }

                            if (t2.Id > 0 && tEntry.Children2.Any(c => c.Id.Equals(t2.Id)) == false)
                            {
                                tEntry.Children2.Add(t2);
                            }

                            if (t3.Id > 0 && tEntry.Children3.Any(c => c.Id.Equals(t3.Id)) == false)
                            {
                                tEntry.Children3.Add(t3);
                            }

                            return tEntry;
                        },
                        pars,
                        commandType: commandType,
                        splitOn: splitOnField)
                    .Distinct()
                    .ToList();
            }

            return result;
        }

        public IEnumerable<TResult> QueryChildrenList<TResult, T1, T2, T3, T4>(string query, DynamicParameters pars,
            CommandType? commandType = null, string splitOnField = "Id,Id,Id,Id")
            where TResult : IEntityParentViewModel<T1, T2, T3, T4>
            where T1 : IEntityViewModel
            where T2 : IEntityViewModel
            where T3 : IEntityViewModel
            where T4 : IEntityViewModel
        {
            IEnumerable<TResult> result;
            var lookup = new Dictionary<int, TResult>();

            using (var conn = new SqlConnection(_connString))
            {
                result = conn.Query<TResult, T1, T2, T3, T4, TResult>(
                        query,
                        (t, t1, t2, t3, t4) =>
                        {
                            if (lookup.TryGetValue(t.Id, out TResult tEntry) == false)
                            {
                                tEntry = t;
                                tEntry.Children1 = new List<T1>();
                                tEntry.Children2 = new List<T2>();
                                tEntry.Children3 = new List<T3>();
                                tEntry.Children4 = new List<T4>();
                                lookup.Add(tEntry.Id, tEntry);
                            }

                            if (t1.Id > 0 && tEntry.Children1.Any(c => c.Id.Equals(t1.Id)) == false)
                            {
                                tEntry.Children1.Add(t1);
                            }

                            if (t2.Id > 0 && tEntry.Children2.Any(c => c.Id.Equals(t2.Id)) == false)
                            {
                                tEntry.Children2.Add(t2);
                            }

                            if (t3.Id > 0 && tEntry.Children3.Any(c => c.Id.Equals(t3.Id)) == false)
                            {
                                tEntry.Children3.Add(t3);
                            }

                            if (t4.Id > 0 && tEntry.Children4.Any(c => c.Id.Equals(t4.Id)) == false)
                            {
                                tEntry.Children4.Add(t4);
                            }

                            return tEntry;
                        },
                        pars,
                        commandType: commandType,
                        splitOn: splitOnField)
                    .Distinct()
                    .ToList();
            }

            return result;
        }

        public async Task<IEnumerable<TResult>> QueryChildListAsync<TResult, TChild>(string query,
            DynamicParameters pars, CommandType? commandType = null, string splitOnField = "Id")
            where TResult : IEntityParentViewModel<TChild>
            where TChild : IEntityViewModel
        {
            var result = await Task.Run(() =>
            {
                return QueryChildList<TResult, TChild>(query, pars, commandType, splitOnField);
            });
            return result;
        }

        public async Task<IEnumerable<TResult>> QueryChildrenListAsync<TResult, T1, T2>(string query,
            DynamicParameters pars, CommandType? commandType = null, string splitOnField = "Id,Id")
            where TResult : IEntityParentViewModel<T1, T2>
            where T1 : IEntityViewModel
            where T2 : IEntityViewModel
        {
            var result = await Task.Run(() =>
            {
                return QueryChildrenList<TResult, T1, T2>(query, pars, commandType, splitOnField);
            });
            return result;
        }

        public async Task<IEnumerable<TResult>> QueryChildrenListAsync<TResult, T1, T2, T3>(string query,
            DynamicParameters pars, CommandType? commandType = null, string splitOnField = "Id,Id,Id")
            where TResult : IEntityParentViewModel<T1, T2, T3>
            where T1 : IEntityViewModel
            where T2 : IEntityViewModel
            where T3 : IEntityViewModel
        {
            var result = await Task.Run(() =>
            {
                return QueryChildrenList<TResult, T1, T2, T3>(query, pars, commandType, splitOnField);
            });
            return result;
        }

        public async Task<IEnumerable<TResult>> QueryChildrenListAsync<TResult, T1, T2, T3, T4>(string query,
            DynamicParameters pars, CommandType? commandType = null, string splitOnField = "Id,Id,Id,Id")
            where TResult : IEntityParentViewModel<T1, T2, T3, T4>
            where T1 : IEntityViewModel
            where T2 : IEntityViewModel
            where T3 : IEntityViewModel
            where T4 : IEntityViewModel
        {
            var result = await Task.Run(() =>
            {
                return QueryChildrenList<TResult, T1, T2, T3, T4>(query, pars, commandType, splitOnField);
            });
            return result;
        }

        #endregion

        #region Utils

        private string QueryPaged(PagedQueryTemplate queryTemplate)
        {
            string groupQuery = string.Empty;
            string havingQuery = string.Empty;
            string preQuery = string.Empty;
            int pageNumber = queryTemplate.PageNumber ?? 0;
            int rowsPerPage = queryTemplate.RowsPerPage ?? 20;

            if (string.IsNullOrEmpty(queryTemplate.Groups) == false)
            {
                groupQuery = string.Format(" GROUP BY {0}", queryTemplate.Groups);
            }

            if (string.IsNullOrEmpty(queryTemplate.PreQuery) == false)
            {
                preQuery = queryTemplate.PreQuery;
            }

            if (string.IsNullOrEmpty(queryTemplate.Havings) == false)
            {
                havingQuery = string.Format(" HAVING {0} ", queryTemplate.Havings);
            }

            return $@"
                {preQuery}
                SELECT
                    {queryTemplate.SelectFields}
                FROM
                    {queryTemplate.FromTables}
                WHERE 1=1
                    {queryTemplate.Conditions}
                {groupQuery}
                {havingQuery}
                ORDER BY {queryTemplate.Orders}
                OFFSET {rowsPerPage} * {pageNumber} ROWS
                FETCH NEXT {rowsPerPage} ROWS ONLY
            ";
        }

        private string QueryCount(PagedQueryTemplate queryTemplate)
        {
            string preQuery = string.Empty;

            if (string.IsNullOrEmpty(queryTemplate.PreQuery) == false)
            {
                preQuery = queryTemplate.PreQuery;
            }

            return $@"
                {preQuery}
                SELECT
                    COUNT(*) AS [Count]
                FROM
                    {queryTemplate.FromTables}
                WHERE 1=1
                    {queryTemplate.Conditions}
            ";
        }

        private string GetPagedWithCountQuery(PagedQueryTemplate template)
        {
            string queryPaged = this.QueryPaged(template);

            // Removes pre-query since it will be already
            // executed with `queryPaged`
            template.PreQuery = string.Empty;
            string queryCount = this.QueryCount(template);

            return $"{queryPaged} {queryCount}";
        }

        public SqlConnection GetConnection()
        {
            return new SqlConnection(this._connString);
        }

        #endregion

        #region Query Children QueryPaged

        public async Task<IEnumerable<TResult>> QueryChildListAsync<TResult, TChild>(PagedQueryTemplate queryTemplate,
            DynamicParameters pars, CommandType? commandType = null, string splitOnField = "Id")
            where TResult : IEntityParentViewModel<TChild>
            where TChild : IEntityViewModel
        {
            string query = QueryPaged(queryTemplate);
            var result = await Task.Run(() =>
            {
                return QueryChildList<TResult, TChild>(query, pars, commandType, splitOnField);
            });
            return result;
        }

        #endregion
    }
}