using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net.Mail;
using System.Web.Security;
using System.Web.UI;

namespace UniFinder
{
    public partial class ResetPassword1 : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Initial load tasks, if any
            }
        }

        protected void btnRequestOTP_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();

            // Generate OTP
            string otp = GenerateOTP();

            // Store OTP in the database
            StoreOTPInDatabase(email, otp);

            // Send OTP via email
            SendOTPEmail(email, otp);

            lblMessage.Text = "An OTP has been sent to your email. Please check your inbox.";
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            string enteredOTP = txtOTP.Text.Trim();
            string newPassword = txtNewPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            if (newPassword == confirmPassword)
            {
                if (ValidateOTP(email, enteredOTP))
                {
                    // Reset the user's password
                    ResetUserPassword(email, newPassword);
                    lblMessage.Text = "Password reset successfully.";
                }
                else
                {
                    lblMessage.Text = "Invalid or expired OTP. Please try again.";
                }
            }
            else
            {
                lblMessage.Text = "Passwords do not match. Please try again.";
            }
        }

        private string GenerateOTP()
        {
            Random random = new Random();
            return random.Next(100000, 999999).ToString(); // Generates a random 6-digit OTP
        }

        private void StoreOTPInDatabase(string email, string otp)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = "INSERT INTO OTPTable (Email, OTP, ExpiryTime) VALUES (@Email, @OTP, @ExpiryTime)";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    cmd.Parameters.AddWithValue("@OTP", otp);
                    cmd.Parameters.AddWithValue("@ExpiryTime", DateTime.Now.AddMinutes(10)); // OTP valid for 10 minutes
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }

        private void SendOTPEmail(string email, string otp)
        {
            string fromEmail = "lewjw-wm22@student.tarc.edu.my";
            string subject = "Your OTP for Password Reset";
            string body = $"Your OTP for password reset is: {otp}. This OTP is valid for 10 minutes.";

            MailMessage mail = new MailMessage(fromEmail, email);
            mail.Subject = subject;
            mail.Body = body;

            SmtpClient client = new SmtpClient("smtp.gmail.com", 587);
            client.UseDefaultCredentials = false;
            client.Credentials = new System.Net.NetworkCredential(fromEmail, "qbhtwgtpvlqoobpo"); // Use your app password here
            client.EnableSsl = true;

            try
            {
                client.Send(mail);
                System.Diagnostics.Debug.WriteLine("OTP email sent successfully.");
            }
            catch (Exception ex)
            {
                System.Diagnostics.Debug.WriteLine("Failed to send OTP email.");
                System.Diagnostics.Debug.WriteLine(ex.Message);
            }
        }

        private bool ValidateOTP(string email, string enteredOTP)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            // Query to get the latest OTP for the given email, ordered by ExpiryTime descending
            string query = "SELECT TOP 1 OTP, ExpiryTime FROM OTPTable WHERE Email = @Email ORDER BY ExpiryTime DESC";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            string storedOTP = reader["OTP"].ToString();
                            DateTime expiryTime = Convert.ToDateTime(reader["ExpiryTime"]);

                            // Debugging output to check values
                            System.Diagnostics.Debug.WriteLine($"Stored OTP: {storedOTP}");
                            System.Diagnostics.Debug.WriteLine($"Entered OTP: {enteredOTP}");
                            System.Diagnostics.Debug.WriteLine($"Expiry Time: {expiryTime}");
                            System.Diagnostics.Debug.WriteLine($"Current Time: {DateTime.Now}");

                            if (storedOTP == enteredOTP && DateTime.Now <= expiryTime)
                            {
                                return true; // OTP is valid
                            }
                        }
                        else
                        {
                            System.Diagnostics.Debug.WriteLine("No OTP record found for the given email.");
                        }
                    }
                }
            }

            return false; // OTP is invalid or expired
        }

        private void ResetUserPassword(string email, string newPassword)
        {
            // Retrieve the username associated with the email
            string username = GetUsernameByEmail(email);

            if (!string.IsNullOrEmpty(username))
            {
                MembershipUser user = Membership.GetUser(username);

                if (user != null)
                {
                    try
                    {
                        // Use the Membership API to change the password
                        string resetPassword = user.ResetPassword(); // Generate the temporary password
                        bool changeSuccess = user.ChangePassword(resetPassword, newPassword); // Change the password

                        if (changeSuccess)
                        {
                            // Password was changed successfully
                            lblMessage.Text = "Password reset successfully.";
                        }
                        else
                        {
                            // Password change failed
                            lblMessage.Text = "Failed to reset the password.";
                        }
                    }
                    catch (Exception ex)
                    {
                        // Handle exceptions (e.g., log the error)
                        lblMessage.Text = $"An error occurred: {ex.Message}";
                    }
                }
                else
                {
                    lblMessage.Text = "User not found.";
                }
            }
            else
            {
                lblMessage.Text = "Email address not associated with any user.";
            }
        }

        private string GetUsernameByEmail(string email)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            string query = "SELECT UserName FROM aspnet_Users " +
                           "INNER JOIN aspnet_Membership ON aspnet_Users.UserId = aspnet_Membership.UserId " +
                           "WHERE aspnet_Membership.Email = @Email";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Email", email);
                    conn.Open();
                    object result = cmd.ExecuteScalar();
                    return result != null ? result.ToString() : null;
                }
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            RedirectToRoleBasedPage();
        }

        private void RedirectToRoleBasedPage()
        {
            if (User.IsInRole("admin"))
            {
                Response.Redirect("~/Management/AccountAdmin.aspx");
            }
            else if (User.IsInRole("student"))
            {
                Response.Redirect("~/MyAccount/Account.aspx");
            }
            else
            {
                // Default page if the role is neither Admin nor Student
                Response.Redirect("~/MyAccount/Account.aspx");
            }
        }
    }
}
