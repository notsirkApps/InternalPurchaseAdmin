using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace InternalPurchaseAdmin.Models
{
    public partial class RequestType
    {
		public RequestType()
        {
            RequestLogs = new HashSet<RequestLog>();
        }

        public int ID { get; set; }
        public string Type { get; set; }
        public string Description { get; set; }

        public virtual ICollection<RequestLog> RequestLogs { get; set; }
    }
}
