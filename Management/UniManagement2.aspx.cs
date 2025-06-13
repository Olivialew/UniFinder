using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniFinder
{
    public partial class UniManagement2 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Bind dropdown lists
                BindDropdowns();

                // Set default sort to "Oldest" (ASC)
                ddlSortBy.SelectedValue = "ASC";

                // Bind the GridView with default sort order
                //BindGrid(sortOrder: "ASC");
            }
        }

        private void BindDropdowns()
        {
            // Bind university types to ddlUniType
            DataTable universityTypes = GetUniversityTypes();
            ddlUniType.DataSource = universityTypes;
            ddlUniType.DataTextField = "uniType";
            ddlUniType.DataValueField = "uniType";
            ddlUniType.DataBind();
            ddlUniType.Items.Insert(0, new ListItem("All University Types", "")); // Default to show all types

            // Bind branch locations to ddlLocation
            DataTable branchLocations = GetBranchLocations();
            ddlLocation.DataSource = branchLocations;
            ddlLocation.DataTextField = "location";
            ddlLocation.DataValueField = "location";
            ddlLocation.DataBind();
            ddlLocation.Items.Insert(0, new ListItem("All Branches", "")); // Default to show all branches
        }

        //Display Image
        protected string GetImageUrl(object uniLogo)
        {
            if (uniLogo != DBNull.Value && uniLogo != null)
            {
                byte[] bytes = (byte[])uniLogo;
                return "data:image/png;base64," + Convert.ToBase64String(bytes);
            }
            else
            {
                return "/Images/defaultLogo.png"; // Provide a path to your default image
            }
        }

        private DataTable GetUniversityTypes()
        {
            DataTable dt = new DataTable();
            string query = "SELECT DISTINCT uniType FROM [University]";

            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        private DataTable GetBranchLocations()
        {
            DataTable dt = new DataTable();
            string query = "SELECT DISTINCT location FROM [Branch]";

            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        private void BindGrid(string searchQuery = "", string uniType = "", string branch = "", string sortBy = "")
        {
            string query = @"
    SELECT u.uniID, u.uniNameEng, u.uniNameMalay, u.uniAcronym, u.foundationYear, 
           u.uniType, u.campusTourLink, u.youtubeLink, u.googleMapsLink, 
           MAX(CASE WHEN b.location IS NOT NULL THEN b.location ELSE '' END) AS Location,
           MAX(CASE WHEN u.uniLogo IS NOT NULL THEN u.uniLogo ELSE NULL END) AS uniLogo
    FROM University u
    LEFT JOIN Branch b ON u.uniID = b.uniID
    WHERE (1=1)";

            if (!string.IsNullOrEmpty(searchQuery))
            {
                query += " AND u.uniNameEng LIKE @searchQuery";
            }

            if (!string.IsNullOrEmpty(uniType))
            {
                query += " AND u.uniType = @UniType";
            }

            if (!string.IsNullOrEmpty(branch))
            {
                query += " AND b.location = @Location";
            }

            query += " GROUP BY u.uniID, u.uniNameEng, u.uniNameMalay, u.uniAcronym, u.foundationYear, u.uniType, u.campusTourLink, u.youtubeLink, u.googleMapsLink";

            // Apply sorting by uniID (latest or oldest)
            if (sortBy == "latest")
            {
                query += " ORDER BY u.uniID DESC";  // Sorting by latest uniID
            }
            else if (sortBy == "oldest")
            {
                query += " ORDER BY u.uniID ASC";  // Sorting by oldest uniID
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (!string.IsNullOrEmpty(searchQuery))
                    {
                        cmd.Parameters.AddWithValue("@searchQuery", "%" + searchQuery + "%");
                    }
                    if (!string.IsNullOrEmpty(uniType))
                    {
                        cmd.Parameters.AddWithValue("@UniType", uniType);
                    }
                    if (!string.IsNullOrEmpty(branch))
                    {
                        cmd.Parameters.AddWithValue("@Location", branch);
                    }

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        GridView1.DataSource = dt;
                        GridView1.DataBind();
                        GridView1.Visible = true;
                        lblNoRecords.Visible = false; // Hide "No records found" message
                    }
                    else
                    {
                        GridView1.Visible = false; // Hide GridView
                        lblNoRecords.Visible = true; // Show "No records found" message
                    }
                }
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "Error: " + ex.Message;
                LogError(ex.ToString());
            }
        }


        protected void ddlSortBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            string sortOrder = ddlSortBy.SelectedValue; // Get selected value (ASC or DESC)

            // Call BindGrid with the selected sort order
            BindGrid(txtSearch.Text.Trim(), ddlUniType.SelectedValue, ddlLocation.SelectedValue, sortOrder);
        }

        protected void btnSearch_Click2(object sender, EventArgs e)
        {
            string searchQuery = txtSearch.Text.Trim();
            string uniType = ddlUniType.SelectedValue;
            string location = ddlLocation.SelectedValue;
            string sortBy = ddlSortBy.SelectedValue;  // Assuming you have a dropdown for sorting

            BindGrid(searchQuery, uniType, location, sortBy);
        }

        protected void btnReset_Click2(object sender, EventArgs e)
        {
            // Clear filters and reset controls
            txtSearch.Text = "";
            ddlUniType.SelectedIndex = 0;
            ddlLocation.SelectedIndex = 0;
            SqlDataSource3.FilterExpression = "";

            //GridView1.DataBind();
            BindGrid();
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.GridView1.RowCancelingEdit += new GridViewCancelEditEventHandler(GridView1_RowCancelingEdit);
            this.GridView1.RowUpdating += new GridViewUpdateEventHandler(GridView1_RowUpdating);
            this.GridView1.RowEditing += new GridViewEditEventHandler(GridView1_RowEditing);
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            //GridView1.DataBind();
            BindGrid();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            //GridView1.DataBind(); // Your method to bind data to GridView
            BindGrid();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindGrid();
        }

        private void LogError(string message)
        {
            // Implement your logging mechanism here, e.g., write to a log file or database
            System.Diagnostics.Debug.WriteLine(message);
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = GridView1.Rows[e.RowIndex];

                // Debug: List all controls in the row
                foreach (Control control in row.Controls)
                {
                    System.Diagnostics.Debug.WriteLine("Control found: " + control.ID);
                }

                // Find the controls in the row
                TextBox txtNameEng = row.FindControl("txtNameEng") as TextBox;
                TextBox txtNameMalay = row.FindControl("txtNameMalay") as TextBox;
                TextBox txtAcronym = row.FindControl("txtAcronym") as TextBox;
                TextBox txtFoundationYear = row.FindControl("txtFoundationYear") as TextBox;
                TextBox txtUniType = row.FindControl("txtUniType") as TextBox;
                TextBox txtCampusTourLink = row.FindControl("txtCampusTourLink") as TextBox;
                TextBox txtYoutubeLink = row.FindControl("txtYoutubeLink") as TextBox;
                TextBox txtGoogleMapsLink = row.FindControl("txtGoogleMapsLink") as TextBox;

                // Check if all controls are not null
                if (txtNameEng != null && txtNameMalay != null && txtAcronym != null &&
                    txtFoundationYear != null && txtUniType != null && txtCampusTourLink != null &&
                    txtYoutubeLink != null && txtGoogleMapsLink != null)
                {
                    // Extract values
                    string id = GridView1.DataKeys[e.RowIndex].Value.ToString();
                    string nameEng = HttpUtility.HtmlEncode(txtNameEng.Text);
                    string nameMalay = HttpUtility.HtmlEncode(txtNameMalay.Text);
                    string acronym = HttpUtility.HtmlEncode(txtAcronym.Text);
                    string foundationYear = HttpUtility.HtmlEncode(txtFoundationYear.Text);
                    string uniType = HttpUtility.HtmlEncode(txtUniType.Text);
                    string campusTourLink = HttpUtility.HtmlEncode(txtCampusTourLink.Text);
                    string youtubeLink = HttpUtility.HtmlEncode(txtYoutubeLink.Text);
                    string googleMapsLink = HttpUtility.HtmlEncode(txtGoogleMapsLink.Text);

                    // Get the FileUpload control and check if a file is uploaded
                    FileUpload fileUpload = row.FindControl("fileUploadImage") as FileUpload;
                    byte[] imageBytes = null;

                    if (fileUpload != null && fileUpload.HasFile)
                    {
                        using (BinaryReader reader = new BinaryReader(fileUpload.PostedFile.InputStream))
                        {
                            imageBytes = reader.ReadBytes(fileUpload.PostedFile.ContentLength);
                        }
                    }
                    else
                    {
                        // No new file uploaded, keep the old image
                        DataRow existingRow = GetRecordById(id);
                        if (existingRow != null && existingRow["uniLogo"] != DBNull.Value)
                        {
                            imageBytes = (byte[])existingRow["uniLogo"];
                        }
                    }

                    // Define the SQL query
                    string query = @"
                        UPDATE University 
                        SET uniNameEng = @NameEng, 
                            uniNameMalay = @NameMalay, 
                            uniAcronym = @Acronym, 
                            foundationYear = @FoundationYear, 
                            uniType = @UniType, 
                            campusTourLink = @CampusTourLink, 
                            youtubeLink = @YoutubeLink, 
                            googleMapsLink = @GoogleMapsLink, 
                            uniLogo = @ImageData 
                        WHERE uniID = @ID";

                    // Execute the query
                    using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                    {
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@ID", id);
                            cmd.Parameters.AddWithValue("@NameEng", nameEng);
                            cmd.Parameters.AddWithValue("@NameMalay", nameMalay);
                            cmd.Parameters.AddWithValue("@Acronym", acronym);
                            cmd.Parameters.AddWithValue("@FoundationYear", foundationYear);
                            cmd.Parameters.AddWithValue("@UniType", uniType);
                            cmd.Parameters.AddWithValue("@CampusTourLink", campusTourLink);
                            cmd.Parameters.AddWithValue("@YoutubeLink", youtubeLink);
                            cmd.Parameters.AddWithValue("@GoogleMapsLink", googleMapsLink);

                            SqlParameter imageParam = new SqlParameter("@ImageData", SqlDbType.VarBinary);
                            imageParam.Value = imageBytes ?? (object)DBNull.Value;
                            cmd.Parameters.Add(imageParam);

                            conn.Open();
                            cmd.ExecuteNonQuery();
                            conn.Close();
                        }
                    }

                    // Reset the edit index and rebind the GridView to reflect changes
                    GridView1.EditIndex = -1;
                    BindGrid();
                }
                else
                {
                    // Handle the case where controls are not found
                    lblErrorMsg.Text = "Error: Could not find all controls.";
                }
            }
            catch (FormatException formatEx)
            {
                lblErrorMsg.Text = "Input string was not in a correct format. Please check your input.";
                LogError(formatEx.ToString());
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "An error occurred: " + ex.Message;
                LogError(ex.ToString());
            }
        }

        protected void GridView1_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                // Get the ID of the record to delete
                string id = GridView1.DataKeys[e.RowIndex].Value.ToString();

                // Define the SQL queries
                string deleteBranchesQuery = "DELETE FROM Branch WHERE uniID = @ID";
                string deleteUniversityQuery = "DELETE FROM University WHERE uniID = @ID";

                using (SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                {
                    conn.Open();

                    // Begin transaction
                    using (SqlTransaction transaction = conn.BeginTransaction())
                    {
                        try
                        {
                            // Delete related Branch records
                            using (SqlCommand cmd = new SqlCommand(deleteBranchesQuery, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@ID", id);
                                cmd.ExecuteNonQuery();
                            }

                            // Delete University record
                            using (SqlCommand cmd = new SqlCommand(deleteUniversityQuery, conn, transaction))
                            {
                                cmd.Parameters.AddWithValue("@ID", id);
                                cmd.ExecuteNonQuery();
                            }

                            // Commit transaction
                            transaction.Commit();
                        }
                        catch (Exception)
                        {
                            // Rollback transaction in case of error
                            transaction.Rollback();
                            throw;
                        }
                    }
                }

                // Rebind the GridView to reflect changes
                BindGrid();
            }
            catch (Exception ex)
            {
                lblErrorMsg.Text = "An error occurred: " + ex.Message;
                LogError(ex.ToString());
            }
        }

        private DataRow GetRecordById(string id)
        {
            string query = "SELECT * FROM University WHERE uniID = @ID";
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@ID", id);
                    con.Open();
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);
                        if (dt.Rows.Count > 0)
                        {
                            return dt.Rows[0];
                        }
                        else
                        {
                            return null;
                        }
                    }
                }
            }
        }
    }
}
