using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Practical_5
{
    public partial class LoginPage : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {
            System.Diagnostics.Debug.WriteLine(Login1.UserName,Login1.Password);
            if (Membership.ValidateUser(Login1.UserName, Login1.Password))
            {
                FormsAuthentication.SetAuthCookie(Login1.UserName, Login1.RememberMeSet);

                string userType = GetUserRole(Login1.UserName);

                if (!string.IsNullOrEmpty(userType))
                {
                    Session["UserType"] = userType;
                    Session["Username"] = Login1.UserName;

                    if (userType == "admin")
                    {
                        Response.Redirect("/Management/HomeAdmin.aspx");
                    }
                    else if (userType == "student")
                    {
                        Response.Redirect("Home.aspx");
                    }
                }
            }
            else
            {
                Login1.FailureText = "Invalid username or password.";
            }
        }

        public string GetUserRole(string username)
        {
            string role = null;
            using (SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                string query = @"
                    SELECT r.RoleName 
                    FROM aspnet_Users u
                    INNER JOIN aspnet_UsersInRoles ur ON u.UserId = ur.UserId
                    INNER JOIN aspnet_Roles r ON ur.RoleId = r.RoleId
                    WHERE u.UserName = @Username";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@Username", username);

                con.Open();
                SqlDataReader reader = cmd.ExecuteReader();
                if (reader.Read())
                {
                    role = reader["RoleName"].ToString();
                }
            }
            return role;
        }
    }
}
