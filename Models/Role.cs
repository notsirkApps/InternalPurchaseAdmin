using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InternalPurchaseAdmin.Models
{
    public partial class Role
    {
		public Role()
        {
            Users = new HashSet<UserRole>();
        }
		
        public int ID { get; set; }
        public string Name { get; set; }

        public ICollection<UserRole> Users { get; set; }
    }
}
