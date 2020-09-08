using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;
using PASconcept.DataAccess.Repositories.Abstract;
using PASconcept.Domain.Model;

namespace PASconcept.DataAccess.Repositories.Implementation
{
    public class PASconceptDbContext: DbContext, IPASconceptDbContext
    {

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer(ConfigurationManager.ConnectionStrings["cnnProjectsAccounting"].ToString());
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {

            modelBuilder.Entity<Invoice>(entity =>
            {
                entity.Property(e => e.FirstEmission).HasColumnType("smalldatetime");
                entity.Property(e => e.LatestEmission).HasColumnType("smalldatetime");
                entity.Property(e => e.MaturityDate).HasColumnType("smalldatetime");
                entity.Property(e => e.BadDebtDate).HasColumnType("smalldatetime");

                //entity.Property(e => e.Note)
                //    .IsRequired()
                //    .HasMaxLength(1024);

                //entity.Property(e => e.UserEmail)
                //    .IsRequired()
                //    .HasMaxLength(256);

                //entity.Property(e => e.VisitDate).HasColumnType("datetime");
            });
        }
        //entities
        public DbSet<QBOperationLog> QBOperationLogs { get; set; }

        public DbSet<Invoice> Invoices { get; set; }
    }
}
