using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
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
                GridView1.DataBind();
            }
        }

        protected void btnReset_Click2(object sender, EventArgs e)
        {
            ddlUni.SelectedIndex = 0;
            ddlBranch.SelectedIndex = 0;

            GridView1.DataBind();
        }

        protected void btnSearch_Click2(object sender, EventArgs e)
        {
            GridView1.DataBind();
        }

        protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
        {

        }
    }
}