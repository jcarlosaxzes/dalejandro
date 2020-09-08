using System.Collections.Generic;
using System.Threading.Tasks;
using PASconcept.Domain.Model;

namespace PASconcept.DataAccess.Repositories.Abstract
{
    public interface IQBOperationLogRepository : IBaseRepository<QBOperationLog, int>
    {
        IEnumerable<QBOperationLog> ReadAllByCompanyId(int companyId);
    }
}