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
            }
        }

        private void BindPrograms()
        {
            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                string query = @"
                    SELECT p.programID, p.programName AS ProgrammeName, u.uniNameEng AS UniversityName, u.uniLogo, p.fees, p.duration
                    FROM Programme p
                    JOIN University u ON p.uniID = u.uniID";
                SqlDataAdapter da = new SqlDataAdapter(query, conn);
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

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string searchQuery = txtSearch.Text.Trim();
            // Call method to get program details based on search query
            // GetProgramDetails(searchQuery);
        }
    }
}
