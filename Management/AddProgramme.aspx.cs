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

                    // Get the record number to generate programme id
                    string queryCount = "SELECT COUNT(*) FROM Programme";
                    SqlCommand cmdCountProgramme = new SqlCommand(queryCount, con);

                    int recordCount = (int)cmdCountProgramme.ExecuteScalar();
                    recordCount++;

                    string programmeId = "P" + recordCount.ToString("D4");

                    string queryInsert = "INSERT INTO Programme (programmeID, programmeName, programmeLink, introduction, phone, fax, email, duration, fees, facultyLink, universityID, branchID) " +
                                         "VALUES (@ProgrammeID, @ProgrammeName, @ProgrammeLink, @Introduction, @Phone, @Fax, @Email, @Duration, @Fees, @FacultyLink, @UniversityID, @BranchID)";
                    SqlCommand cmdInsertProgramme = new SqlCommand(queryInsert, con);

                    cmdInsertProgramme.Parameters.AddWithValue("@ProgrammeID", programmeId);
                    cmdInsertProgramme.Parameters.AddWithValue("@ProgrammeName", txtProgramName.Text);
                    cmdInsertProgramme.Parameters.AddWithValue("@ProgrammeLink", txtPLink.Text);
                    cmdInsertProgramme.Parameters.AddWithValue("@Introduction", txtIntro.Text);
                    cmdInsertProgramme.Parameters.AddWithValue("@Phone", txtPhone.Text);
                    cmdInsertProgramme.Parameters.AddWithValue("@Fax", txtFax.Text);
                    cmdInsertProgramme.Parameters.AddWithValue("@Email", txtEmail.Text);
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
                }
            }
            catch (Exception ex)
            {
                lblmsg.Text = "The programme could not be added. The following error occurred: " + ex.Message;
                lblmsg.ForeColor = System.Drawing.Color.Red;
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