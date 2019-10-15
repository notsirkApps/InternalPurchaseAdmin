// AUTHOR: Kriston Sanders
// DATE: Oct 2019
// Column attributes and additional properties used in views.

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace InternalPurchaseAdmin.Models
{
    public partial class Account
    {
		public Account()
        {
            Managers = new HashSet<Manager>();
            UsageLogs = new HashSet<UsageLog>();
            Members = new HashSet<UserAccount>();
        }
		
        public int ID { get; set; }
        public int AccountTypeID { get; set; }
        public string Name { get; set; }
        [Display(Name = "Created"), DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime CreatedDateTime { get; set; }
        [Display(Name = "Deleted"), DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true, NullDisplayText = "Active")]
        public DateTime? DeletedDateTime { get; set; }
        [Display(Name = "Account Type")]
        public string TypeName
        {
            get
            {
                return AccountType.TypeName;
            }
        }

        public virtual AccountType AccountType { get; set; }
        public virtual BillingCode BillingCode { get; set; }
        public virtual ICollection<Manager> Managers { get; set; }
        public virtual ICollection<UsageLog> UsageLogs { get; set; }
        public virtual ICollection<UserAccount> Members { get; set; }
    }
}
