using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniFinder.Management
{
    public partial class AccountAdmin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Assuming the username is stored in the session
                string username = Session["username"] as string;

                if (!string.IsNullOrEmpty(username))
                {
                    // Query the database to get the email based on the username
                    string email = GetEmailByUsername(username);

                    // Set the email to the lblEmail
                    lblEmail.Text = email;
                }
            }
        }

        // Example method to retrieve email by username from the database
        private string GetEmailByUsername(string username)
        {
            string email = string.Empty;

            // Your database query to retrieve the email based on username
            // Assuming you have a method that fetches the email
            // Example:
            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                string query = @"
                    SELECT Email 
                    FROM aspnet_Membership 
                    WHERE UserId = (
                        SELECT UserId 
                        FROM aspnet_Users 
                        WHERE UserName = @Username
                    )";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);

                conn.Open();
                email = cmd.ExecuteScalar() as string;
            }

            return email;
        }

        protected void LoginStatus1_LoggingOut(object sender, LoginCancelEventArgs e)
        {

        }

        protected void btnDisableAccount_Click(object sender, EventArgs e)
        {
            if (DisableAccount())
            {
                lblErrorMsg.Text = "Your account has been disabled.";
                lblErrorMsg.ForeColor = System.Drawing.Color.Green;
            }
            else
            {
                lblErrorMsg.Text = "An error occurred while disabling your account. Please try again.";
                lblErrorMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        private bool DisableAccount()
        {
            try
            {
                // Get the currently logged-in user
                MembershipUser currentUser = Membership.GetUser(User.Identity.Name);

                if (currentUser != null)
                {
                    // Disable the user by setting IsApproved to false
                    currentUser.IsApproved = false;
                    Membership.UpdateUser(currentUser);

                    // Optionally, log out the user after disabling the account
                    FormsAuthentication.SignOut();
                    return true;
                }
            }
            catch (Exception ex)
            {
                // Log the exception (not shown here) and return false
            }

            return false;
        }
    }
}