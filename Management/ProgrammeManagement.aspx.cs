using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniFinder
{
    public partial class Programme_Management : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnReset_Click3(object sender, EventArgs e)
        {
            string searchQuery = HttpUtility.HtmlEncode(txtSearch.Text);
            // Search logic here
        }

        protected void btnSearch_Click3(object sender, EventArgs e)
        {
            txtSearch.Text = "";
            ddlUniType.SelectedIndex = 0;
        }

        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);
            this.GridView1.RowCancelingEdit += new GridViewCancelEditEventHandler(GridView1_RowCancelingEdit);
        }

        protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            GridView1.EditIndex = -1;
            GridView1.DataBind();
        }

        protected void GridView1_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            GridViewRow row = GridView1.Rows[e.RowIndex];
            string programID = (row.FindControl("lblProgramID") as Label).Text;
            string programName = HttpUtility.HtmlEncode((row.FindControl("txtProgramName") as TextBox).Text);
            string programLink = HttpUtility.HtmlEncode((row.FindControl("txtProgramLink") as TextBox).Text);
            string introduction = HttpUtility.HtmlEncode((row.FindControl("txtIntroduction") as TextBox).Text);
            string contact = HttpUtility.HtmlEncode((row.FindControl("txtContact") as TextBox).Text);
            int duration = int.Parse((row.FindControl("txtDuration") as TextBox).Text);
            int fees = int.Parse((row.FindControl("txtFees") as TextBox).Text);
            string facLink = HttpUtility.HtmlEncode((row.FindControl("txtFacLink") as TextBox).Text);
            string uniID = HttpUtility.HtmlEncode((row.FindControl("txtUniID") as TextBox).Text);
            string branchID = HttpUtility.HtmlEncode((row.FindControl("txtBranchID") as TextBox).Text);

            // Update logic here

            GridView1.EditIndex = -1;
            GridView1.DataBind();
        }

    }
}