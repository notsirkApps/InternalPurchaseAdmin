// AUTHOR: Kriston Sanders
// DATE: Oct 2019
// Column attributes used in views.

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace InternalPurchaseAdmin.Models
{
    public partial class AccountType
    {
		public AccountType()
        {
            Accounts = new HashSet<Account>();
        }
		
        public int ID { get; set; }
        [Display(Name = "Type Name")]
        public string TypeName { get; set; }

        public virtual ICollection<Account> Accounts { get; set; }
    }
}
