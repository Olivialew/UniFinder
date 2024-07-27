using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;

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
            var wishlist = Session["WishlistIds"] as List<int>;
            if (wishlist != null && wishlist.Count > 0)
            {
                using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                {
                    string query = @"
                        SELECT u.uniNameEng AS UniversityName, p.programName AS ProgrammeName, b.location AS Location, p.fees AS Fees, p.duration AS Duration
                        FROM Programme p
                        JOIN University u ON p.uniID = u.uniID
                        JOIN Branch b ON u.uniID = b.uniID
                        WHERE p.programID IN (" + string.Join(",", wishlist) + ")";

                    SqlDataAdapter da = new SqlDataAdapter(query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    // Debugging: Check if DataTable contains data
                    if (dt.Rows.Count > 0)
                    {
                        foreach (DataRow row in dt.Rows)
                        {
                            System.Diagnostics.Debug.WriteLine("Programme Name: " + row["ProgrammeName"]);
                        }
                    }
                    else
                    {
                        System.Diagnostics.Debug.WriteLine("No data found for the given wishlist IDs.");
                    }

                    ComparisonGridView.DataSource = dt;
                    ComparisonGridView.DataBind();
                }
            }
            else
            {
                ComparisonGridView.DataSource = null;
                ComparisonGridView.DataBind();
            }
        }

    }
}