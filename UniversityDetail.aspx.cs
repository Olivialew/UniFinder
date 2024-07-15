using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniFinder
{
    public partial class UniversityDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string uniName = Request.QueryString["uniName"];
                if (!string.IsNullOrEmpty(uniName))
                {
                    GetUniDetails(uniName);
                }
                else
                {
                    // Handle error: no university selected
                    Response.Write("<script>alert('Error: No university selected.');</script>");
                }
            }
        }

        private void GetUniDetails(string uniNameChosen)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                string query =
                    "SELECT uniNameEng, uniNameMalay, uniAcronym, foundationYear, uniType, uniLogo, campusTourLink, youtubeLink, googleMapsLink " +
                    "FROM University " +
                    "WHERE uniNameEng = @UniName";

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@UniName", uniNameChosen);

                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();

                        if (reader.Read())
                        {
                            lblUniNameEng.Text = reader["uniNameEng"].ToString();
                            lblUniNameMalay.Text = reader["uniNameMalay"].ToString();
                            lblUniAcronym.Text = reader["uniAcronym"].ToString();
                            lblFoundationYear.Text = reader["foundationYear"].ToString();
                            lblUniType.Text = reader["uniType"].ToString();

                            // Set the university logo
                            if (reader["uniLogo"] != DBNull.Value)
                            {
                                byte[] uniLogoBytes = (byte[])reader["uniLogo"];
                                string uniLogoBase64 = Convert.ToBase64String(uniLogoBytes);
                                imgUniversityLogo.ImageUrl = "data:image/jpeg;base64," + uniLogoBase64;
                            }
                            else
                            {
                                imgUniversityLogo.ImageUrl = "~/Images/defaultLogo.jpg";
                            }

                            // Set the Google Maps iframe
                            if (reader["googleMapsLink"] != DBNull.Value && !string.IsNullOrEmpty(reader["googleMapsLink"].ToString()))
                            {
                                string googleMapsUrl = reader["googleMapsLink"].ToString();
                                ltGoogleMaps.Text = $"<iframe width='900' height='600' src='{googleMapsUrl}' style='border:0;' allowfullscreen='' loading='lazy' referrerpolicy='no-referrer-when-downgrade'></iframe>";
                            }
                            else
                            {
                                ltGoogleMaps.Text = "<p>Google Maps not available.</p>";
                            }

                            // Set the campus tour iframe
                            if (reader["campusTourLink"] != DBNull.Value && !string.IsNullOrEmpty(reader["campusTourLink"].ToString()))
                            {
                                string campusTourUrl = reader["campusTourLink"].ToString();
                                ltCampusTour.Text = $"<iframe width='900' height='600' src='{campusTourUrl}' style='border:0;' allowfullscreen='' loading='lazy' referrerpolicy='no-referrer-when-downgrade'></iframe>";
                            }
                            else
                            {
                                ltCampusTour.Text = "<p>Campus tour not available.</p>";
                            }

                            // Set the YouTube video iframe
                            if (reader["youtubeLink"] != DBNull.Value && !string.IsNullOrEmpty(reader["youtubeLink"].ToString()))
                            {
                                string youtubeUrl = reader["youtubeLink"].ToString();
                                ltYouTubeVideo.Text = $"<iframe width='900' height='600' src='{youtubeUrl}' frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share' allowfullscreen></iframe>";
                            }
                            else
                            {
                                ltYouTubeVideo.Text = "<p>YouTube video not available.</p>";
                            }
                        }
                        else
                        {
                            // Handle error: university not found
                            Response.Write("<script>alert('Error: University not found.');</script>");
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exception
                Response.Write($"<script>alert('Error: An error occurred while retrieving the university details. {ex.Message}');</script>");
            }
        }
    }
}
