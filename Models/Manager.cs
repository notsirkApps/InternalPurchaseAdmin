using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InternalPurchaseAdmin.Models
{
    public partial class Manager
    {
        public int ID { get; set; }
        public int UserID { get; set; }
        public int AccountID { get; set; }

        public virtual User User { get; set; }
        public virtual Account Account { get; set; }
    }
}
