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
    public partial class RequestLog
    {
        public int ID { get; set; }
        public int? ResolvedByUserID { get; set; }
        public int TypeID { get; set; }
        public int? AffectedUserID { get; set; }
        [Display(Name = "Requested"), DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true)]
        public DateTime RequestDateTime { get; set; }
        [Display(Name = "Completed"), DataType(DataType.Date)]
        [DisplayFormat(DataFormatString = "{0:yyyy-MM-dd}", ApplyFormatInEditMode = true, NullDisplayText = "Pending...")]
        public DateTime? CompletedDateTime { get; set; }
        public bool? IsRejected { get; set; }
        [Display(Name = "Notes")]
        public string ResolutionNotes { get; set; }
        [Display(Name = "Additional Info")]
        public string Attribute { get; set; }
        public int RequestedByUserID { get; set; }
        public string Status
        {
            get
            {
                if (IsRejected == null) return "Pending...";
                if (IsRejected == true) return "Rejected";
                else return "Accepted";
            }
        }
        [Display(Name = "Resolved By")]
        public string ResolvedBy
        {
            get
            {
                return ResolvedByUser.FullName;
            }
        }
        [Display(Name = "Affected User")]
        public string AffectedUser
        {
            get
            {
                return RequestedForUser.FullName;
            }
        }
        [Display(Name = "Requested By")]
        public string RequestedBy
        {
            get
            {
                return RequestedByUser.FullName;
            }
        }
        [Display(Name = "Request Type")]
        public string TypeDescription
        {
            get
            {
                return RequestType.Description;
            }
        }

        public virtual User ResolvedByUser { get; set; }
        public virtual User RequestedByUser { get; set; }
        public virtual User RequestedForUser { get; set; }
        public virtual RequestType RequestType { get; set; }
    }
}
