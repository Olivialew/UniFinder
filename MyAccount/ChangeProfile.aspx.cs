using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniFinder.MyAccount
{
    public partial class ChangeProfile : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnChangeProfile_Click(object sender, EventArgs e)
        {
            string currentPassword = txtCurrentPassword.Text;
            string newEmail = txtNewEmail.Text;

            if (ValidateCurrentPassword(currentPassword))
            {
                if (UpdateUserEmail(newEmail))
                {
                    lblErrorMsg.Text = "Profile updated successfully!";
                    lblErrorMsg.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    lblErrorMsg.Text = "An error occurred while updating your profile. Please try again.";
                    lblErrorMsg.ForeColor = System.Drawing.Color.Red;
                }
            }
            else
            {
                lblErrorMsg.Text = "Incorrect password. Please try again.";
                lblErrorMsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        private bool ValidateCurrentPassword(string currentPassword)
        {
            // Validate the user's current password
            return Membership.ValidateUser(User.Identity.Name, currentPassword);
        }

        private bool UpdateUserEmail(string newEmail)
        {
            try
            {
                // Get the currently logged-in user
                MembershipUser currentUser = Membership.GetUser(User.Identity.Name);

                if (currentUser != null && !string.IsNullOrEmpty(newEmail))
                {
                    // Update the email address
                    currentUser.Email = newEmail;
                    Membership.UpdateUser(currentUser);
                    return true;
                }
            }
            catch (Exception ex)
            {
                // Log the exception (not shown here) and return false
            }

            return false;
        }

        protected void btnCancel_Click(object sender, EventArgs e)
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