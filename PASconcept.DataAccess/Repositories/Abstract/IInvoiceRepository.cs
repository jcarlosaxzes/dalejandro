using System.Collections.Generic;
using System.Threading.Tasks;
using PASconcept.Domain.Model;

namespace PASconcept.DataAccess.Repositories.Abstract
{
    public interface IInvoiceRepository : IBaseRepository<Invoice, int>
    {
        IEnumerable<Invoice> ReadAllByCompanyId(int companyId);
    }
}