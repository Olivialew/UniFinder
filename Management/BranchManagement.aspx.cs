using System;
using System.Data;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniFinder
{
    public partial class BranchManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAllRecords();
            }
        }

        private void LoadAllRecords()
        {
            // Set the SqlDataSource command to get all branches
            SqlDataSource1.SelectCommand = "SELECT * FROM [Branch]";
            GridView1.DataBind();

            // Load all universities into the dropdown list (if needed)
            LoadAllUniversities();
        }

        private void LoadAllUniversities()
        {
            // Assuming you have a method to get all universities from the database
            ddlUni.DataSource = GetAllUniversities(); // Implement this method to fetch data
            ddlUni.DataTextField = "uniNameEng"; // Adjust based on your actual field names
            ddlUni.DataValueField = "uniID";
            ddlUni.DataBind();
            ddlUni.Items.Insert(0, new ListItem("All Universities", ""));
        }

        private DataTable GetAllUniversities()
        {
            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                var cmd = new SqlCommand("SELECT uniID, uniNameEng FROM University", conn);
                var adapter = new SqlDataAdapter(cmd);
                var dataTable = new DataTable();
                adapter.Fill(dataTable);
                return dataTable;
            }
        }

        protected void ddlUni_SelectedIndexChanged(object sender, EventArgs e)
        {
            var selectedUniID = ddlUni.SelectedValue;
            if (!string.IsNullOrEmpty(selectedUniID))
            {
                ddlBranch.DataSource = GetBranchesByUniversity(selectedUniID); // Implement this method
                ddlBranch.DataTextField = "location";
                ddlBranch.DataValueField = "branchID";
                ddlBranch.DataBind();
                ddlBranch.Items.Insert(0, new ListItem("All Branches", ""));
            }
        }

        private DataTable GetBranchesByUniversity(string uniID)
        {
            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                var cmd = new SqlCommand("SELECT branchID, location FROM Branch WHERE uniID = @UniversityID", conn);
                cmd.Parameters.AddWithValue("@UniversityID", uniID);
                var adapter = new SqlDataAdapter(cmd);
                var dataTable = new DataTable();
                adapter.Fill(dataTable);
                return dataTable;
            }
        }

        protected void btnReset_Click2(object sender, EventArgs e)
        {
            ddlUni.SelectedIndex = 0;
            ddlBranch.SelectedIndex = 0;

            LoadAllRecords();
            lblErrorMessage.Visible = false;
        }

        protected void ddlSortBranch_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Reapply the search with the selected sort order
            btnSearch_Click2(sender, e);
        }


        protected void btnSearch_Click2(object sender, EventArgs e)
        {
            var uniID = ddlUni.SelectedValue;
            var branchID = ddlBranch.SelectedValue;
            var sortOrder = ddlSortBranch.SelectedValue; // Get the selected sort order

            string query = "SELECT * FROM [Branch] WHERE (1=1)"; // Base query

            // Apply filters based on university and branch selection
            if (!string.IsNullOrEmpty(uniID))
            {
                query += " AND [uniID] = @uniID";
            }
            if (!string.IsNullOrEmpty(branchID))
            {
                query += " AND [branchID] = @branchID";
            }

            // Apply sorting based on selected sort order (e.g., ASC or DESC)
            if (sortOrder == "ASC")
            {
                query += " ORDER BY branchID ASC";  // Sort by ascending
            }
            else if (sortOrder == "DESC")
            {
                query += " ORDER BY branchID DESC"; // Sort by descending
            }

            // Set the query to the SqlDataSource
            SqlDataSource1.SelectCommand = query;
            SqlDataSource1.SelectParameters.Clear();

            // Add parameters for the filters
            if (!string.IsNullOrEmpty(uniID))
            {
                SqlDataSource1.SelectParameters.Add("uniID", uniID);
            }
            if (!string.IsNullOrEmpty(branchID))
            {
                SqlDataSource1.SelectParameters.Add("branchID", branchID);
            }

            // Rebind the GridView with the updated query
            GridView1.DataBind();

            // Display error message if no records are found
            if (GridView1.Rows.Count == 0)
            {
                lblErrorMessage.Text = "No branches found for the selected criteria.";
                lblErrorMessage.Visible = true;
            }
            else
            {
                lblErrorMessage.Visible = false;
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Handle GridView selection change if needed
        }
    }
}
