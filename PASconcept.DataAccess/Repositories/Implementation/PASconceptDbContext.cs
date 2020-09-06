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
        }
        //entities
        public DbSet<QBOperationLog> QBOperationLogs { get; set; }
    }
}
