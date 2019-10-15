using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InternalPurchaseAdmin.Models
{
    public partial class UserAccount
    {
        public int ID { get; set; }
        public int UserID { get; set; }
        public int AccountID { get; set; }

        public User User { get; set; }
        public Account Account { get; set; }
    }
}
