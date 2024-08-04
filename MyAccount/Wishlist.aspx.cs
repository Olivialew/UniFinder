using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Configuration;

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
            List<string> compareList = (List<string>)Session["CompareList"];

            if (compareList != null && compareList.Count > 0)
            {
                DataTable dt = new DataTable();
                dt.Columns.Add("ProgrammeName");
                dt.Columns.Add("Fees");
                dt.Columns.Add("Location");
                dt.Columns.Add("University");
                dt.Columns.Add("Duration");

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
                        dt.Rows.Add(row);
                    }
                }

                comparisonGridView.DataSource = dt;
                comparisonGridView.DataBind();
            }
        }

        private DataRow GetProgramDetailsById(string programId)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(
                    "SELECT u.uniNameEng AS University, p.programName AS ProgrammeName, b.location AS Location, p.fees AS Fees, p.duration AS Duration " +
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

        protected void RemoveButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            string programName = btn.CommandArgument;
            List<string> compareList = (List<string>)Session["CompareList"];

            if (compareList != null)
            {
                compareList.RemoveAll(id => GetProgramDetailsById(id)["ProgrammeName"].ToString() == programName);
                Session["CompareList"] = compareList;
                BindComparisonData();
            }
        }

        //private void BindComparisonData()
        //{
        //    var wishlist = Session["WishlistIds"] as List<int>;
        //    if (wishlist != null && wishlist.Count > 0)
        //    {
        //        using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        //        {
        //            string query = @"
        //                SELECT u.uniNameEng AS UniversityName, p.programName AS ProgrammeName, b.location AS Location, p.fees AS Fees, p.duration AS Duration
        //                FROM Programme p
        //                JOIN University u ON p.uniID = u.uniID
        //                JOIN Branch b ON u.uniID = b.uniID
        //                WHERE p.programID IN (" + string.Join(",", wishlist) + ")";

        //            SqlDataAdapter da = new SqlDataAdapter(query, conn);
        //            DataTable dt = new DataTable();
        //            da.Fill(dt);

        //            // Debugging: Check if DataTable contains data
        //            if (dt.Rows.Count > 0)
        //            {
        //                foreach (DataRow row in dt.Rows)
        //                {
        //                    System.Diagnostics.Debug.WriteLine("Programme Name: " + row["ProgrammeName"]);
        //                }
        //            }
        //            else
        //            {
        //                System.Diagnostics.Debug.WriteLine("No data found for the given wishlist IDs.");
        //            }

        //            ComparisonGridView.DataSource = dt;
        //            ComparisonGridView.DataBind();
        //        }
        //    }
        //    else
        //    {
        //        ComparisonGridView.DataSource = null;
        //        ComparisonGridView.DataBind();
        //    }
        //}

    }
}