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
                //DataList1.DataSource = SqlDataSource1;
                // Bind data to DataList1
                DataList1.DataBind();
                //string username = Session["Username"] as string;
                //Session["Wishlist"] = new List<int>();
                //UpdateWishlistLabel();
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

        //        UpdateWishlistLabel();
        //    }
        //}

        //protected void CompareButton_Click(object sender, EventArgs e)
        //{
        //    var wishlist = Session["Wishlist"] as List<int>;
        //    Session["WishlistIds"] = wishlist;
        //    Response.Redirect("Wishlist.aspx");
        //}

        //private void UpdateWishlistLabel()
        //{
        //    var wishlist = Session["Wishlist"] as List<int>;
        //    WishlistLabel.Text = "Wishlist: " + string.Join(", ", wishlist);
        //    WishlistCount.Value = wishlist.Count.ToString();
        //}


        //protected override void Render(HtmlTextWriter writer)
        //{
        //    // Register btnSearch for event validation
        //    ClientScript.RegisterForEventValidation(btnSearch.UniqueID);

        //    // Register each ImageButton within DataList1 for event validation
        //    foreach (DataListItem item in DataList1.Items)
        //    {
        //        ImageButton imgBtn = item.FindControl("imgUni") as ImageButton;
        //        if (imgBtn != null)
        //        {
        //            ClientScript.RegisterForEventValidation(imgBtn.UniqueID);
        //        }
        //    }

        //    base.Render(writer);
        //}

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

        //protected void ddlMovieStatus_SelectedIndexChanged(object sender, EventArgs e)
        //{
        //    BindMovies();
        //}

        //private void BindMovies()
        //{
        //    try
        //    {
        //        string status = ddlMovieStatus.SelectedValue;
        //        string searchString = txtSearch.Text.Trim();
        //        string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        //        string query;

        //        if (status == "All")
        //        {
        //            query = "SELECT title, poster, status FROM Movie ORDER BY status";
        //        }
        //        else
        //        {
        //            query = "SELECT title, poster, status FROM Movie WHERE status = @Status ORDER BY status";
        //        }

        //        using (SqlConnection connection = new SqlConnection(connectionString))
        //        {
        //            using (SqlCommand command = new SqlCommand(query, connection))
        //            {
        //                if (status != "All")
        //                {
        //                    command.Parameters.AddWithValue("@Status", status);
        //                    command.Parameters.AddWithValue("@SearchQuery", searchString);

        //                }

        //                connection.Open();
        //                SqlDataReader reader = command.ExecuteReader();

        //                DataList1.DataSource = reader;
        //                DataList1.DataBind();
        //            }
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        // Handle exception
        //    }
        //}

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchQuery = txtSearch.Text.Trim();
            // Call method to get program details based on search query
            // GetProgramDetails(searchQuery);
        }

        // Example method to get program details (uncomment if needed)
        // private void GetProgramDetails(string programNameChosen)
        // {
        //     // Implementation to fetch program details from the database
        // }
    }
}