using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.Web.UI;
using System.Web;

namespace UniFinder
{
    public partial class Wishlist : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindComparisonData();
            }
        }

        private void BindComparisonData()
        {
            List<string> compareList = Session["CompareList"] as List<string>;

            if (compareList != null && compareList.Count > 0)
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("ProgrammeName");
                dt.Columns.Add("Fees");
                dt.Columns.Add("Location");
                dt.Columns.Add("University");
                dt.Columns.Add("Duration");
                dt.Columns.Add("ProgramID"); // This is used for the CommandArgument
                dt.Columns.Add("uniLogo", typeof(byte[])); // Ensure this column is for byte[]

                foreach (string programId in compareList)
                {
                    DataRow programDetails = GetProgramDetailsById(programId);
                    if (programDetails != null)
                    {
                        DataRow row = dt.NewRow();
                        row["ProgrammeName"] = programDetails["ProgrammeName"];
                        row["Fees"] = programDetails["Fees"];
                        row["Location"] = programDetails["Location"];
                        row["University"] = programDetails["University"];
                        row["Duration"] = programDetails["Duration"];
                        row["ProgramID"] = programId; // Populate ProgramID
                        row["uniLogo"] = programDetails["uniLogo"]; // Populate uniLogo as byte[]
                        dt.Rows.Add(row);
                    }
                }

                // Bind data to the Repeater
                comparisonRepeater.DataSource = dt;
                comparisonRepeater.DataBind();
            }
        }

        private DataRow GetProgramDetailsById(string programId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT u.uniNameEng AS University, u.uniLogo, p.programName AS ProgrammeName, b.location AS Location, p.fees AS Fees, p.duration AS Duration " +
                    "FROM Programme p " +
                    "JOIN University u ON p.uniID = u.uniID " +
                    "JOIN Branch b ON u.uniID = b.uniID " +
                    "WHERE p.programID = @ProgramID", con))
                {
                    cmd.Parameters.AddWithValue("@ProgramID", programId);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        return dt.Rows[0];
                    }
                }
            }

            return null;
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
                return ResolveUrl("~/Images/LogoNew.png");
            }
        }

        protected void RemoveButton_Click(object sender, EventArgs e)
        {
            Button btn = sender as Button;

            if (btn != null)
            {
                string programId = btn.CommandArgument;
                List<string> compareList = Session["CompareList"] as List<string>;

                if (compareList != null)
                {
                    compareList.Remove(programId);
                    Session["CompareList"] = compareList;
                    BindComparisonData();
                }
            }
        }

        protected void imgBtnSelectProgram(object sender, ImageClickEventArgs e)
        {
            ImageButton btn = sender as ImageButton;
            if (btn != null)
            {
                string programNameChosen = btn.AlternateText;
                Response.Redirect($"/ProgrammeDetail.aspx?programName={HttpUtility.UrlEncode(programNameChosen)}");
            }
        }
    }
}
