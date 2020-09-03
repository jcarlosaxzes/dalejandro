using System.Data;
using System.Threading.Tasks;
using Dapper;
using PASconcept.DataAccess.Repositories.Abstract;

namespace PASconcept.DataAccess.Repositories.Implementation
{
    public class CompaniesRepository : ICompaniesRepository
    {
        private readonly IBaseDapperRepository _baseDapperRepository;

        public CompaniesRepository(
            IBaseDapperRepository baseDapperRepository)
        {
            this._baseDapperRepository = baseDapperRepository;
        }

        public int GetDefaultCompanyId(string userEmail)
        {
            var pars = new DynamicParameters();
            pars.Add("@Email", userEmail);

            const string spName = "dbo.Company_default_SELECT";

            return this._baseDapperRepository.QuerySingleOrDefault<int>(spName, pars, CommandType.StoredProcedure);
        }
    }
}