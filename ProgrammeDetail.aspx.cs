using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows;
using System.Windows.Forms;

namespace UniFinder
{
    public partial class ProgrammeDetail : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string programName = Request.QueryString["programName"];
                if (!string.IsNullOrEmpty(programName))
                {
                    GetProgramDetails(programName);
                }
                else
                {
                    System.Windows.Forms.MessageBox.Show("Error", "No program selected.", MessageBoxButtons.OK, MessageBoxIcon.Error);
                }
            }
        }

        private void GetProgramDetails(string programNameChosen)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                string query =
                    "SELECT P.programName, U.uniNameEng, U.uniLogo, B.location, P.introduction, P.contact, P.duration, P.fees, P.programLink, P.facLink " +
                    "FROM Programme P, University U, Branch B " +
                    "WHERE U.uniID = P.uniID AND P.branchID = B.branchID AND P.programName = @Title";

                using (SqlConnection connection = new SqlConnection(connectionString))
                {
                    using (SqlCommand command = new SqlCommand(query, connection))
                    {
                        command.Parameters.AddWithValue("@Title", programNameChosen);

                        connection.Open();
                        SqlDataReader reader = command.ExecuteReader();

                        if (reader.Read())
                        {
                            lblProgramName.Text = reader["programName"].ToString();
                            lblUniversity.Text = reader["uniNameEng"].ToString(); //from uni
                            lblLocation.Text = reader["location"].ToString(); //from branch
                            lblProgrammeIntro.Text = reader["introduction"].ToString();
                            lblProgrammeContact.Text = reader["contact"].ToString();
                            lblProgrammeDuration.Text = reader["duration"].ToString();
                            lblTuitionFee.Text = reader["fees"].ToString();
                            hlProgramLink.NavigateUrl = reader["programLink"].ToString();
                            hlFacLink.NavigateUrl = reader["facLink"].ToString();

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
                        }
                        else
                        {
                            System.Windows.Forms.MessageBox.Show("Error", "Programme not found.", MessageBoxButtons.OK, MessageBoxIcon.Error);
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exception
                System.Windows.Forms.MessageBox.Show("Error", "An error occurred while retrieving the program details.", MessageBoxButtons.OK, MessageBoxIcon.Error);
            }
        }

        private void ClearProgramDetails()
        {
            lblProgramName.Text = "";
            lblUniversity.Text = "";
            lblLocation.Text = "";
            lblProgrammeIntro.Text = "";
            lblProgrammeContact.Text = "";
            lblProgrammeDuration.Text = "";
            lblTuitionFee.Text = "";
            hlProgramLink.NavigateUrl = string.Empty;
            hlFacLink.NavigateUrl = string.Empty;
        }

        protected string GetImageUrl(object uniLogo)
        {
            if (uniLogo != DBNull.Value && uniLogo != null)
            {
                byte[] bytes = (byte[])uniLogo;
                return "data:image/jpeg;base64," + Convert.ToBase64String(bytes);
            }
            else
            {
                return "~/Images/defaultLogo.jpg";
            }
        }
    }
}