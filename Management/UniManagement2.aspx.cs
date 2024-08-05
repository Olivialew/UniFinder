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
                // Bind the GridView to display all records on initial load
                //GridView1.DataBind();

                BindGrid();
            }
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
                return "/Images/LogoNew.png"; // Provide a path to your default image
            }
        }

        //protected string GetImageUrl(object imageUrl)
        //{
        //    return imageUrl != DBNull.Value ? "data:image;base64," + Convert.ToBase64String((byte[])imageUrl) : "~/images/No_Image_Available.jpg";
        //}

        //protected void btnSearch_Click2(object sender, EventArgs e)
        //{
        //    // Set filter parameters for the SqlDataSource
        //    string searchQuery = txtSearch.Text.Trim();
        //    string uniType = ddlUniType.SelectedValue;
        //    string location = ddlLocation.SelectedValue;

        //    // Clear existing parameters
        //    SqlDataSource3.SelectParameters.Clear();

        //    // Build the filter expression
        //    List<string> filters = new List<string>();

        //    if (!string.IsNullOrEmpty(searchQuery))
        //    {
        //        filters.Add("uniNameEng LIKE '%' + @SearchQuery + '%'");
        //        SqlDataSource3.SelectParameters.Add("SearchQuery", searchQuery);
        //    }

        //    if (!string.IsNullOrEmpty(uniType) && uniType != "<-- Select University Type -->")
        //    {
        //        filters.Add("uniType = @UniType");
        //        SqlDataSource3.SelectParameters.Add("UniType", uniType);
        //    }

        //    if (!string.IsNullOrEmpty(location))
        //    {
        //        filters.Add("location = @Location");
        //        SqlDataSource3.SelectParameters.Add("Location", location);
        //    }

        //    // Join all filters with AND
        //    if (filters.Count > 0)
        //    {
        //        SqlDataSource3.FilterExpression = string.Join(" AND ", filters);
        //    }
        //    else
        //    {
        //        SqlDataSource3.FilterExpression = ""; // No filter expression if no filters are applied
        //    }

        //    // Rebind data to GridView
        //    GridView1.DataBind();
        //}

        private void BindGrid(string searchQuery = "", string uniType = "", string branch = "")
        {
            string query = @"
                SELECT u.*, b.location 
                FROM University u
                INNER JOIN Branch b ON u.uniID = b.uniID
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
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
            }
            catch (Exception ex)
            {
                // Log or handle the exception
                lblErrorMsg.Text = "Error: " + ex.Message;
            }
        }

        protected void btnSearch_Click2(object sender, EventArgs e)
        {
            // Set filter parameters for the SqlDataSource
            string searchQuery = txtSearch.Text.Trim();
            string uniType = ddlUniType.SelectedValue;
            string location = ddlLocation.SelectedValue;
            //string sortBy = ddlSortBy.SelectedValue;

            BindGrid(searchQuery, uniType, location/*sortBy*/);
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

        //protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        //{
        //    try
        //    {
        //        // Ensure RowIndex is valid
        //        if (e.RowIndex < 0 || e.RowIndex >= GridView1.Rows.Count)
        //        {
        //            throw new ArgumentOutOfRangeException("RowIndex is out of range.");
        //        }

        //        // Get the ID of the row being updated
        //        string id = GridView1.DataKeys[e.RowIndex].Value.ToString();
        //        if (string.IsNullOrEmpty(id))
        //        {
        //            throw new InvalidOperationException("DataKey is null or empty.");
        //        }

        //        // Log the ID for debugging purposes
        //        System.Diagnostics.Debug.WriteLine("Updating record with ID: " + id);

        //        // Get the new values from the text boxes
        //        TextBox txtNameEng = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtNameEng");
        //        string newNameEng = txtNameEng?.Text ?? string.Empty;

        //        TextBox txtNameMalay = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtNameMalay");
        //        string newNameMalay = txtNameMalay?.Text ?? string.Empty;

        //        TextBox txtAcronym = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtAcronym");
        //        string newAcronym = txtAcronym?.Text ?? string.Empty;

        //        TextBox txtFoundationYear = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtFoundationYear");
        //        string newFoundationYear = txtFoundationYear?.Text ?? string.Empty;

        //        TextBox txtUniType = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtUniType");
        //        string newUniType = txtUniType?.Text ?? string.Empty;

        //        TextBox txtCampusTourLink = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtCampusTourLink");
        //        string newCampusTourLink = txtCampusTourLink?.Text ?? string.Empty;

        //        TextBox txtYoutubeLink = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtYoutubeLink");
        //        string newYoutubeLink = txtYoutubeLink?.Text ?? string.Empty;

        //        TextBox txtGoogleMapsLink = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtGoogleMapsLink");
        //        string newGoogleMapsLink = txtGoogleMapsLink?.Text ?? string.Empty;

        //        // Log the new values for debugging purposes
        //        System.Diagnostics.Debug.WriteLine($"New values: NameEng={newNameEng}, NameMalay={newNameMalay}, Acronym={newAcronym}, FoundationYear={newFoundationYear}, UniType={newUniType}, CampusTourLink={newCampusTourLink}, YoutubeLink={newYoutubeLink}, GoogleMapsLink={newGoogleMapsLink}");

        //        // Get the FileUpload control and check if a file is uploaded
        //        FileUpload fileUpload = (FileUpload)GridView1.Rows[e.RowIndex].FindControl("fileUploadImage");
        //        byte[] imageBytes = null;

        //        if (fileUpload != null && fileUpload.HasFile)
        //        {
        //            using (BinaryReader reader = new BinaryReader(fileUpload.PostedFile.InputStream))
        //            {
        //                imageBytes = reader.ReadBytes(fileUpload.PostedFile.ContentLength);
        //            }
        //        }
        //        else
        //        {
        //            // No new file uploaded, keep the old image
        //            DataRow row = GetRecordById(id);
        //            if (row != null && row["uniLogo"] != DBNull.Value)
        //            {
        //                imageBytes = (byte[])row["uniLogo"];
        //            }
        //        }

        //        // Update the database with the new values
        //        UpdateRecord(id, newNameEng, newNameMalay, newAcronym, newFoundationYear, newUniType, newCampusTourLink, newYoutubeLink, newGoogleMapsLink, imageBytes);

        //        // Reset the edit index and rebind the GridView to reflect changes
        //        GridView1.EditIndex = -1;
        //        BindGrid();
        //    }
        //    catch (FormatException formatEx)
        //    {
        //        lblErrorMsg.Text = "Input string was not in a correct format. Please check your input.";
        //        LogError(formatEx.ToString());
        //    }
        //    catch (Exception ex)
        //    {
        //        lblErrorMsg.Text = "An error occurred: " + ex.Message;
        //        LogError(ex.ToString());
        //    }
        //}

        //private void UpdateRecord(string id, string nameEng, string nameMalay, string acronym, string foundationYear, string uniType, string campusTourLink, string youtubeLink, string googleMapsLink, byte[] imageBytes)
        //{
        //    string query = @"
        //        UPDATE University 
        //        SET uniNameEng = @NameEng, 
        //            uniNameMalay = @NameMalay, 
        //            uniAcronym = @Acronym, 
        //            foundationYear = @FoundationYear, 
        //            uniType = @UniType, 
        //            campusTourLink = @CampusTourLink, 
        //            youtubeLink = @YoutubeLink, 
        //            googleMapsLink = @GoogleMapsLink, 
        //            uniLogo = @ImageData 
        //        WHERE uniID = @ID";

        //    using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        //    {
        //        using (SqlCommand cmd = new SqlCommand(query, con))
        //        {
        //            cmd.Parameters.AddWithValue("@ID", id);
        //            cmd.Parameters.AddWithValue("@NameEng", nameEng);
        //            cmd.Parameters.AddWithValue("@NameMalay", nameMalay);
        //            cmd.Parameters.AddWithValue("@Acronym", acronym);
        //            cmd.Parameters.AddWithValue("@FoundationYear", foundationYear);
        //            cmd.Parameters.AddWithValue("@UniType", uniType);
        //            cmd.Parameters.AddWithValue("@CampusTourLink", campusTourLink);
        //            cmd.Parameters.AddWithValue("@YoutubeLink", youtubeLink);
        //            cmd.Parameters.AddWithValue("@GoogleMapsLink", googleMapsLink);

        //            SqlParameter imageParam = new SqlParameter("@ImageData", SqlDbType.VarBinary);
        //            imageParam.Value = imageBytes ?? (object)DBNull.Value;
        //            cmd.Parameters.Add(imageParam);

        //            con.Open();
        //            cmd.ExecuteNonQuery();
        //            con.Close();
        //        }
        //    }
        //}

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                GridViewRow row = GridView1.Rows[e.RowIndex];

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
