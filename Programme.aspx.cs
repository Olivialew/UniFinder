using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
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
                //DataList1.DataSource = SqlDataSource1;
                // Bind data to DataList1
                DataList1.DataBind();
                //string username = Session["Username"] as string;
            }
        }

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

        protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Handle DataList selection change if needed
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
                //return "~/Images/UniLogo/defaultLogo.png";
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
