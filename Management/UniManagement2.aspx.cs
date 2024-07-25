using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
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
                GridView1.DataBind();
            }
        }

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


        protected void btnSearch_Click2(object sender, EventArgs e)
        {
            // Set default values if controls are empty
            SqlDataSource3.SelectParameters["uniType"].DefaultValue = ddlUniType.SelectedValue != "- University Type -" ? ddlUniType.SelectedValue : string.Empty;
            SqlDataSource3.SelectParameters["uniNameEng"].DefaultValue = !string.IsNullOrEmpty(txtSearch.Text.Trim()) ? txtSearch.Text.Trim() : string.Empty;
            SqlDataSource3.SelectParameters["uniNameMalay"].DefaultValue = !string.IsNullOrEmpty(txtSearch.Text.Trim()) ? txtSearch.Text.Trim() : string.Empty;
            SqlDataSource3.SelectParameters["uniAcronym"].DefaultValue = !string.IsNullOrEmpty(txtSearch.Text.Trim()) ? txtSearch.Text.Trim() : string.Empty;

            // Bind the GridView to apply the filters set by the user
            GridView1.DataBind();
        }

        protected void btnReset_Click2(object sender, EventArgs e)
        {
            // Clear search criteria
            txtSearch.Text = string.Empty;
            ddlUniType.SelectedIndex = 0;

            // Set default values to ensure all records are displayed
            SqlDataSource3.SelectParameters["uniType"].DefaultValue = string.Empty;
            SqlDataSource3.SelectParameters["uniNameEng"].DefaultValue = string.Empty;
            SqlDataSource3.SelectParameters["uniNameMalay"].DefaultValue = string.Empty;
            SqlDataSource3.SelectParameters["uniAcronym"].DefaultValue = string.Empty;

            // Rebind the GridView to show all records
            GridView1.DataBind();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }

        protected void GridView1_RowEditing(object sender, GridViewEditEventArgs e)
        {
            GridView1.EditIndex = e.NewEditIndex;
            GridView1.DataBind(); // Your method to bind data to GridView
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                // Ensure RowIndex is valid
                if (e.RowIndex < 0 || e.RowIndex >= GridView1.Rows.Count)
                {
                    throw new ArgumentOutOfRangeException("RowIndex is out of range.");
                }

                // Get the ID of the row being updated
                object dataKey = GridView1.DataKeys[e.RowIndex]?.Value;
                if (dataKey == null || dataKey == DBNull.Value)
                {
                    throw new InvalidOperationException("DataKey is null or DBNull.");
                }

                int id;
                if (!int.TryParse(dataKey.ToString(), out id))
                {
                    throw new FormatException("DataKey value is not a valid integer.");
                }

                // Get the new values from the text boxes
                TextBox txtNameEng = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtNameEng");
                string newNameEng = txtNameEng.Text;

                TextBox txtNameMalay = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtNameMalay");
                string newNameMalay = txtNameMalay.Text;

                TextBox txtAcronym = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtAcronym");
                string newAcronym = txtAcronym.Text;

                TextBox txtFoundationYear = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtFoundationYear");
                string newFoundationYear = txtFoundationYear.Text;

                TextBox txtUniType = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtUniType");
                string newUniType = txtUniType.Text;

                TextBox txtCampusTourLink = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtCampusTourLink");
                string newCampusTourLink = txtCampusTourLink.Text;

                TextBox txtYoutubeLink = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtYoutubeLink");
                string newYoutubeLink = txtYoutubeLink.Text;

                TextBox txtGoogleMapsLink = (TextBox)GridView1.Rows[e.RowIndex].FindControl("txtGoogleMapsLink");
                string newGoogleMapsLink = txtGoogleMapsLink.Text;

                // Get the FileUpload control and check if a file is uploaded
                FileUpload fileUpload = (FileUpload)GridView1.Rows[e.RowIndex].FindControl("fileUploadImage");
                byte[] imageBytes = null;

                if (fileUpload.HasFile)
                {
                    using (BinaryReader reader = new BinaryReader(fileUpload.PostedFile.InputStream))
                    {
                        imageBytes = reader.ReadBytes(fileUpload.PostedFile.ContentLength);
                    }
                }
                else
                {
                    // No new file uploaded, keep the old image
                    DataRow row = GetRecordById(id); // Implement this method to get the current record from the database
                    imageBytes = (byte[])row["uniLogo"];
                }

                // Update the database with the
                UpdateRecord(id, newNameEng, newNameMalay, newAcronym, newFoundationYear, newUniType, newCampusTourLink, newYoutubeLink, newGoogleMapsLink, imageBytes);

                GridView1.EditIndex = -1;
                GridView1.DataBind(); // Rebind the GridView to reflect changes
            }
            catch (Exception ex)
            {
                // Handle exceptions (e.g., log error, show message to user)
                lblErrorMsg.Text = "An error occurred: " + ex.Message;
            }
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GridView1.DataBind();
        }

        private void UpdateRecord(int id, string nameEng, string nameMalay, string acronym, string foundationYear, string uniType, string campusTourLink, string youtubeLink, string googleMapsLink, byte[] imageBytes)
        {
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

            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, con))
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

                    // Ensure that the parameter for uniLogo is of the correct type
                    SqlParameter imageParam = new SqlParameter("@ImageData", SqlDbType.VarBinary);
                    imageParam.Value = imageBytes ?? (object)DBNull.Value;
                    cmd.Parameters.Add(imageParam);

                    con.Open();
                    cmd.ExecuteNonQuery();
                    con.Close();
                }
            }
        }

        private DataRow GetRecordById(int id)
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
