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
                BindGrid();
            }
        }

        private void BindGrid(string searchTerm = null)
        {
            var users = Membership.GetAllUsers();

            if (!string.IsNullOrEmpty(searchTerm))
            {
                // Convert to a list and then filter
                var userList = users.Cast<MembershipUser>()
                                    .Where(u => u.UserName.IndexOf(searchTerm, StringComparison.OrdinalIgnoreCase) >= 0 ||
                                                u.Email.IndexOf(searchTerm, StringComparison.OrdinalIgnoreCase) >= 0)
                                    .ToList();

                GridView1.DataSource = userList;
            }
            else
            {
                GridView1.DataSource = users.Cast<MembershipUser>().ToList();
            }

            GridView1.DataBind();
        }


        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                // Ensure RowIndex is valid
                if (e.RowIndex < 0 || e.RowIndex >= GridView1.Rows.Count)
                {
                    throw new ArgumentOutOfRangeException("RowIndex is out of range.");
                }
                string username = GridView1.DataKeys[e.RowIndex].Value.ToString();
                bool deleteAllRelatedData = true; // Set to true if you want to delete all related data like profiles, roles, etc.
                bool result = Membership.DeleteUser(username, deleteAllRelatedData);

                if (result)
                {
                    // User deleted successfully
                    BindGrid(txtSearch.Text); // Rebind the grid to reflect changes
                }
                else
                {
                    // Handle error
                    lblErrorMsg.Text = "An error occurred while deleting the user account.";
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "An error occurred: " + ex.Message;
                // Log error
            }
        }

        protected void btnSearch_Click3(object sender, EventArgs e)
        {
            string searchTerm = txtSearch.Text.Trim();
            BindGrid(searchTerm);
        }

        protected void btnReset_Click3(object sender, EventArgs e)
        {
            txtSearch.Text = string.Empty;
            BindGrid();
        }
    }
}
