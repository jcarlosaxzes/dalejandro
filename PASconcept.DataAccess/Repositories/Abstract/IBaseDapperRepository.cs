using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Threading.Tasks;
using Dapper;
using PASconcept.Domain.Dapper;
using PASconcept.Domain.Entities;

namespace PASconcept.DataAccess.Repositories.Abstract
{
    public interface IBaseDapperRepository
    {
        #region READ

        T QuerySingleOrDefault<T>(string query, DynamicParameters pars, CommandType? commandType = null);

        Task<T> QuerySingleOrDefaultAsync<T>(string query, DynamicParameters pars, CommandType? commandType = null);

        IEnumerable<T> Query<T>(string query, DynamicParameters pars, CommandType? commandType = null);

        Task<IEnumerable<T>> QueryAsync<T>(string query, DynamicParameters pars, CommandType? commandType = null);

        int Execute(string query, DynamicParameters pars, CommandType? commandType = null);

        Task<int> ExecuteAsync(string query, DynamicParameters pars, CommandType? commandType = null);

        DataSource<T> QueryPaged<T>(PagedQueryTemplate queryTemplate, DynamicParameters pars) where T : IGridViewModel;

        int QueryCount(PagedQueryTemplate queryTemplate, DynamicParameters pars);

        Task<DataSource<T>> QueryPagedAsync<T>(PagedQueryTemplate queryTemplate, DynamicParameters pars) where T : IGridViewModel;

        Task<IEnumerable<object>> QueryPagedAsync(PagedQueryTemplate queryTemplate, DynamicParameters pars);

        Task<int> QueryCountAsync(PagedQueryTemplate queryTemplate, DynamicParameters pars);

        #endregion

        #region Query Children

        IEnumerable<TResult> QueryChildList<TResult, TChild>(string query, DynamicParameters pars, CommandType? commandType = null, string splitOnField = "Id")
            where TResult : IEntityParentViewModel<TChild>
            where TChild : IEntityViewModel;

        IEnumerable<TResult> QueryChildrenList<TResult, T1, T2>(string query, DynamicParameters pars, CommandType? commandType = null, string splitOnField = "Id,Id")
            where TResult : IEntityParentViewModel<T1, T2>
            where T1 : IEntityViewModel
            where T2 : IEntityViewModel;

        IEnumerable<TResult> QueryChildrenList<TResult, T1, T2, T3>(string query, DynamicParameters pars, CommandType? commandType = null, string splitOnField = "Id,Id,Id")
            where TResult : IEntityParentViewModel<T1, T2, T3>
            where T1 : IEntityViewModel
            where T2 : IEntityViewModel
            where T3 : IEntityViewModel;

        IEnumerable<TResult> QueryChildrenList<TResult, T1, T2, T3, T4>(string query, DynamicParameters pars, CommandType? commandType = null, string splitOnField = "Id,Id,Id")
            where TResult : IEntityParentViewModel<T1, T2, T3, T4>
            where T1 : IEntityViewModel
            where T2 : IEntityViewModel
            where T3 : IEntityViewModel
            where T4 : IEntityViewModel;

        Task<IEnumerable<TResult>> QueryChildListAsync<TResult, TChild>(string query, DynamicParameters pars, CommandType? commandType = null, string splitOnField = "Id")
            where TResult : IEntityParentViewModel<TChild>
            where TChild : IEntityViewModel;

        Task<IEnumerable<TResult>> QueryChildrenListAsync<TResult, T1, T2>(string query, DynamicParameters pars, CommandType? commandType = null, string splitOnField = "Id,Id")
            where TResult : IEntityParentViewModel<T1, T2>
            where T1 : IEntityViewModel
            where T2 : IEntityViewModel;

        Task<IEnumerable<TResult>> QueryChildrenListAsync<TResult, T1, T2, T3>(string query, DynamicParameters pars, CommandType? commandType = null, string splitOnField = "Id,Id,Id")
            where TResult : IEntityParentViewModel<T1, T2, T3>
            where T1 : IEntityViewModel
            where T2 : IEntityViewModel
            where T3 : IEntityViewModel;

        Task<IEnumerable<TResult>> QueryChildrenListAsync<TResult, T1, T2, T3, T4>(string query, DynamicParameters pars, CommandType? commandType = null, string splitOnField = "Id,Id,Id")
            where TResult : IEntityParentViewModel<T1, T2, T3, T4>
            where T1 : IEntityViewModel
            where T2 : IEntityViewModel
            where T3 : IEntityViewModel
            where T4 : IEntityViewModel;

        #endregion

        SqlConnection GetConnection();

        #region Query Children QueryPaged

        Task<IEnumerable<TResult>> QueryChildListAsync<TResult, TChild>(PagedQueryTemplate queryTemplate, DynamicParameters pars, CommandType? commandType = null, string splitOnField = "Id")
            where TResult : IEntityParentViewModel<TChild>
            where TChild : IEntityViewModel;
        #endregion 
    }
}