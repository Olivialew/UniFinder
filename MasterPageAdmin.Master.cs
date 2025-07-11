﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace UniFinder
{
    public partial class MasterPageAdmin : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Get the current page's name
            string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath).ToLower();

            // Check the current page and set the active class
            SetActiveNavLink(homeAdminLink, "HomeAdmin.aspx", currentPage);
            SetActiveNavLink(programmeManagementLink, "ProgrammeManagement.aspx", currentPage);
            SetActiveNavLink(uniManagementLink, "UniManagement2.aspx", currentPage);
            SetActiveNavLink(branchManagementLink, "BranchManagement.aspx", currentPage);
            SetActiveNavLink(accountManagementLink, "AccountManagement.aspx", currentPage);
            SetActiveNavLink(accountAdminLink, "AccountAdmin.aspx", currentPage);
        }

        private void SetActiveNavLink(HtmlAnchor anchor, string pageName, string currentPage)
        {
            if (currentPage.Equals(pageName, StringComparison.OrdinalIgnoreCase))
            {
                anchor.Attributes["class"] = "active";
            }
            else
            {
                anchor.Attributes["class"] = "";
            }
        }
    }
}