using System;
using System.Data;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniFinder
{
    public partial class Programme_Management : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        private void BindGrid(string searchQuery = "", string uniID = "", string branchID = "", string minFees = "", string maxFees = "", string duration = "", string sortBy = "")
        {
            string query = "SELECT * FROM [Programme] WHERE (1=1)";

            if (!string.IsNullOrEmpty(searchQuery))
            {
                query += " AND programName LIKE '%' + @searchQuery + '%'";
            }
            if (!string.IsNullOrEmpty(uniID))
            {
                query += " AND uniID = @uniID";
            }
            if (!string.IsNullOrEmpty(branchID))
            {
                query += " AND branchID = @branchID";
            }
            if (!string.IsNullOrEmpty(minFees))
            {
                query += " AND fees >= @minFees";
            }
            if (!string.IsNullOrEmpty(maxFees))
            {
                query += " AND fees <= @maxFees";
            }
            if (!string.IsNullOrEmpty(duration))
            {
                query += " AND duration = @duration";
            }
            if (!string.IsNullOrEmpty(sortBy))
            {
                if (sortBy == "fees_asc")
                {
                    query += " ORDER BY fees ASC";
                }
                else if (sortBy == "fees_desc")
                {
                    query += " ORDER BY fees DESC";
                }
            }

            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    if (!string.IsNullOrEmpty(searchQuery))
                    {
                        cmd.Parameters.AddWithValue("@searchQuery", searchQuery);
                    }
                    if (!string.IsNullOrEmpty(uniID))
                    {
                        cmd.Parameters.AddWithValue("@uniID", uniID);
                    }
                    if (!string.IsNullOrEmpty(branchID))
                    {
                        cmd.Parameters.AddWithValue("@branchID", branchID);
                    }
                    if (!string.IsNullOrEmpty(minFees))
                    {
                        cmd.Parameters.AddWithValue("@minFees", minFees);
                    }
                    if (!string.IsNullOrEmpty(maxFees))
                    {
                        cmd.Parameters.AddWithValue("@maxFees", maxFees);
                    }
                    if (!string.IsNullOrEmpty(duration))
                    {
                        cmd.Parameters.AddWithValue("@duration", duration);
                    }

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    da.Fill(dt);
                    GridView1.DataSource = dt;
                    GridView1.DataBind();
                }
            }
        }

        protected void btnSearch_Click3(object sender, EventArgs e)
        {
            string searchQuery = txtSearch.Text.Trim();
            string uniID = ddlUni.SelectedValue;
            string branchID = ddlBranch.SelectedValue;
            string minFees = txtMinFees.Text.Trim();
            string maxFees = txtMaxFees.Text.Trim();
            string duration = txtDuration.Text.Trim();
            string sortBy = ddlSortBy.SelectedValue;

            BindGrid(searchQuery, uniID, branchID, minFees, maxFees, duration, sortBy);
        }

        protected void btnReset_Click3(object sender, EventArgs e)
        {
            txtSearch.Text = string.Empty;
            ddlUni.SelectedIndex = 0;
            ddlBranch.SelectedIndex = 0;
            txtMinFees.Text = string.Empty;
            txtMaxFees.Text = string.Empty;
            txtDuration.Text = string.Empty;
            ddlSortBy.SelectedIndex = 0;

            BindGrid();
        }


        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.GridView1.RowCancelingEdit += new GridViewCancelEditEventHandler(GridView1_RowCancelingEdit);
            this.GridView1.RowUpdating += new GridViewUpdateEventHandler(GridView1_RowUpdating);
        }

        protected void GridView1_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            GridView1.PageIndex = e.NewPageIndex;
            BindGrid();
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            BindGrid();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridView1.Rows[e.RowIndex];
            string programID = (row.FindControl("lblProgramID") as Label).Text;
            string programName = HttpUtility.HtmlEncode((row.FindControl("txtProgramName") as TextBox).Text);
            string programLink = HttpUtility.HtmlEncode((row.FindControl("txtProgramLink") as TextBox).Text);
            string introduction = HttpUtility.HtmlEncode((row.FindControl("txtIntroduction") as TextBox).Text);
            string contact = HttpUtility.HtmlEncode((row.FindControl("txtContact") as TextBox).Text);
            int duration = int.Parse((row.FindControl("txtDuration") as TextBox).Text);
            int fees = int.Parse((row.FindControl("txtFees") as TextBox).Text);
            string facLink = HttpUtility.HtmlEncode((row.FindControl("txtFacLink") as TextBox).Text);
            string uniID = HttpUtility.HtmlEncode((row.FindControl("txtUniID") as TextBox).Text);
            string branchID = HttpUtility.HtmlEncode((row.FindControl("txtBranchID") as TextBox).Text);

            string query = "UPDATE [Programme] SET programName=@programName, programLink=@programLink, introduction=@introduction, contact=@contact, duration=@duration, fees=@fees, facLink=@facLink, uniID=@uniID, branchID=@branchID WHERE programID=@programID";

            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@programID", programID);
                    cmd.Parameters.AddWithValue("@programName", programName);
                    cmd.Parameters.AddWithValue("@programLink", programLink);
                    cmd.Parameters.AddWithValue("@introduction", introduction);
                    cmd.Parameters.AddWithValue("@contact", contact);
                    cmd.Parameters.AddWithValue("@duration", duration);
                    cmd.Parameters.AddWithValue("@fees", fees);
                    cmd.Parameters.AddWithValue("@facLink", facLink);
                    cmd.Parameters.AddWithValue("@uniID", uniID);
                    cmd.Parameters.AddWithValue("@branchID", branchID);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                    conn.Close();
                }
            }

            GridView1.EditIndex = -1;
            BindGrid();
        }


    }
}