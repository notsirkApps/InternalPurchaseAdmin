// AUTHOR: Kriston Sanders
// DATE: Oct 2019
// Column attributes and LocationType used in views.

using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace InternalPurchaseAdmin.Models
{
    public partial class Location
    {
		public Location()
        {
            UsageLogs = new HashSet<UsageLog>();
        }
		
        public int ID { get; set; }
        public int TypeID { get; set; }
        public string Description { get; set; }
        public string Name { get; set; }
        [Display(Name = "Created"), DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime CreatedDateTime { get; set; }
        [Display(Name = "Deleted"), DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true, NullDisplayText = "Active")]
        public DateTime? DeletedDateTime { get; set; }
        [Display(Name = "Location Type")]
        public string TypeDescription
        {
            get
            {
                return LocationType.Type;
            }
        }

        public virtual LocationType LocationType { get; set; }
        public virtual ICollection<UsageLog> UsageLogs { get; set; }
    }
}
