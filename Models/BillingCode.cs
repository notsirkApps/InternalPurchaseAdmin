// AUTHOR: Kriston Sanders
// DATE: Oct 2019
// Column attributes and additional properties used in views.

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Threading.Tasks;

namespace InternalPurchaseAdmin.Models
{
    public partial class BillingCode
    {
        [Key]
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int Code { get; set; }
        public int AccountID { get; set; }
        [Display(Name = "Account Name")]
        public string AccountName
        {
            get
            {
                return Account.Name;
            }
        }

        public Account Account { get; set; }
    }
}
