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
    public class InvoiceRepository : BaseRepository<Invoice, int>, IInvoiceRepository
    {

        private readonly IBaseDapperRepository _baseDapperRepository;

        public InvoiceRepository(PASconceptDbContext dbContext, IBaseDapperRepository baseDapperRepository) : base(dbContext)
        {
            _baseDapperRepository = baseDapperRepository;
        }

        public IEnumerable<Invoice> ReadAllByCompanyId(int companyId)
        {
            IEnumerable<Invoice> result = new List<Invoice>();

            string query = $@"
                SELECT [Invoices].*
                FROM [dbo].[Invoices]
                inner join Jobs on Invoices.JobId = Jobs.Id
                where companyId= @companyId";

            DynamicParameters pars = new DynamicParameters();
            pars.Add("@companyId", companyId);

            var rows = this._baseDapperRepository.Query<Invoice>(query, pars);

            if (rows.Any())
            {
                result = rows;
            }

            return result;
        }

    }
}
