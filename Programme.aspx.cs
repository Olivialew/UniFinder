using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniFinder
{
    public partial class Programme : System.Web.UI.Page
    {
        private int CurrentPage
        {
            get { return (int)(ViewState["CurrentPage"] ?? 1); }
            set { ViewState["CurrentPage"] = value; }
        }

        private int PageSize
        {
            get { return int.Parse(ddlPageSize.SelectedValue); }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindPrograms();
                if (Session["Wishlist"] == null)
                {
                    Session["Wishlist"] = new List<int>();
                }
                UpdateWishlistLabel();
                UpdatePageNumberLabel();
            }
        }

        protected void btnPrevious_Click(object sender, EventArgs e)
        {
            if (CurrentPage > 1)
            {
                CurrentPage--;
                BindPrograms();
                UpdatePageNumberLabel();
            }
        }

        protected void btnNext_Click(object sender, EventArgs e)
        {
            CurrentPage++;
            BindPrograms();
            UpdatePageNumberLabel();
        }

        protected void ddlPageSize_SelectedIndexChanged(object sender, EventArgs e)
        {
            CurrentPage = 1;
            BindPrograms();
            UpdatePageNumberLabel();
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            BindPrograms();
            UpdatePageNumberLabel();
        }

        protected void btnFilter_Click(object sender, EventArgs e)
        {
            BindPrograms();
            UpdatePageNumberLabel();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            // Clear search box
            txtSearch.Text = string.Empty;

            // Reset dropdowns to default values
            ddlUni.SelectedIndex = 0;
            ddlBranch.SelectedIndex = 0;
            ddlSortBy.SelectedIndex = 0;

            // Clear text boxes for numerical filters
            txtMinFees.Text = string.Empty;
            txtMaxFees.Text = string.Empty;
            txtDuration.Text = string.Empty;

            // Reset page to the first page
            CurrentPage = 1;

            // Rebind programs with the cleared filters and reset sorting
            BindPrograms();
            UpdatePageNumberLabel();
        }

        private void BindPrograms()
        {
            string searchQuery = txtSearch.Text.Trim();
            string universityFilter = ddlUni.SelectedValue;
            string branchFilter = ddlBranch.SelectedValue;
            string minFees = txtMinFees.Text.Trim();
            string maxFees = txtMaxFees.Text.Trim();
            string duration = txtDuration.Text.Trim();
            string sortOrder = ddlSortBy.SelectedValue;

            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                string query = @"
                    SELECT p.programID, p.programName AS ProgrammeName, u.uniNameEng AS UniversityName, u.uniLogo, p.fees, p.duration
                    FROM Programme p
                    JOIN University u ON p.uniID = u.uniID
                    WHERE 1=1";

                // Apply search filter
                if (!string.IsNullOrEmpty(searchQuery))
                {
                    query += " AND p.programName LIKE @SearchQuery";
                }

                // Apply university filter
                if (!string.IsNullOrEmpty(universityFilter) && universityFilter != "0")
                {
                    query += " AND u.uniID = @UniversityFilter";
                }

                // Apply branch filter
                if (!string.IsNullOrEmpty(branchFilter) && branchFilter != "0")
                {
                    query += " AND p.branchID = @BranchFilter";
                }

                // Apply fee filters
                if (!string.IsNullOrEmpty(minFees))
                {
                    query += " AND p.fees >= @MinFees";
                }
                if (!string.IsNullOrEmpty(maxFees))
                {
                    query += " AND p.fees <= @MaxFees";
                }

                // Apply duration filter
                if (!string.IsNullOrEmpty(duration))
                {
                    query += " AND p.duration = @Duration";
                }

                // Apply sorting
                switch (sortOrder)
                {
                    case "fees_desc":
                        query += " ORDER BY p.fees DESC";
                        break;
                    case "fees_asc":
                        query += " ORDER BY p.fees ASC";
                        break;
                    default:
                        query += " ORDER BY p.programName ASC";
                        break;
                }

                SqlCommand cmd = new SqlCommand(query, conn);
                if (!string.IsNullOrEmpty(searchQuery))
                {
                    cmd.Parameters.AddWithValue("@SearchQuery", "%" + searchQuery + "%");
                }
                if (!string.IsNullOrEmpty(universityFilter) && universityFilter != "0")
                {
                    cmd.Parameters.AddWithValue("@UniversityFilter", universityFilter);
                }
                if (!string.IsNullOrEmpty(branchFilter) && branchFilter != "0")
                {
                    cmd.Parameters.AddWithValue("@BranchFilter", branchFilter);
                }
                if (!string.IsNullOrEmpty(minFees))
                {
                    cmd.Parameters.AddWithValue("@MinFees", minFees);
                }
                if (!string.IsNullOrEmpty(maxFees))
                {
                    cmd.Parameters.AddWithValue("@MaxFees", maxFees);
                }
                if (!string.IsNullOrEmpty(duration))
                {
                    cmd.Parameters.AddWithValue("@Duration", duration);
                }

                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                DataList1.DataSource = dt;
                DataList1.DataBind();
            }
        }

        protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
        {
            if (e.CommandName == "AddToWishlist")
            {
                int programmeId = Convert.ToInt32(e.CommandArgument);
                var wishlist = Session["Wishlist"] as List<int>;

                if (wishlist == null)
                {
                    wishlist = new List<int>();
                    Session["Wishlist"] = wishlist;
                }

                if (wishlist.Count < 4)
                {
                    if (!wishlist.Contains(programmeId))
                    {
                        wishlist.Add(programmeId);
                    }
                }
                UpdateWishlistLabel();
            }
        }

        protected void CompareButton_Click(object sender, EventArgs e)
        {
            var wishlist = Session["Wishlist"] as List<int>;
            Session["WishlistIds"] = wishlist;
            Response.Redirect("~/MyAccount/Wishlist.aspx");
        }

        private void UpdateWishlistLabel()
        {
            var wishlist = Session["Wishlist"] as List<int>;
            var wishlistNames = new List<string>();

            if (wishlist != null && wishlist.Count > 0)
            {
                using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                {
                    string query = @"
                    SELECT p.programName
                    FROM Programme p
                    WHERE p.programID IN (" + string.Join(",", wishlist) + ")";

                    SqlDataAdapter da = new SqlDataAdapter(query, conn);
                    DataTable dt = new DataTable();
                    da.Fill(dt);

                    foreach (DataRow row in dt.Rows)
                    {
                        wishlistNames.Add(row["programName"].ToString());
                    }
                }
            }
            else
            {
                WishlistLabel.Text = "Wishlist: (empty)";
            }

            WishlistLabel.Text = "Wishlist: " + string.Join(", ", wishlistNames);
            WishlistCount.Value = wishlist.Count.ToString();
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

        private void UpdatePageNumberLabel()
        {
            lblPageNumber.Text = "Page " + CurrentPage.ToString();
        }
    }
}
