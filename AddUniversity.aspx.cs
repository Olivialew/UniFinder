using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Data.SqlClient;
using System.Web.Configuration;
using System.Configuration;
using System.Reflection;
using System.Web.UI.WebControls.WebParts;

namespace UniFinder
{
    public partial class AddUniversity : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                //if (Session["UserType"] == null || Session["UserType"].ToString() != "Admin")
                //{
                //    Response.Redirect("~/Login.aspx");
                //    return;
                //}

                clearfn();
                //GVbind();
            }
        }

        protected void btnAddUniversity_Click(object sender, EventArgs e)
        {
            int recordCount = 0;

            if (FileUploadUniLogo.HasFile)
            {
                try
                {
                    string extension = Path.GetExtension(FileUploadUniLogo.FileName).ToLower();
                    if (extension == ".jpg" || extension == ".jpeg" || extension == ".png")
                    {
                        if (FileUploadUniLogo.PostedFile.ContentLength <= 102400) // 100KB
                        {
                            byte[] uniLogoByte = null;

                            using (BinaryReader br = new BinaryReader(FileUploadUniLogo.PostedFile.InputStream))
                            {
                                uniLogoByte = br.ReadBytes(FileUploadUniLogo.PostedFile.ContentLength);
                            }

                            using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                            {
                                con.Open();

                                // Get the record number to generate promo id
                                string queryCount = "SELECT COUNT(*) FROM University";
                                SqlCommand cmdCountPromo = new SqlCommand(queryCount, con);

                                recordCount = (int)cmdCountPromo.ExecuteScalar();
                                recordCount++;

                                string uniId = "U" + recordCount.ToString("D4");

                                string queryInsert = "INSERT INTO University (uniID, uniNameEng, uniNameMalay, uniAcronym, foundationYear, uniType, uniLogo, campusTourLink, youtubeLink, googleMapsLink) " +
                                                     "VALUES (@UniversityID, @EnglishName, @MalayName, @Acronym, @FoundationYear, @UniversityType, @UniversityLogo, @CampusTourLink, @YouTubeLink, @GoogleMapsLink)";
                                SqlCommand cmdInsertPromo = new SqlCommand(queryInsert, con);

                                cmdInsertPromo.Parameters.AddWithValue("@UniversityID", uniId);
                                cmdInsertPromo.Parameters.AddWithValue("@EnglishName", txtUniNameEng.Text);
                                cmdInsertPromo.Parameters.AddWithValue("@MalayName", txtUniNameMalay.Text);
                                cmdInsertPromo.Parameters.AddWithValue("@Acronym", txtUniAcronym.Text);
                                cmdInsertPromo.Parameters.AddWithValue("@FoundationYear", txtFoundYear.Text);
                                cmdInsertPromo.Parameters.AddWithValue("@UniversityType", ddlUniType.SelectedItem.Text);
                                cmdInsertPromo.Parameters.AddWithValue("@UniversityLogo", uniLogoByte);
                                cmdInsertPromo.Parameters.AddWithValue("@CampusTourLink", txtCampusTour.Text);
                                cmdInsertPromo.Parameters.AddWithValue("@YouTubeLink", txtYouTube.Text);
                                cmdInsertPromo.Parameters.AddWithValue("@GoogleMapsLink", txtGoogleMaps.Text);

                                int t = cmdInsertPromo.ExecuteNonQuery();

                                if (t > 0)
                                {
                                    Response.Write("<script>alert('File has been uploaded successfully!')</script>");
                                    clearfn();
                                    // GVbind(); // Uncomment if you want to refresh the GridView or similar control
                                }
                            }
                        }
                        else
                        {
                            lblmsg.Text = "File has to be less than 100 KB!";
                            lblmsg.ForeColor = System.Drawing.Color.Red;
                        }
                    }
                    else
                    {
                        lblmsg.Text = "Only jpg, jpeg, png files are accepted!";
                        lblmsg.ForeColor = System.Drawing.Color.Red;
                    }
                }
                catch (Exception ex)
                {
                    lblmsg.Text = "The file could not be uploaded. The following error occurred: " + ex.Message;
                }
            }
            else
            {
                lblmsg.Text = "Please upload a file.";
                lblmsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        public void clearfn()
        {
            txtUniNameEng.Text = "";
            txtUniNameMalay.Text = "";
            txtUniAcronym.Text = "";
            txtFoundYear.Text = "";
            ddlUniType.SelectedIndex = 0;
            txtCampusTour.Text = "";
            txtYouTube.Text = "";
            txtGoogleMaps.Text = "";
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            clearfn();
        }
    }
}
