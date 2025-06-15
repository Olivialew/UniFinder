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

        //private int PageSize
        //{
        //    get { return int.Parse(ddlPageSize.SelectedValue); }
        //}

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ResetFilters();

                BindUniversities(); // Method to bind universities from the database
                BindPrograms();

                if (Session["Wishlist"] == null)
                {
                    Session["Wishlist"] = new List<int>();
                }
                UpdateWishlistLabel();
                UpdatePageNumberLabel();

                // Register the event handler
                ddlSortBy.SelectedIndexChanged += new EventHandler(ddlSortBy_SelectedIndexChanged);
            }

            RestoreCompareState();
        }

        private void BindUniversities()
        {
            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                string query = "SELECT DISTINCT u.uniID, u.uniNameEng FROM University u " +
                    "INNER JOIN Programme p on u.uniID = p.uniID";
                SqlCommand cmd = new SqlCommand(query, conn);
                SqlDataAdapter da = new SqlDataAdapter(cmd);
                DataTable dt = new DataTable();
                da.Fill(dt);

                // Add an "All Universities" option at the top
                DataRow allUniversitiesRow = dt.NewRow();
                allUniversitiesRow["uniID"] = "All"; // Unique identifier for "All"
                allUniversitiesRow["uniNameEng"] = "All Universities";
                dt.Rows.InsertAt(allUniversitiesRow, 0); // Insert at the top

                ddlUni.DataSource = dt;
                ddlUni.DataTextField = "uniNameEng";
                ddlUni.DataValueField = "uniID";
                ddlUni.DataBind();
            }
        }

        private void BindBranches()
        {
            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                string query = "SELECT DISTINCT b.branchID, b.location FROM Branch b " +
                    "INNER JOIN Programme p ON b.branchID = p.branchID " +
                    "WHERE b.uniID = @uniID ORDER BY b.location";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@uniID", ddlUni.SelectedValue);

                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                ddlBranch.Items.Clear();
                ddlBranch.Items.Add(new ListItem("All Branches", "All")); // Ensure "All Branches" is added

                while (dr.Read())
                {
                    string branchID = dr["branchID"].ToString();
                    string location = dr["location"].ToString();
                    ddlBranch.Items.Add(new ListItem(location, branchID));
                }

                dr.Close();
                conn.Close();
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
            CurrentPage = 1;
            BindPrograms();
            UpdatePageNumberLabel();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            ResetFilters();
        }

        protected void ResetFilters()
        {
            txtSearch.Text = string.Empty;
            ddlUni.SelectedIndex = 0; // Default to "All Universities"
            ddlBranch.Items.Clear(); // Clear branch dropdown items
            ddlBranch.Items.Add(new ListItem("All Branches", "All")); // Add "All Branches" option
            ddlBranch.SelectedIndex = 0; // Set default value

            ddlSortBy.SelectedIndex = 0; // Default to first sorting option
            txtMinFees.Text = string.Empty;
            txtMaxFees.Text = string.Empty;
            txtDuration.Text = string.Empty;

            // Reset pagination to the first page
            CurrentPage = 1;

            // Rebind the universities and branches
            BindUniversities();
            BindBranches(); // Ensure this method gets the "All Branches" option

            // Bind programs with default settings (i.e., no filters)
            BindPrograms();

            // Update labels and any other UI elements
            UpdateWishlistLabel();
            UpdatePageNumberLabel();
        }


        private const int pageSize = 12; // Ensure this is set to 12

        PagedDataSource pagedData = new PagedDataSource();

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
                SELECT DISTINCT p.programID, p.programName AS ProgrammeName, u.uniNameEng AS UniversityName, u.uniLogo, p.fees, p.duration, b.location
                FROM Programme p
                JOIN University u ON p.uniID = u.uniID
                LEFT JOIN Branch b ON p.branchID = b.branchID
                WHERE 1=1"; // Ensures the query is always valid

                // Add filters based on user selection
                if (!string.IsNullOrEmpty(searchQuery))
                {
                    query += " AND p.programName LIKE @SearchQuery";
                }

                if (universityFilter != "All") // Filter by university
                {
                    query += " AND u.uniID = @UniversityFilter";
                }

                if (branchFilter != "All") // Filter by branch
                {
                    query += " AND p.branchID = @BranchFilter";
                }

                if (!string.IsNullOrEmpty(minFees))
                {
                    query += " AND p.fees >= @MinFees";
                }

                if (!string.IsNullOrEmpty(maxFees))
                {
                    query += " AND p.fees <= @MaxFees";
                }

                if (!string.IsNullOrEmpty(duration))
                {
                    query += " AND p.duration = @Duration";
                }

                // Sorting
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

                // Add parameters only if their values are provided
                if (!string.IsNullOrEmpty(searchQuery))
                {
                    cmd.Parameters.AddWithValue("@SearchQuery", "%" + searchQuery + "%");
                }

                if (universityFilter != "All")
                {
                    cmd.Parameters.AddWithValue("@UniversityFilter", universityFilter);
                }

                if (branchFilter != "All")
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

                if (dt.Rows.Count == 0)
                {
                    lblNoPrograms.Visible = true;  // Show no results message
                    DataList1.Visible = false;     // Hide DataList
                }
                else
                {
                    lblNoPrograms.Visible = false; // Hide no results message
                    DataList1.Visible = true;      // Show DataList

                    // Implement pagination
                    pagedData.DataSource = dt.DefaultView;
                    pagedData.AllowPaging = true;
                    pagedData.PageSize = pageSize;
                    pagedData.CurrentPageIndex = CurrentPage - 1;

                    DataList1.DataSource = pagedData;
                    DataList1.DataBind();

                    // Update page navigation controls
                    UpdatePageNumberLabel();
                }

                RestoreCompareState();
            }
        }


        protected void ddlSortBy_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindPrograms();
            UpdatePageNumberLabel();
        }

        private void UpdatePageNumberLabel()
        {
            lblPageNumber.Text = $"Page {CurrentPage} of {pagedData.PageCount}";
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

        protected void AddToCompareButton_Click(object sender, EventArgs e)
        {
            Button btn = (Button)sender;
            btn.Text = "Added to Compare";
            btn.CssClass += " greyed-out";
            btn.Enabled = false;

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
                        btn.CssClass += " greyed-out";
                        btn.Enabled = false;
                    }
                }

                // Update hidden field to store compare list
                compareListHiddenField.Value = string.Join(",", compareList);
            }
        }

        protected void CompareButton_Click(object sender, EventArgs e)
        {
            // Ensure compare list is up-to-date
            List<string> compareList = new List<string>(compareListHiddenField.Value.Split(','));
            Session["CompareList"] = compareList;

            // Redirect to Comparison.aspx
            Response.Redirect("~/MyAccount/Wishlist.aspx");
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
                    "WHERE p.programID = @programID", con))
                {
                    cmd.Parameters.AddWithValue("@programID", programId);
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            if (dt.Rows.Count > 0)
            {
                return dt.Rows[0];
            }
            else
            {
                return null;
            }
        }

        protected void ddlUni_SelectedIndexChanged1(object sender, EventArgs e)
        {
            if (ddlUni.SelectedValue == "All") // Assuming "All" represents "All Universities"
            {
                ddlBranch.Enabled = false; // Disable branch dropdown
                ddlBranch.SelectedIndex = 0; // Optionally reset the branch dropdown
            }
            else
            {
                ddlBranch.Enabled = true; // Enable branch dropdown
                //BindBranchesForSelectedUniversity(); // Bind branches for the selected university
                BindBranches(); // Ensure this method populates ddlBranch based on the selected university
            }

            // Bind programs based on the updated dropdown states
            CurrentPage = 1;
            BindPrograms();
            UpdatePageNumberLabel();
        }

        protected void ddlUni_SelectedIndexChanged(object sender, EventArgs e)
        {
            BindBranches(); // Ensure this method populates ddlBranch based on the selected university
            BindPrograms(); // Optionally refresh programs if needed
        }


        private void BindBranchesForSelectedUniversity()
        {
            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                string universityID = ddlUni.SelectedValue;
                string query = "SELECT DISTINCT b.branchID, b.location " +
                               "FROM Branch b " +
                               "JOIN Programme p ON b.branchID = p.branchID " +
                               "WHERE p.uniID = @UniversityID " +
                               "ORDER BY b.location";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@UniversityID", universityID);

                conn.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                ddlBranch.Items.Clear();
                ddlBranch.Items.Add(new ListItem("All Branches", "0")); // Ensure "All Branches" is added

                while (dr.Read())
                {
                    string branchID = dr["branchID"].ToString();
                    string location = dr["location"].ToString();
                    ddlBranch.Items.Add(new ListItem(location, branchID));
                }

                dr.Close();
                conn.Close();
            }
        }

        protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}
