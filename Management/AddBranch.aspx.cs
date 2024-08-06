using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniFinder.Management
{
    public partial class AddBranch : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                clearFields();
            }
        }

        //protected void btnAddBranch_Click(object sender, EventArgs e)
        //{
        //    if (IsValid)
        //    {
        //        try
        //        {
        //            using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
        //            {
        //                con.Open();

        //                // Generate the branch ID
        //                string queryCount = "SELECT COUNT(*) FROM Branch";
        //                SqlCommand cmdCountPromo = new SqlCommand(queryCount, con);
        //                int recordCount = (int)cmdCountPromo.ExecuteScalar();
        //                recordCount++;
        //                string branchId = "B" + recordCount.ToString("D4");

        //                // Check if the branch ID already exists
        //                string queryCheckId = "SELECT COUNT(*) FROM Branch WHERE branchId = @BranchID";
        //                SqlCommand cmdCheckId = new SqlCommand(queryCheckId, con);
        //                cmdCheckId.Parameters.AddWithValue("@BranchID", branchId);
        //                int idCount = (int)cmdCheckId.ExecuteScalar();

        //                if (idCount > 0)
        //                {
        //                    lblmsg.Text = "The branch ID already exists. Please try again.";
        //                    return;
        //                }

        //                // Insert the new branch
        //                string queryInsert = "INSERT INTO Branch (branchId, uniID, location, address) VALUES (@BranchID, @UniversityID, @Location, @Address)";
        //                SqlCommand cmdInsertBranch = new SqlCommand(queryInsert, con);

        //                cmdInsertBranch.Parameters.AddWithValue("@BranchID", branchId);
        //                cmdInsertBranch.Parameters.AddWithValue("@UniversityID", ddlUni.SelectedValue);
        //                cmdInsertBranch.Parameters.AddWithValue("@Location", ddlLocation.SelectedValue);
        //                cmdInsertBranch.Parameters.AddWithValue("@Address", txtAddress.Text);

        //                int rowsAffected = cmdInsertBranch.ExecuteNonQuery();

        //                if (rowsAffected > 0)
        //                {
        //                    Response.Write("<script>alert('Branch has been added successfully!')</script>");
        //                    clearFields();
        //                    Response.Redirect("BranchManagement.aspx");
        //                }
        //            }
        //        }
        //        catch (Exception ex)
        //        {
        //            lblmsg.Text = "The branch could not be added. The following error occurred: " + ex.Message;
        //        }
        //    }
        //}

        protected void btnAddBranch_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                try
                {
                    using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                    {
                        con.Open();

                        // Get the current highest branch ID
                        string queryMaxId = "SELECT MAX(branchId) FROM Branch";
                        SqlCommand cmdMaxId = new SqlCommand(queryMaxId, con);

                        object maxIdObj = cmdMaxId.ExecuteScalar();
                        string maxId = maxIdObj != DBNull.Value ? maxIdObj.ToString() : null;

                        // Generate the new branch ID
                        string branchId = GenerateNextBranchId(maxId);

                        // Insert the new branch
                        string queryInsert = "INSERT INTO Branch (branchId, uniID, location, address) VALUES (@BranchID, @UniversityID, @Location, @Address)";
                        SqlCommand cmdInsertBranch = new SqlCommand(queryInsert, con);

                        cmdInsertBranch.Parameters.AddWithValue("@BranchID", branchId);
                        cmdInsertBranch.Parameters.AddWithValue("@UniversityID", ddlUni.SelectedValue);
                        cmdInsertBranch.Parameters.AddWithValue("@Location", ddlLocation.SelectedValue);
                        cmdInsertBranch.Parameters.AddWithValue("@Address", txtAddress.Text);

                        int rowsAffected = cmdInsertBranch.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            Response.Write("<script>alert('Branch has been added successfully!')</script>");
                            clearFields();
                            Response.Redirect("BranchManagement.aspx");
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblmsg.Text = "The branch could not be added. The following error occurred: " + ex.Message;
                }
            }
        }

        private string GenerateNextBranchId(string currentMaxId)
        {
            int nextNumber = 1;

            if (!string.IsNullOrEmpty(currentMaxId))
            {
                string numericPart = currentMaxId.Substring(1); // Skip the 'B' prefix
                if (int.TryParse(numericPart, out int maxNumber))
                {
                    nextNumber = maxNumber + 1;
                }
            }

            return $"B{nextNumber:D4}"; // Format the number to be 4 digits long
        }



        protected void btnCancel_Click(object sender, EventArgs e)
        {
            clearFields();
        }

        private void clearFields()
        {
            ddlUni.SelectedIndex = 0;
            ddlLocation.SelectedIndex = 0;
            txtAddress.Text = "";
        }
    }
}
