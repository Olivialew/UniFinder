using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniFinder
{
    public partial class BranchManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadAllRecords();
            }
        }

        private void LoadAllRecords()
        {
            SqlDataSource1.SelectCommand = "SELECT * FROM [Branch]";
            GridView1.DataBind();
        }

        protected void ddlUni_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlBranch.DataBind(); // Rebind ddlBranch to refresh its items based on the selected university
        }

        protected void btnReset_Click2(object sender, EventArgs e)
        {
            ddlUni.SelectedIndex = 0;
            ddlBranch.SelectedIndex = 0;

            LoadAllRecords();
            lblErrorMessage.Visible = false;
        }

        protected void btnSearch_Click2(object sender, EventArgs e)
        {
            var uniID = ddlUni.SelectedValue;
            var branchID = ddlBranch.SelectedValue;

            if (!string.IsNullOrEmpty(uniID) && !string.IsNullOrEmpty(branchID))
            {
                SqlDataSource1.SelectCommand = "SELECT * FROM [Branch] WHERE [uniID] = @uniID AND [branchID] = @branchID";
                SqlDataSource1.SelectParameters.Clear();
                SqlDataSource1.SelectParameters.Add("uniID", uniID);
                SqlDataSource1.SelectParameters.Add("branchID", branchID);
            }
            else if (!string.IsNullOrEmpty(uniID))
            {
                SqlDataSource1.SelectCommand = "SELECT * FROM [Branch] WHERE [uniID] = @uniID";
                SqlDataSource1.SelectParameters.Clear();
                SqlDataSource1.SelectParameters.Add("uniID", uniID);
            }
            else
            {
                SqlDataSource1.SelectCommand = "SELECT * FROM [Branch]";
                SqlDataSource1.SelectParameters.Clear();
            }

            GridView1.DataBind();

            if (GridView1.Rows.Count == 0)
            {
                lblErrorMessage.Text = "No branches found for the selected university.";
                lblErrorMessage.Visible = true;
            }
            else
            {
                lblErrorMessage.Visible = false;
            }
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Handle GridView selection change if needed
        }
    }
}
