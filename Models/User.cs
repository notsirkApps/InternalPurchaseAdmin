// AUTHOR: Kriston Sanders
// DATE: Oct 2019
// Column attributes and FullName property used in views.

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace InternalPurchaseAdmin.Models
{
    public partial class User
    {
		public User()
        {
            Manager = new HashSet<Manager>();
            RequestLogAffectedUser = new HashSet<RequestLog>();
            RequestLogRequestedByUser = new HashSet<RequestLog>();
            RequestLogResolvedByUser = new HashSet<RequestLog>();
            UsageLogs = new HashSet<UsageLog>();
            Accounts = new HashSet<UserAccount>();
            Roles = new HashSet<UserRole>();
        }
		
        public int ID { get; set; }
        public string Username { get; set; }
        [Display(Name = "First Name")]
        public string FirstName { get; set; }
        [Display(Name = "Last Name")]
        public string LastName { get; set; }
        [Display(Name = "Card Number")]
        public string CardNumber { get; set; }
        [Display(Name = "Created"), DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime CreatedDateTime { get; set; }
        [Display(Name = "Deleted"), DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true, NullDisplayText = "Active")]
        public DateTime? DeletedDateTime { get; set; }
        [Display(Name = "Full Name")]
        public string FullName
        {
            get
            {
                return LastName + ", " + FirstName;
            }
        }

		public virtual ICollection<Manager> Manager { get; set; }
        public virtual ICollection<RequestLog> RequestLogAffectedUser { get; set; }
        public virtual ICollection<RequestLog> RequestLogRequestedByUser { get; set; }
        public virtual ICollection<RequestLog> RequestLogResolvedByUser { get; set; }
        public virtual ICollection<UsageLog> UsageLogs { get; set; }
        public virtual ICollection<UserAccount> Accounts { get; set; }
        public virtual ICollection<UserRole> Roles { get; set; }
    }
}
