using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniFinder.Management
{
    public partial class AccountAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void LoginStatus1_LoggingOut(object sender, LoginCancelEventArgs e)
        {

        }

        protected void btnDeleteAccount_Click(object sender, EventArgs e)
        {
            // Retrieve the username from the session
            string username = Session["Username"] as string;

            if (!string.IsNullOrEmpty(username))
            {
                bool deleteAllRelatedData = true; // Set to true if you want to delete all related data like profiles, roles, etc.
                bool result = Membership.DeleteUser(username, deleteAllRelatedData);

                if (result)
                {
                    // User deleted successfully
                    // Optionally, you can log out the user and redirect them to a different page
                    FormsAuthentication.SignOut();
                    Response.Redirect("~/LoginPage.aspx");
                }
                else
                {
                    // Handle error
                    lblErrorMsg.Text = "An error occurred while deleting the user account.";
                }
            }
            else
            {
                // Handle case where the username is not found in the session
                lblErrorMsg.Text = "Username not found in session.";
            }
        }
    }
}