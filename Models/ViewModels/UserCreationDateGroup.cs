using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;

namespace InternalPurchaseAdmin.Models.ViewModels
{
    public class UserCreationDateGroup
    {
        [DataType(DataType.Date)]
        public DateTime? CreatedDateTime { get; set; }

        public int UserCount { get; set; }
    }
}
