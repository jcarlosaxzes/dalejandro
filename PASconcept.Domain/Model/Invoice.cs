using PASconcept.Domain.Entities;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace PASconcept.Domain.Model
{
    [Table("Invoices")]
    public class Invoice : Entity<int>
    {
        public int JobId { get; set; }

        public DateTime InvoiceDate { get; set; }

        public decimal Amount { get; set; }

        public string InvoiceNotes { get; set; }

        public short? Emitted { get; set; }

        public DateTime? FirstEmission { get; set; }

        public DateTime? LatestEmission { get; set; }

        public DateTime? MaturityDate { get; set; }

        public short InvoiceType { get; set; }

        public double? Time { get; set; }

        public double? Rate { get; set; }

        public int? EmployeeTimeId { get; set; }

        public int? StatementId { get; set; }

        public bool? BadDebt { get; set; }

        public DateTime? BadDebtDate { get; set; }

        public int Number { get; set; }

        public int? qbInvoiceId { get; set; }

        public short? EmissionRecurrenceDays { get; set; }

        public Guid? guid { get; set; }

        public int? ReservedId { get; set; }
    }
}
