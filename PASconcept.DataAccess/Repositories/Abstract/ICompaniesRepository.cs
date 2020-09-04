using System.Threading.Tasks;

namespace PASconcept.DataAccess.Repositories.Abstract
{
    public interface ICompaniesRepository
    {
        /// <summary>
        /// Gets default company's id given a user email
        /// if not company is associated with user then 0 is returned
        /// </summary>
        /// <param name="userEmail"></param>
        /// <returns></returns>
        int GetDefaultCompanyId(string userEmail);
    }
}