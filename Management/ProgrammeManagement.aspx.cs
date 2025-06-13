using System;
using System.Data;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniFinder
{
    public partial class Programme_Management : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ResetFilters();
                BindUniversities();
                BindBranches(); // Ensure BindBranches is called initially if needed
                //BindGrid();
            }
        }

        private void BindUniversities()
        {
            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                string query = "SELECT uniID, uniNameEng FROM University";
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Add an "All Universities" option at the top
                DataRow allUniversitiesRow = dt.NewRow();
                allUniversitiesRow["uniID"] = "All"; // Unique identifier for "All"
                allUniversitiesRow["uniNameEng"] = "All Universities";
                dt.Rows.InsertAt(allUniversitiesRow, 0); // Insert at the top

                ddlUni.DataSource = dt;
                ddlUni.DataTextField = "uniNameEng";
                ddlUni.DataValueField = "uniID";
                ddlUni.DataBind();
            }
        }

        private void BindBranches()
        {
            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                string query = "SELECT DISTINCT branchID, location FROM Branch WHERE uniID = @uniID ORDER BY location";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@uniID", ddlUni.SelectedValue);

                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                ddlBranch.Items.Clear();
                ddlBranch.Items.Add(new ListItem("All Branches", "All")); // Ensure "All Branches" is added

                while (dr.Read())
                {
                    string branchID = dr["branchID"].ToString();
                    string location = dr["location"].ToString();
                    ddlBranch.Items.Add(new ListItem(location, branchID));
                }

                dr.Close();
                conn.Close();
            }
        }

        private void BindGrid()
        {
            string query = "SELECT * FROM [Programme] WHERE (1=1)";
            string searchQuery = txtSearch.Text.Trim();
            string uniID = ddlUni.SelectedValue;
            string branchID = ddlBranch.SelectedValue;
            string minFees = txtMinFees.Text.Trim();
            string maxFees = txtMaxFees.Text.Trim();
            string duration = txtDuration.Text.Trim();
            string sortBy = ddlSortBy.SelectedValue;
            string universityFilter = ddlUni.SelectedValue;
            string branchFilter = ddlBranch.SelectedValue;

            if (!string.IsNullOrEmpty(searchQuery))
            {
                query += " AND programName LIKE '%' + @searchQuery + '%'";
            }
            if (universityFilter != "All")
            {
                query += " AND uniID = @UniversityFilter";
            }
            if (branchFilter != "All")
            {
                query += " AND branchID = @BranchFilter";
            }
            if (!string.IsNullOrEmpty(txtMinFees.Text))
            {
                query += " AND fees >= @minFees";
            }
            if (!string.IsNullOrEmpty(txtMaxFees.Text))
            {
                query += " AND fees <= @maxFees";
            }
            if (!string.IsNullOrEmpty(txtDuration.Text))
            {
                query += " AND duration = @duration";
            }

            // Sorting logic
            if (!string.IsNullOrEmpty(sortBy))
            {
                if (sortBy == "fees_asc")
                {
                    query += " ORDER BY fees ASC";
                }
                else if (sortBy == "fees_desc")
                {
                    query += " ORDER BY fees DESC";
                }
                else if (sortBy == "name_asc")
                {
                    query += " ORDER BY programName ASC";
                }
                else if (sortBy == "name_desc")
                {
                    query += " ORDER BY programName DESC";
                }
                else if (sortBy == "latest")
                {
                    query += " ORDER BY programID DESC";
                }
                else if (sortBy == "oldest")
                {
                    query += " ORDER BY programID ASC";
                }
            }

            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (!string.IsNullOrEmpty(searchQuery))
                    {
                        cmd.Parameters.AddWithValue("@searchQuery", searchQuery);
                    }
                    if (universityFilter != "All")
                    {
                        cmd.Parameters.AddWithValue("@UniversityFilter", universityFilter);
                    }
                    if (branchFilter != "All")
                    {
                        cmd.Parameters.AddWithValue("@BranchFilter", branchFilter);
                    }
                    if (!string.IsNullOrEmpty(txtMinFees.Text))
                    {
                        cmd.Parameters.AddWithValue("@minFees", int.Parse(txtMinFees.Text));
                    }
                    if (!string.IsNullOrEmpty(txtMaxFees.Text))
                    {
                        cmd.Parameters.AddWithValue("@maxFees", int.Parse(txtMaxFees.Text));
                    }
                    if (!string.IsNullOrEmpty(txtDuration.Text))
                    {
                        cmd.Parameters.AddWithValue("@duration", int.Parse(txtDuration.Text));
                    }

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    lblNoPrograms.Visible = dt.Rows.Count == 0;
                    GridView1.Visible = dt.Rows.Count > 0;

                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
            }
        }

        protected void btnSearch_Click3(object sender, EventArgs e)
        {
            BindGrid();
        }

        protected void btnReset_Click3(object sender, EventArgs e)
        {
            ResetFilters();
        }

        protected void ResetFilters()
        {
            txtSearch.Text = string.Empty;
            ddlUni.SelectedIndex = 0; // Default to "All Universities"
            ddlBranch.Items.Clear(); // Clear branch dropdown items
            ddlBranch.Items.Add(new ListItem("All Branches", "All")); // Add "All Branches" option
            ddlBranch.SelectedIndex = 0; // Set default value

            ddlSortBy.SelectedIndex = 0; // Default to first sorting option
            txtMinFees.Text = string.Empty;
            txtMaxFees.Text = string.Empty;
            txtDuration.Text = string.Empty;

            // Rebind the universities and branches
            BindUniversities();
            BindBranches(); // Ensure this method gets the "All Branches" 

            BindGrid();
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.GridView1.RowCancelingEdit += new GridViewCancelEditEventHandler(GridView1_RowCancelingEdit);
            this.GridView1.RowUpdating += new GridViewUpdateEventHandler(GridView1_RowUpdating);
            this.GridView1.RowEditing += new GridViewEditEventHandler(GridView1_RowEditing); // Add this line
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindGrid();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridView1.Rows[e.RowIndex];
            Label lblProgramID = row.FindControl("lblProgramID") as Label;
            TextBox txtProgramName = row.FindControl("txtProgramName") as TextBox;
            TextBox txtProgramLink = row.FindControl("txtProgramLink") as TextBox;
            TextBox txtIntroduction = row.FindControl("txtIntroduction") as TextBox;
            TextBox txtContact = row.FindControl("txtContact") as TextBox;
            TextBox txtDuration = row.FindControl("txtDuration") as TextBox;
            TextBox txtFees = row.FindControl("txtFees") as TextBox;
            TextBox txtFacLink = row.FindControl("txtFacLink") as TextBox;
            TextBox txtUniID = row.FindControl("txtUniID") as TextBox;
            TextBox txtBranchID = row.FindControl("txtBranchID") as TextBox;

            if (lblProgramID != null && txtProgramName != null && txtProgramLink != null &&
                txtIntroduction != null && txtContact != null && txtDuration != null &&
                txtFees != null && txtFacLink != null && txtUniID != null && txtBranchID != null)
            {
                string programID = lblProgramID.Text;
                string programName = HttpUtility.HtmlEncode(txtProgramName.Text);
                string programLink = HttpUtility.HtmlEncode(txtProgramLink.Text);
                string introduction = HttpUtility.HtmlEncode(txtIntroduction.Text);
                string contact = HttpUtility.HtmlEncode(txtContact.Text);
                int duration = int.Parse(txtDuration.Text);
                int fees = int.Parse(txtFees.Text);
                string facLink = HttpUtility.HtmlEncode(txtFacLink.Text);
                string uniID = HttpUtility.HtmlEncode(txtUniID.Text);
                string branchID = HttpUtility.HtmlEncode(txtBranchID.Text);

                string query = "UPDATE [Programme] SET programName=@programName, programLink=@programLink, introduction=@introduction, contact=@contact, " +
                    "duration=@duration, fees=@fees, facLink=@facLink, uniID=@uniID, branchID=@branchID WHERE programID=@programID";

                using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@programID", programID);
                        cmd.Parameters.AddWithValue("@programName", programName);
                        cmd.Parameters.AddWithValue("@programLink", programLink);
                        cmd.Parameters.AddWithValue("@introduction", introduction);
                        cmd.Parameters.AddWithValue("@contact", contact);
                        cmd.Parameters.AddWithValue("@duration", duration);
                        cmd.Parameters.AddWithValue("@fees", fees);
                        cmd.Parameters.AddWithValue("@facLink", facLink);
                        cmd.Parameters.AddWithValue("@uniID", uniID);
                        cmd.Parameters.AddWithValue("@branchID", branchID);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                        conn.Close();
                    }
                }

                GridView1.EditIndex = -1;
                BindGrid(); // Ensure this method updates the GridView with the latest data
            }
            else
            {
                // Handle the case where controls are not found
                lblErrorMsg.Text = "Error: Could not find all controls.";
            }
        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            BindGrid();
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // Get the programID of the row being deleted
            string programID = GridView1.DataKeys[e.RowIndex].Value.ToString();

            // Delete the record from the database
            string query = "DELETE FROM [Programme] WHERE [programID] = @programID";

            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@programID", programID);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }

            // Rebind the GridView to reflect the changes
            BindGrid();
        }

        protected void ddlUni_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindBranches(); // Call BindBranches to update ddlBranch        }
        }
    }
}
