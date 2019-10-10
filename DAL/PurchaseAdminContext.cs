using InternalPurchaseAdmin.Models;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InternalPurchaseAdmin.DAL
{
    public class PurchaseAdminContext : DbContext
    {
        public PurchaseAdminContext(DbContextOptions<PurchaseAdminContext> options) : base(options)
        {
        }

        public DbSet<Account> Accounts { get; set; }
        public DbSet<AccountType> AccountTypes { get; set; }
        public DbSet<BillingCode> BillingCodes { get; set; }
        public DbSet<Location> Loctions { get; set; }
        public DbSet<LocationType> LocationTypes { get; set; }
        public DbSet<Manager> Managers { get; set; }
        public DbSet<RequestLog> RequestLogs { get; set; }
        public DbSet<RequestType> RequestTypes { get; set; }
        public DbSet<Role> Roles { get; set; }
        public DbSet<UsageLog> UsageLogs { get; set; }
        public DbSet<User> Users { get; set; }
        public DbSet<UserAccount> UserAccounts { get; set; }
        public DbSet<UserRole> UserRoles { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.Entity<Account>().ToTable("Account");
            modelBuilder.Entity<AccountType>().ToTable("AccountType");
            modelBuilder.Entity<BillingCode>().ToTable("BillingCode");
            modelBuilder.Entity<Location>().ToTable("Location");
            modelBuilder.Entity<LocationType>().ToTable("LocationType");
            modelBuilder.Entity<Manager>().ToTable("Manager");
            modelBuilder.Entity<RequestLog>().ToTable("RequestLog");
            modelBuilder.Entity<RequestType>().ToTable("RequestType");
            modelBuilder.Entity<Role>().ToTable("Role");
            modelBuilder.Entity<UsageLog>().ToTable("UsageLog");
            modelBuilder.Entity<User>().ToTable("User");
            modelBuilder.Entity<UserAccount>().ToTable("UserAccount");
            modelBuilder.Entity<UserRole>().ToTable("UserRole");
        }

    }
}
