using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing.Drawing2D;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniFinder
{
    public partial class AIChatbot : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string criteria = txtCriteria.Text.Trim();
            float maxFees = float.Parse(txtMaxFees.Text.Trim());
            int maxDuration = int.Parse(txtMaxDuration.Text.Trim());

            DatabaseHelper dbHelper = new DatabaseHelper();
            DataTable programData = dbHelper.GetProgramData();

            // Process the user input and apply filtering logic here
            var filteredResults = FilterPrograms(programData, criteria, maxFees, maxDuration);

            // Display the results
            if (filteredResults.Rows.Count > 0)
            {
                lblResults.Text = "Top Programme Recommendations:<br /><br />";
                foreach (DataRow row in filteredResults.Rows)
                {
                    lblResults.Text += $"Program: {row["programName"]}<br />";
                    lblResults.Text += $"Introduction: {row["introduction"]}<br />";
                    lblResults.Text += $"University: {row["uniNameEng"]}<br />";
                    lblResults.Text += $"Location: {row["location"]}<br />";
                    lblResults.Text += $"Duration: {row["duration"]}<br />";
                    lblResults.Text += $"Fees: {row["fees"]}<br /><br />";
                }
                lblResults.Text += "Would you like to continue or end the session?";
                btnContinue.Visible = true;
                btnEnd.Visible = true;
            }
            else
            {
                lblResults.Text = "No programs found matching your criteria. Please try again.";
            }
        }

        protected void btnContinue_Click(object sender, EventArgs e)
        {
            lblResults.Text = "";
            btnContinue.Visible = false;
            btnEnd.Visible = false;
        }

        protected void btnEnd_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "I am happy to be at your service. See you again!";
            txtCriteria.Visible = false;
            txtMaxFees.Visible = false;
            txtMaxDuration.Visible = false;
            btnSubmit.Visible = false;
            btnContinue.Visible = false;
            btnEnd.Visible = false;
        }

        private DataTable FilterPrograms(DataTable programData, string criteria, float maxFees, int maxDuration)
        {
            // Your filtering logic goes here (e.g., text processing, TF-IDF, cosine similarity, etc.)

            // Example: Filtering by max fees and max duration
            var filteredRows = programData.AsEnumerable()
                .Where(row => Convert.ToDouble(row["fees"]) <= maxFees && Convert.ToInt32(row["duration"]) <= maxDuration);

            if (!string.IsNullOrEmpty(criteria))
            {
                // Apply additional text-based filtering here if needed
                // Example: Check if criteria is contained in the program name or introduction
                filteredRows = filteredRows
                    .Where(row => row["programName"].ToString().IndexOf(criteria, StringComparison.OrdinalIgnoreCase) >= 0 ||
                                  row["introduction"].ToString().IndexOf(criteria, StringComparison.OrdinalIgnoreCase) >= 0);
            }

            return filteredRows.CopyToDataTable();
        }
    }
}