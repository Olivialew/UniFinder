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
                DataTable dt = GetFilteredUniversities(null, null, null);
                DataList1.DataSource = dt;
                DataList1.DataBind();
            }
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
            string selectedType = ddlUniType.SelectedValue;
            string selectedLocation = ddlLocation.SelectedValue;

            DataTable dt = GetFilteredUniversities(searchQuery, selectedType, selectedLocation);
            DataList1.DataSource = dt;
            DataList1.DataBind();
        }


        protected void btnReset_Click(object sender, EventArgs e)
        {
            txtSearch.Text = string.Empty;
            ddlUniType.SelectedIndex = 0;
            ddlLocation.SelectedIndex = 0;

            DataTable dt = GetFilteredUniversities(null, null, null);
            DataList1.DataSource = dt;
            DataList1.DataBind();
        }


        private DataTable GetFilteredUniversities(string name, string type, string location)
        {
            DataTable dt = new DataTable();

            string query = "SELECT U.[uniNameEng], U.[uniNameMalay], U.[uniLogo] " +
                           "FROM [University] U " +
                           "JOIN [Branch] B ON U.uniID = B.uniID " +
                           "WHERE (@uniNameEng IS NULL OR U.[uniNameEng] LIKE '%' + @uniNameEng + '%') " +
                           "AND (@uniType IS NULL OR U.[uniType] = @uniType) " +
                           "AND (@location IS NULL OR B.location = @location)";

            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@uniNameEng", string.IsNullOrEmpty(name) ? (object)DBNull.Value : name);
                    cmd.Parameters.AddWithValue("@uniType", string.IsNullOrEmpty(type) ? (object)DBNull.Value : type);
                    cmd.Parameters.AddWithValue("@location", string.IsNullOrEmpty(location) ? (object)DBNull.Value : location);

                    SqlDataAdapter da = new SqlDataAdapter(cmd);
                    da.Fill(dt);
                }
            }

            return dt;
        }

    }
}