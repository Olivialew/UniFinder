using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniFinder
{
    public partial class University_Management : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Bind the GridView to display all records on initial load
                GridView1.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // Set default values if controls are empty
            SqlDataSource3.SelectParameters["uniType"].DefaultValue = ddlUniType.SelectedValue ?? string.Empty;
            SqlDataSource3.SelectParameters["uniNameEng"].DefaultValue = txtSearch.Text.Trim() ?? string.Empty;
            SqlDataSource3.SelectParameters["uniNameMalay"].DefaultValue = txtSearch.Text.Trim() ?? string.Empty;
            SqlDataSource3.SelectParameters["uniAcronym"].DefaultValue = txtSearch.Text.Trim() ?? string.Empty;

            // Bind the GridView to apply the filters set by the user
            GridView1.DataBind();
        }

        protected void btnReset_Click(object sender, EventArgs e)
        {
            // Clear search criteria
            txtSearch.Text = string.Empty;
            ddlUniType.SelectedIndex = 0;

            // Set default values to ensure all records are displayed
            SqlDataSource3.SelectParameters["uniType"].DefaultValue = string.Empty;
            SqlDataSource3.SelectParameters["uniNameEng"].DefaultValue = string.Empty;
            SqlDataSource3.SelectParameters["uniNameMalay"].DefaultValue = string.Empty;
            SqlDataSource3.SelectParameters["uniAcronym"].DefaultValue = string.Empty;

            // Rebind the GridView to show all records
            GridView1.DataBind();
        }

    }
}