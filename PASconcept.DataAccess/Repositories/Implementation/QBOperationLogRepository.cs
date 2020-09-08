using Dapper;
using PASconcept.DataAccess.Repositories.Abstract;
using PASconcept.Domain.Model;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PASconcept.DataAccess.Repositories.Implementation
{
    public class QBOperationLogRepository : BaseRepository<QBOperationLog, int>, IQBOperationLogRepository
    {

        private readonly IBaseDapperRepository _baseDapperRepository;

        public QBOperationLogRepository(PASconceptDbContext dbContext, IBaseDapperRepository baseDapperRepository) : base(dbContext)
        {
            _baseDapperRepository = baseDapperRepository;
        }

        public IEnumerable<QBOperationLog> ReadAllByCompanyId(int companyId)
        {
            IEnumerable<QBOperationLog> result = new List<QBOperationLog>();

            string query = $@"
                SELECT [Id]
                      ,[LogDate]
                      ,[companyId]
                      ,[OperationType]
                      ,[OperationData]
                      ,[ResutlStatus]
                FROM [dbo].[QBOperationLog]
                Where companyId = @companyId";

            DynamicParameters pars = new DynamicParameters();
            pars.Add("@companyId", companyId);

            var rows = this._baseDapperRepository.Query<QBOperationLog>(query, pars);

            if (rows.Any())
            {
                result = rows;
            }

            return result;
        }

    }
}
