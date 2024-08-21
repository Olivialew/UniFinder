using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniFinder
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void ChangePassword1_CancelButtonClick(object sender, EventArgs e)
        {
            RedirectToRoleBasedPage();
        }

        protected void ChangePassword1_ContinueButtonClick(object sender, EventArgs e)
        {
            RedirectToRoleBasedPage();
        }

        private void RedirectToRoleBasedPage()
        {
            if (User.IsInRole("admin"))
            {
                Response.Redirect("~/Management/AccountAdmin.aspx");
            }
            else if (User.IsInRole("student"))
            {
                Response.Redirect("~/MyAccount/Account.aspx");
            }
            else
            {
                // Default page if the role is neither Admin nor Student
                Response.Redirect("~/MyAccount/Account.aspx");
            }
        }

    }
}