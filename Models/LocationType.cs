using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InternalPurchaseAdmin.Models
{
    public partial class LocationType
    {
		public LocationType()
        {
            Locations = new HashSet<Location>();
        }
		
        public int ID { get; set; }
        public string Type { get; set; }

        public virtual ICollection<Location> Locations { get; set; }
    }
}
