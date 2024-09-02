using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

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
                    // Display error using label instead of MessageBox
                    lblErrorMessage.Text = "Error: No program selected.";
                }

                // Initialize the CompareList session if it's null
                if (Session["CompareList"] == null)
                {
                    Session["CompareList"] = new List<string>();
                }

                RestoreCompareState();
            }
        }

        private void GetProgramDetails(string programNameChosen)
        {
            try
            {
                string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
                string query = "SELECT P.programID, P.programName, U.uniNameEng, U.uniLogo, B.location, P.introduction, P.contact, P.duration, P.fees, P.programLink, P.facLink " +
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
                            // Populate labels with the program details
                            lblProgramName.Text = reader["programName"].ToString();
                            lblUniversity.Text = reader["uniNameEng"].ToString();
                            lblLocation.Text = reader["location"].ToString();
                            lblProgrammeIntro.Text = reader["introduction"].ToString();
                            lblProgrammeContact.Text = reader["contact"].ToString();
                            lblProgrammeDuration.Text = reader["duration"].ToString();
                            lblTuitionFee.Text = reader["fees"].ToString();
                            hlProgramLink.NavigateUrl = reader["programLink"].ToString();
                            hlFacLink.NavigateUrl = reader["facLink"].ToString();

                            // Set university logo if available
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

                            // Set the program ID as the CommandArgument for the button
                            btnAddToCompare.CommandArgument = reader["programID"].ToString();
                        }
                        else
                        {
                            // Error handling - use label for messages
                            lblErrorMessage.Text = "Programme not found.";
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                // Handle exception using label
                lblErrorMessage.Text = "An error occurred while retrieving the program details.";
            }
        }

        protected void AddToCompareButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string programId = btn.CommandArgument;

            // Retrieve the CompareList from the session
            List<string> compareList = (List<string>)Session["CompareList"] ?? new List<string>();

            // Check if the program is already in the comparison list
            if (compareList.Contains(programId))
            {
                lblErrorMessage.Text = "This program is already in your compare list.";
                return;
            }

            // Check if the compare list has reached its limit
            if (compareList.Count >= 4)
            {
                lblErrorMessage.Text = "Only up to 4 universities can be added to wishlist.";
                return;
            }

            // If not already in the list and under the limit, add it to the list
            compareList.Add(programId);
            Session["CompareList"] = compareList; // Save back to session

            // Update the button state
            btn.Text = "Added to Compare";
            btn.CssClass += " greyed-out";
            btn.Enabled = false;

            // Update hidden field to store compare list
            compareListHiddenField.Value = string.Join(",", compareList);
        }

        private void RestoreCompareState()
        {
            List<string> compareList = (List<string>)Session["CompareList"];
            if (compareList != null && btnAddToCompare.CommandArgument != string.Empty)
            {
                // Check if the program is in the compare list
                if (compareList.Contains(btnAddToCompare.CommandArgument))
                {
                    btnAddToCompare.Text = "Added to Compare";
                    btnAddToCompare.CssClass += " greyed-out";
                    btnAddToCompare.Enabled = false;
                }

                // Update hidden field to store compare list
                compareListHiddenField.Value = string.Join(",", compareList);
            }
        }
    }
}
