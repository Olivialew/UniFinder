using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace UniFinder
{
    public partial class University
    {
        public int uniID { get; set; }
        public string uniNameEng { get; set; }
        public string uniNameMalay { get; set; }
        public string uniAcronym { get; set; }
        public int foundationYear { get; set; }
        public string uniType { get; set; }
        public string campusTourLink { get; set; }
        public string youtubeLink { get; set; }
        public byte uniLogo { get; set; }
    }
}