using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Windows.Controls;
using System.Web.Configuration;

namespace UniFinder
{
    public partial class University : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Bind dropdown lists
                BindDropdowns();

                // Display all universities by default
                DisplayUniversities(string.Empty, string.Empty, string.Empty);
            }
        }

        private void BindDropdowns()
        {
            // Bind university types to ddlUniType
            DataTable universityTypes = GetUniversityTypes();
            ddlUniType.DataSource = universityTypes;
            ddlUniType.DataTextField = "uniType";
            ddlUniType.DataValueField = "uniType";
            ddlUniType.DataBind();
            ddlUniType.Items.Insert(0, new ListItem("All University Types", "")); // Default to show all types

            // Bind branch locations to ddlLocation
            DataTable branchLocations = GetBranchLocations();
            ddlLocation.DataSource = branchLocations;
            ddlLocation.DataTextField = "location";
            ddlLocation.DataValueField = "location";
            ddlLocation.DataBind();
            ddlLocation.Items.Insert(0, new ListItem("All Branches", "")); // Default to show all branches
        }

        private void DisplayUniversities(string name, string type, string location)
        {
            DataTable dt = GetFilteredUniversities(name, type, location);
            DataList1.DataSource = dt;
            DataList1.DataBind();
        }



        //private void BindUniversities()
        //{
        //    using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        //    {
        //        SqlDataAdapter da = new SqlDataAdapter("SELECT uniID, uniNameEng FROM University", conn);
        //        DataTable dt = new DataTable();
        //        da.Fill(dt);
        //        DataList1.DataSource = dt;
        //        DataList1.DataBind();
        //    }
        //}

        //protected void UniversitiesGridView_RowCommand(object sender, GridViewCommandEventArgs e)
        //{
        //    if (e.CommandName == "AddToWishlist")
        //    {
        //        int universityId = Convert.ToInt32(e.CommandArgument);
        //        var wishlist = Session["Wishlist"] as List<int>;

        //        if (wishlist.Count < 4)
        //        {
        //            if (!wishlist.Contains(universityId))
        //            {
        //                wishlist.Add(universityId);
        //            }
        //        }

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


        protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Handle DataList selection change if needed
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

        protected string GetImageUrl(object uniLogo)
        {
            if (uniLogo != DBNull.Value && uniLogo != null)
            {
                byte[] bytes = (byte[])uniLogo;
                return "data:image/png;base64," + Convert.ToBase64String(bytes);
            }
            else
            {
                //return ResolveUrl("~/Images/LogoNew.png");
                return ResolveUrl("~/Images/UniLogo/defaultLogo.png");
            }
        }
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchQuery = txtSearch.Text.Trim();
            System.Diagnostics.Debug.WriteLine($"Search Query: {searchQuery}");

            string selectedType = ddlUniType.SelectedValue;
            string selectedLocation = ddlLocation.SelectedValue;

            // Log or debug values to check
            System.Diagnostics.Debug.WriteLine($"Search Query: {searchQuery}");
            System.Diagnostics.Debug.WriteLine($"Selected Type: {selectedType}");
            System.Diagnostics.Debug.WriteLine($"Selected Location: {selectedLocation}");

            DataTable dt = GetFilteredUniversities(searchQuery, selectedType, selectedLocation);

            if (dt.Rows.Count == 0)
            {
                lblNoResults.Visible = true;
                lblNoResults.Text = "No universities found matching your criteria.";
            }
            else
            {
                lblNoResults.Visible = false;
                DataList1.DataSource = dt;
                DataList1.DataBind();
            }
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            // Clear search text and reset dropdowns
            txtSearch.Text = string.Empty;
            ddlUniType.SelectedIndex = 0; // Default value
            ddlLocation.SelectedIndex = 0; // Default value
            lblNoResults.Text = string.Empty;

            // Fetch all universities when filters are reset
            DataTable dt = GetFilteredUniversities(null, null, null);

            // Bind the DataList with the fetched data
            DataList1.DataSource = dt;
            DataList1.DataBind();

            // Optionally, you can display a message if no results found
            if (dt.Rows.Count == 0)
            {
                lblNoResults.Visible = true;
                lblNoResults.Text = "No universities found.";
            }
            else
            {
                lblNoResults.Visible = false;
            }
        }

        protected DataTable GetFilteredUniversities(string name, string type, string location)
        {
            DataTable dt = new DataTable();
            string query = "SELECT DISTINCT U.[uniID], U.[uniNameEng], U.[uniNameMalay], U.[uniLogo] " +
                           "FROM [University] U " +
                           "JOIN [Branch] B ON U.uniID = B.uniID " +
                           "WHERE (@uniNameEng IS NULL OR U.[uniNameEng] LIKE '%' + @uniNameEng + '%') " +
                           "AND (@uniType = '' OR U.[uniType] = @uniType) " +
                           "AND (@location = '' OR B.location = @location)";

            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@uniNameEng", string.IsNullOrEmpty(name) ? (object)DBNull.Value : name);
                    cmd.Parameters.AddWithValue("@uniType", string.IsNullOrEmpty(type) ? string.Empty : type);
                    cmd.Parameters.AddWithValue("@location", string.IsNullOrEmpty(location) ? string.Empty : location);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);

                    try
                    {
                        da.Fill(dt);
                    }
                    catch (Exception ex)
                    {
                        System.Diagnostics.Debug.WriteLine($"Error filling DataTable: {ex.Message}");
                    }
                }
            }

            // Remove duplicates without LINQ
            DataTable distinctTable = dt.Clone();
            HashSet<string> seenUniIDs = new HashSet<string>();

            foreach (DataRow row in dt.Rows)
            {
                string uniID = row["uniID"].ToString();
                if (!seenUniIDs.Contains(uniID))
                {
                    seenUniIDs.Add(uniID);
                    distinctTable.ImportRow(row);
                }
            }

            return distinctTable;
        }

        private DataTable GetUniversityTypes()
        {
            DataTable dt = new DataTable();
            string query = "SELECT DISTINCT uniType FROM [University]";

            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

        private DataTable GetBranchLocations()
        {
            DataTable dt = new DataTable();
            string query = "SELECT DISTINCT location FROM [Branch]";

            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

    }
}