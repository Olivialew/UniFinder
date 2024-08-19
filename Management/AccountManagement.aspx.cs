using System;
using System.Linq;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniFinder.Management
{
    public partial class AccountManagement : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid(); // Bind the GridView with data on initial load
            }
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            BindGrid(); // Rebind the GridView with the updated page index
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindGrid(); // Rebind to show the edit controls
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindGrid(); // Rebind to exit edit mode
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Retrieve updated values
            GridViewRow row = GridView1.Rows[e.RowIndex];
            string username = ((TextBox)row.FindControl("txtUserName")).Text;
            string email = ((TextBox)row.FindControl("txtEmail")).Text;

            try
            {
                MembershipUser user = Membership.GetUser(username);
                if (user != null)
                {
                    user.Email = email;
                    Membership.UpdateUser(user);
                    lblErrorMsg.Text = "Account updated successfully.";
                    GridView1.EditIndex = -1;
                    BindGrid(); // Rebind to reflect the update
                }
                else
                {
                    lblErrorMsg.Text = "User not found.";
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "Error updating account: " + ex.Message;
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                string username = GridView1.DataKeys[e.RowIndex].Value.ToString();
                bool deleteAllRelatedData = true; // Adjust as needed
                bool result = Membership.DeleteUser(username, deleteAllRelatedData);

                if (result)
                {
                    lblErrorMsg.Text = "User deleted successfully.";
                    BindGrid(); // Rebind to reflect the deletion
                }
                else
                {
                    lblErrorMsg.Text = "An error occurred while deleting the user account.";
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "An error occurred: " + ex.Message;
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string username = e.CommandArgument.ToString();

            if (e.CommandName == "Edit")
            {
                // Edit functionality is handled by GridView1_RowEditing
            }
            else if (e.CommandName == "Disable")
            {
                DisableAccount(username);
            }
            else if (e.CommandName == "Reactivate")
            {
                ReactivateAccount(username);
            }
            else if (e.CommandName == "Delete")
            {
                GridView1.DeleteRow(GridView1.Rows.Cast<GridViewRow>().ToList().FindIndex(row => ((Label)row.FindControl("lblUserName")).Text == username));
            }
        }

        private void DisableAccount(string username)
        {
            try
            {
                MembershipUser user = Membership.GetUser(username);
                if (user != null)
                {
                    user.IsApproved = false;
                    Membership.UpdateUser(user);
                    lblErrorMsg.Text = "Account disabled successfully.";
                    BindGrid(); // Rebind to reflect changes
                }
                else
                {
                    lblErrorMsg.Text = "User not found.";
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "Error disabling account: " + ex.Message;
            }
        }

        private void ReactivateAccount(string username)
        {
            try
            {
                MembershipUser user = Membership.GetUser(username);
                if (user != null)
                {
                    user.IsApproved = true;
                    Membership.UpdateUser(user);
                    lblErrorMsg.Text = "Account reactivated successfully.";
                    BindGrid(); // Rebind to reflect changes
                }
                else
                {
                    lblErrorMsg.Text = "User not found.";
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "Error reactivating account: " + ex.Message;
            }
        }

        private void BindGrid()
        {
            var users = Membership.GetAllUsers().Cast<MembershipUser>().ToList();
            GridView1.DataSource = users;
            GridView1.DataBind();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text.Trim().ToLower(); // Convert search term to lower case

            // Get the data source
            var users = Membership.GetAllUsers().Cast<MembershipUser>().ToList();

            // Filter the data
            var filteredUsers = users.Where(u => u.UserName.ToLower().Contains(searchTerm) ||
                                                  u.Email.ToLower().Contains(searchTerm)).ToList();

            // Bind filtered data to GridView
            GridView1.DataSource = filteredUsers;
            GridView1.DataBind();
        }


        protected void btnReset_Click(object sender, EventArgs e)
        {
            // Clear search box
            txtSearch.Text = string.Empty;

            // Re-bind the original data to GridView
            BindGrid();
        }

        // Method to get user roles
        protected string GetUserRoles(string username)
        {
            var roles = Roles.GetRolesForUser(username);
            return string.Join(", ", roles);
        }
    }
}
