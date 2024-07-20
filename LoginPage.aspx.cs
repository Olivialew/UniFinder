using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Practical_5
{
    public partial class LoginPage : System.Web.UI.Page
    {
        private string connectionString = "ConnectionString";

        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void Login1_Authenticate(object sender, AuthenticateEventArgs e)
        {
            string username = Login1.UserName;
            //string password = Login1.Password;

            //bool isAuthenticated = AuthenticateUser(username, password);

            //if (isAuthenticated)
            //{
            string userType = GetUserRole(username);

            if (!string.IsNullOrEmpty(userType))
            {
                Session["UserType"] = userType;
                Session["Username"] = username;

                if (userType == "admin")
                {
                    Response.Redirect("/Management/Maintenance.aspx");
                }
                else if (userType == "student")
                {
                    Response.Redirect("Home.aspx");
                }
            }
            else
            {
                // Invalid credentials, display error message
                lblErrorMsg.Text = "Invalid username or password.";
            }
            //}
        }

        public bool AuthenticateUser(string username, string password)
        {
            bool isAuthenticated = false;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = "SELECT COUNT(*) FROM aspnet_Users WHERE UserName = @Username AND Password = @Password";
                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);
                cmd.Parameters.AddWithValue("@Password", password);

                conn.Open();
                int userCount = (int)cmd.ExecuteScalar();
                if (userCount > 0)
                {
                    isAuthenticated = true;
                }
            }
            return isAuthenticated;
        }

        public string GetUserRole(string username)
        {
            string role = null;
            using (SqlConnection conn = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
            {
                string query = @"
                SELECT r.RoleName 
                FROM aspnet_Users u
                INNER JOIN aspnet_UsersInRoles ur ON u.UserId = ur.UserId
                INNER JOIN aspnet_Roles r ON ur.RoleId = r.RoleId
                WHERE u.UserName = @Username";

                SqlCommand cmd = new SqlCommand(query, conn);
                cmd.Parameters.AddWithValue("@Username", username);

                conn.Open();
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