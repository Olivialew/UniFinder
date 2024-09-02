using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing.Printing;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Controls;
using UniFinder.Management;

namespace UniFinder
{
    public partial class Home : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindPrograms();

                DataTable dt = GetFilteredUniversities(null, null, null);
                DataList2.DataSource = dt;
                DataList2.DataBind();
            }
        }

        private void BindPrograms()
        {
            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                string query = @"
                            SELECT DISTINCT TOP 8 p.programID, p.programName AS ProgrammeName, 
                                   u.uniNameEng AS UniversityName, u.uniLogo, p.fees, p.duration, b.location
                            FROM Programme p
                            JOIN University u ON p.uniID = u.uniID
                            LEFT JOIN Branch b ON p.branchID = b.branchID
                            WHERE 1=1";

                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();

                try
                {
                    conn.Open();
                    adapter.Fill(dt);

                    if (dt.Rows.Count > 0)
                    {
                        DataList1.DataSource = dt;
                        DataList1.DataBind();
                    }
                    else
                    {
                        DataList1.DataSource = null;
                        DataList1.DataBind();
                    }
                }
                catch (Exception ex)
                {
                    // Handle the exception (log it, show message, etc.)
                    Console.WriteLine("An error occurred: " + ex.Message);
                }
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

        protected string GetUniName(object uniNameEng, object uniNameMalay)
        {
            string engName = uniNameEng as string;
            string malayName = uniNameMalay as string;

            if (!string.IsNullOrEmpty(engName))
            {
                return engName;
            }
            else if (!string.IsNullOrEmpty(malayName))
            {
                return malayName;
            }
            else
            {
                return "Unknown University"; // Default value if both are null or empty
            }
        }

        protected void imgBtnSelectUni(object sender, ImageClickEventArgs e)
        {
            ImageButton btn = sender as ImageButton;
            if (btn != null)
            {
                string uniNameChosen = btn.AlternateText;
                Response.Redirect($"UniversityDetail.aspx?uniName={HttpUtility.UrlEncode(uniNameChosen)}");
            }
        }

        private DataTable GetFilteredUniversities(string name, string type, string location)
        {
            DataTable dt = new DataTable();

            // Your original query to get data
            string query = "SELECT DISTINCT TOP 8 U.[uniID], U.[uniNameEng], U.[uniNameMalay], U.[uniLogo] " +
                           "FROM [University] U " +
                           "JOIN [Branch] B ON U.uniID = B.uniID " +
                           "WHERE 1=1";

            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            // Use LINQ to remove duplicates based on uniID
            DataTable distinctUniversities = dt.AsEnumerable()
                .GroupBy(row => row.Field<string>("uniID"))
                .Select(g => g.First())
                .CopyToDataTable();

            return distinctUniversities;
        }
    }
}