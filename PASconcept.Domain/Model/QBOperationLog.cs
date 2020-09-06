using PASconcept.Domain.Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PASconcept.Domain.Model
{
    [Table("QBOperationLog")]
    public class QBOperationLog : Entity<int>
    {
        public DateTime LogDate { get; set; }

        public int companyId { get; set; }

        public string OperationType { get; set; }

        public string OperationData { get; set; }

        public string ResutlStatus { get; set; }
    }
}
