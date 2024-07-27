using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniFinder.Management
{
    public partial class AddProgramme : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initialization code if needed
            }
        }

        protected void btnAddUniversity_Click(object sender, EventArgs e)
        {
            try
            {
                using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                {
                    con.Open();

                    // Generate a unique Programme ID in sequence
                    string programmeId = GenerateNextProgrammeId(con);

                    // Initialize the contact string
                    string contact = $"Tel: {txtPhone.Text}";

                    // Check if Fax is not null or empty and append it to the contact string
                    if (!string.IsNullOrEmpty(txtFax.Text))
                    {
                        contact += $"<br/>Fax: {txtFax.Text}";
                    }

                    // Check if Email is not null or empty and append it to the contact string
                    if (!string.IsNullOrEmpty(txtEmail.Text))
                    {
                        contact += $"<br/>Email: {txtEmail.Text}";
                    }

                    // Define the SQL query
                    string queryInsert = "INSERT INTO Programme (programID, programName, programLink, introduction, contact, duration, fees, facLink, uniID, branchID) " +
                                         "VALUES (@ProgrammeID, @ProgrammeName, @ProgrammeLink, @Introduction, @Contact, @Duration, @Fees, @FacultyLink, @UniversityID, @BranchID)";

                    // Create the SQL command
                    SqlCommand cmdInsertProgramme = new SqlCommand(queryInsert, con);

                    // Add parameters to the command
                    cmdInsertProgramme.Parameters.AddWithValue("@ProgrammeID", programmeId);
                    cmdInsertProgramme.Parameters.AddWithValue("@ProgrammeName", txtProgramName.Text);
                    cmdInsertProgramme.Parameters.AddWithValue("@ProgrammeLink", txtPLink.Text);
                    cmdInsertProgramme.Parameters.AddWithValue("@Introduction", txtIntro.Text);
                    cmdInsertProgramme.Parameters.AddWithValue("@Contact", contact); // Use the combined contact string
                    cmdInsertProgramme.Parameters.AddWithValue("@Duration", int.Parse(txtDuration.Text));
                    cmdInsertProgramme.Parameters.AddWithValue("@Fees", int.Parse(txtFees.Text));
                    cmdInsertProgramme.Parameters.AddWithValue("@FacultyLink", txtFacLink.Text);
                    cmdInsertProgramme.Parameters.AddWithValue("@UniversityID", ddlUni.SelectedValue);
                    cmdInsertProgramme.Parameters.AddWithValue("@BranchID", ddlBranch.SelectedValue);

                    int t = cmdInsertProgramme.ExecuteNonQuery();

                    if (t > 0)
                    {
                        Response.Write("<script>alert('Programme has been added successfully!')</script>");
                        ClearFields();
                        Response.Redirect("ProgrammeManagement.aspx");
                    }

                    con.Close();
                }
            }
            catch (Exception ex)
            {
                lblmsg.Text = "The programme could not be added. The following error occurred: " + ex.Message;
                lblmsg.ForeColor = System.Drawing.Color.Red;
            }
        }

        private string GenerateNextProgrammeId(SqlConnection con)
        {
            // Query to get the highest current programme ID
            string query = "SELECT MAX(programID) FROM Programme";
            SqlCommand cmd = new SqlCommand(query, con);
            object result = cmd.ExecuteScalar();

            if (result != DBNull.Value && result != null)
            {
                string lastId = result.ToString();
                int idNumber = int.Parse(lastId.Substring(1)) + 1;
                return "P" + idNumber.ToString("D4");
            }
            else
            {
                // If there are no records, start with P0001
                return "P0001";
            }
        }


        protected void btnCancel_Click(object sender, EventArgs e)
        {
            ClearFields();
        }

        private void ClearFields()
        {
            txtProgramName.Text = "";
            txtPLink.Text = "";
            txtIntro.Text = "";
            txtPhone.Text = "";
            txtFax.Text = "";
            txtEmail.Text = "";
            txtDuration.Text = "";
            txtFees.Text = "";
            txtFacLink.Text = "";
            ddlUni.SelectedIndex = 0;
            ddlBranch.SelectedIndex = 0;
        }
    }
}