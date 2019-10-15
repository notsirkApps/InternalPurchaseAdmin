using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InternalPurchaseAdmin.Models.ViewModels
{
    public class AccountIndexData
    {
        public IEnumerable<Account> Accounts { get; set; }
        public IEnumerable<AccountType> AccountTypes { get; set; }
        public IEnumerable<User> Members { get; set; }
        public IEnumerable<User> Managers { get; set; }
        public IEnumerable<UserAccount> UserAcccounts{ get; set; }
    }
}
