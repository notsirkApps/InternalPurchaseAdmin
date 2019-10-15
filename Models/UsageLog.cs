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
    public partial class UsageLog
    {
        public int ID { get; set; }
        public int UserID { get; set; }
        public int AccountID { get; set; }
        public int LocationID { get; set; }
        [Display(Name = "Date/Time"), DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime DateTime { get; set; }
        public float Cost { get; set; }
        [Display(Name = "Item Name")]
        public string ItemName { get; set; }
        [Display(Name = "Detail 1")]
        public string ItemAttribute1 { get; set; }
        [Display(Name = "Detail 2")]
        public string ItemAttribute2 { get; set; }
        [Display(Name = "Detail 3")]
        public string ItemAttribute3 { get; set; }
        [Display(Name = "Detail 4")]
        public string ItemAttribute4 { get; set; }
        [Display(Name = "Purchased By")]
        public string PurchasedBy
        {
            get
            {
                return User.FullName;
            }
        }
        [Display(Name = "Account Used")]
        public string AccountUsedName
        {
            get
            {
                return AccountUsed.BillingCode.Code + " - " + AccountUsed.Name;
            }
        }
        [Display(Name = "Trans Location")]
        public string TransLocation
        {
            get
            {
                return Location.Name;
            }
        }

        public virtual User User { get; set; }
        public virtual Account AccountUsed { get; set; }
        public virtual Location Location { get; set; }
    }
}
