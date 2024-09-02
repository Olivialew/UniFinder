using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Net.Mail;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniFinder
{
    public partial class ResetPassword : System.Web.UI.Page
    {
        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            string userEmail = txtEmail.Text.Trim();

            // Check if the email exists in the system
            MembershipUser user = Membership.GetUser(Membership.GetUserNameByEmail(userEmail));
            if (user != null)
            {
                // Generate a password reset token
                string resetToken = Guid.NewGuid().ToString();

                // Save the token in the database
                SaveResetTokenToDatabase(user.UserName, resetToken);

                // Send an email to the user with the reset link
                SendPasswordResetEmail(userEmail, resetToken);

                lblMessage.Text = "An email with password reset instructions has been sent.";
            }
            else
            {
                lblMessage.Text = "The email address is not registered.";
            }
        }

        private void SendPasswordResetEmail(string email, string resetToken)
        {
            string resetUrl = $"http://localhost:44368/MyAccount/ResetPassword.aspx?token={resetToken}";

            MailMessage mail = new MailMessage("lewjw-wm22@student.tarc.edu.my", email);
            mail.Subject = "Password Reset Request";
            mail.Body = $"Please click the following link to reset your password: {resetUrl}";

            SmtpClient client = new SmtpClient();
            client.EnableSsl = true;

            try
            {
                client.Send(mail);
                lblMessage.Text = "An email with password reset instructions has been sent.";
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Failed to send email. Please try again later.";
                // Log detailed error information
                System.Diagnostics.Debug.WriteLine("Exception: " + ex.Message);
                System.Diagnostics.Debug.WriteLine("StackTrace: " + ex.StackTrace);
            }
        }

        private void SaveResetTokenToDatabase(string username, string resetToken)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                string query = "INSERT INTO ResetTokens (Token, Username, Expiration) VALUES (@Token, @Username, @Expiration)";
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Token", resetToken);
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Expiration", DateTime.Now.AddHours(1)); // Token valid for 1 hour
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}