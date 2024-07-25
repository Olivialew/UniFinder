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

        protected void btnAddBranch_Click(object sender, EventArgs e)
        {
            if (IsValid)
            {
                try
                {
                    using (SqlConnection con = new SqlConnection(WebConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString))
                    {
                        con.Open();

                        string queryInsert = "INSERT INTO Branch (uniID, location, address) VALUES (@UniversityID, @Location, @Address)";
                        SqlCommand cmdInsertBranch = new SqlCommand(queryInsert, con);

                        cmdInsertBranch.Parameters.AddWithValue("@UniversityID", ddlUni.SelectedValue);
                        cmdInsertBranch.Parameters.AddWithValue("@Location", ddlLocation.SelectedValue);
                        cmdInsertBranch.Parameters.AddWithValue("@Address", txtAddress.Text);

                        int rowsAffected = cmdInsertBranch.ExecuteNonQuery();

                        if (rowsAffected > 0)
                        {
                            Response.Write("<script>alert('Branch has been added successfully!')</script>");
                            clearFields();
                            // Uncomment if you want to refresh the GridView or similar control
                            // GVbind();
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
