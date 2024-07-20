using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

namespace UniFinder
{
    public partial class RoleManagement : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
           
        }

        protected void btnCreate_Click(object sender, EventArgs e)
        {
            Roles.CreateRole(txtRole.Text);
        }

        protected void btnRetrieve_Click(object sender, EventArgs e)
        {
            lstRole.Items.Clear();
            lstRole.DataSource = Roles.GetAllRoles();
            lstRole.DataBind(); 
        }

        protected void btnRetrieveU_Click(object sender, EventArgs e)
        {
            lstUser.Items.Clear();
            lstUser.DataSource = Membership.GetAllUsers();
            lstUser.DataBind();
        }

        protected void btnAssign_Click(object sender, EventArgs e)
        {
            Roles.AddUserToRole(txtU.Text, txtR.Text);
        }

        protected void lstRole_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtR.Text=lstRole.SelectedItem.ToString();  
        }

        protected void lstUser_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtU.Text =lstUser.SelectedItem.ToString();
        }

        protected void btnGetRole_Click(object sender, EventArgs e)
        {
            ddlRole.DataSource = Roles.GetAllRoles();
            ddlRole.DataBind();
        }

        protected void btnDisplayU_Click(object sender, EventArgs e)
        {
           lstUR.DataSource = Roles.GetUsersInRole(ddlRole.SelectedItem.ToString());
            lstUR.DataBind();
        }
    }
}