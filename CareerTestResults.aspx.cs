using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Linq;

namespace UniFinder
{
    public partial class CareerTestResults : System.Web.UI.Page
    {
        private Dictionary<string, List<string>> programTypeKeywords = new Dictionary<string, List<string>>()
        {
            { "Engineering or Computer Science", new List<string> { "engineer", "engineering", "computer", "IT" } },
            { "Medical or Biological Sciences", new List<string> { "medical", "biology", "health", "medicine" } },
            { "Humanities or Social Sciences", new List<string> { "humanities", "history", "philosophy", "language" } },
            { "Arts or Design", new List<string> { "arts", "design", "fine arts", "creative" } },
            { "Business or Management", new List<string> { "business", "management", "finance", "marketing" } }
        };

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["QuizResult"] != null)
                {
                    string programType = Session["QuizResult"].ToString();
                    ResultLabel.Text = "Your recommended university program is: " + programType;

                    if (programTypeKeywords.ContainsKey(programType))
                    {
                        List<string> keywords = programTypeKeywords[programType];
                        DataTable dt = GetRecommendedPrograms(keywords);
                        DataList1.DataSource = dt;
                        DataList1.DataBind();
                    }
                    else
                    {
                        ResultLabel.Text = "No recommendations available for the selected program type.";
                    }
                }
                else
                {
                    ResultLabel.Text = "No result available. Please take the quiz first.";
                }
            }
        }

        private DataTable GetRecommendedPrograms(List<string> keywords)
        {
            DataTable dt = new DataTable();
            dt.Columns.Add("uniLogo", typeof(byte[]));
            dt.Columns.Add("ProgrammeName", typeof(string));
            dt.Columns.Add("fees", typeof(int));
            dt.Columns.Add("location", typeof(string));
            dt.Columns.Add("duration", typeof(int));
            dt.Columns.Add("programID", typeof(string));

            // Build the query with dynamic keyword conditions
            string query = @"
                SELECT TOP 5 p.programID, p.programName AS ProgrammeName, u.uniNameEng AS UniversityName, u.uniLogo, p.fees, p.duration, b.location
                FROM Programme p
                JOIN University u ON p.uniID = u.uniID
                LEFT JOIN Branch b ON p.branchID = b.branchID
                WHERE " + string.Join(" OR ", keywords.Select((keyword, index) => $"p.programName LIKE @keyword{index}")) +
                " ORDER BY NEWID()"; // Optional: to randomize the results

            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    // Add parameters for each keyword
                    for (int i = 0; i < keywords.Count; i++)
                    {
                        cmd.Parameters.AddWithValue($"@keyword{i}", $"%{keywords[i]}%");
                    }

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
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
                return ResolveUrl("~/Images/UniLogo/defaultLogo.png");
            }
        }

        protected void imgBtnSelectProgram(object sender, ImageClickEventArgs e)
        {
            ImageButton btn = sender as ImageButton;
            if (btn != null)
            {
                string programNameChosen = btn.AlternateText;
                Response.Redirect($"ProgrammeDetail.aspx?programName={HttpUtility.UrlEncode(programNameChosen)}");
            }
        }

        protected void AddToCompareButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string programId = btn.CommandArgument;
            List<string> compareList = (List<string>)Session["CompareList"] ?? new List<string>();

            if (compareList.Count >= 4)
            {
                lblErrorMessage.Text = "Only up to 4 universities can be added to wishlist.";
                return;
            }

            if (!compareList.Contains(programId))
            {
                compareList.Add(programId);
                Session["CompareList"] = compareList;
                btn.Text = "Added to Compare";
                btn.Enabled = false;

                // Update hidden field to store compare list
                compareListHiddenField.Value = string.Join(",", compareList);
            }
        }

        private void RestoreCompareState()
        {
            List<string> compareList = (List<string>)Session["CompareList"];
            if (compareList != null)
            {
                foreach (DataListItem item in DataList1.Items)
                {
                    Button btn = (Button)item.FindControl("btnAddToCompare");
                    string programId = btn.CommandArgument;

                    if (compareList.Contains(programId))
                    {
                        btn.Text = "Added to Compare";
                        btn.Enabled = false;
                    }
                }

                // Update hidden field to store compare list
                compareListHiddenField.Value = string.Join(",", compareList);
            }
        }
    }
}
