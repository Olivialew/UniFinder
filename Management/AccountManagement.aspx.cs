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
            GridViewRow row = GridView1.Rows[e.RowIndex];
            TextBox txtUserName = (TextBox)row.FindControl("txtUserName");
            TextBox txtEmail = (TextBox)row.FindControl("txtEmail");

            if (txtUserName != null && txtEmail != null)
            {
                string username = txtUserName.Text;
                string email = txtEmail.Text;

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
            else
            {
                lblErrorMsg.Text = "Error: Unable to find controls.";
            }
        }



        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                // Check if the index is valid before accessing DataKeys
                if (e.RowIndex >= 0 && e.RowIndex < GridView1.Rows.Count)
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
                else
                {
                    //lblErrorMsg.Text = "Invalid row index.";
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "An error occurred: " + ex.Message;
            }
        }


        protected void DisableAccount(string username)
        {
            try
            {
                MembershipUser user = Membership.GetUser(username);
                if (user != null)
                {
                    user.IsApproved = false;
                    Membership.UpdateUser(user);
                    lblErrorMsg.Text = "Account disabled successfully.";
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
            finally
            {
                BindGrid(); // Rebind to reflect changes
            }
        }

        protected void ReactivateAccount(string username)
        {
            try
            {
                MembershipUser user = Membership.GetUser(username);
                if (user != null)
                {
                    user.IsApproved = true;
                    Membership.UpdateUser(user);
                    lblErrorMsg.Text = "Account reactivated successfully.";
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
            finally
            {
                BindGrid(); // Rebind to reflect changes
            }
        }

        protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            string username = e.CommandArgument.ToString();

            if (e.CommandName == "Disable")
            {
                DisableAccount(username);
            }
            else if (e.CommandName == "Reactivate")
            {
                ReactivateAccount(username);
            }
            else if (e.CommandName == "Delete")
            {
                // Ensure the index is valid
                int rowIndex = GridView1.Rows.Cast<GridViewRow>()
                    .ToList()
                    .FindIndex(row => ((Label)row.FindControl("lblUserName"))?.Text == username);

                if (rowIndex >= 0 && rowIndex < GridView1.Rows.Count)
                {
                    GridViewDeleteEventArgs deleteArgs = new GridViewDeleteEventArgs(rowIndex);
                    GridView1_RowDeleting(sender, deleteArgs);
                }
                else
                {
                    lblErrorMsg.Text = "User not found for deletion.";
                }
            }
        }


        private void BindGrid()
        {
            try
            {
                var users = Membership.GetAllUsers().Cast<MembershipUser>().ToList();
                GridView1.DataSource = users;
                GridView1.DataBind();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "Error binding grid: " + ex.Message;
            }
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
