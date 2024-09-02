using System;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniFinder
{
    public partial class CreateUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Wire up event handler in Page_Load
                //Calendar cldDOB = CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("cldDOB") as Calendar;
                //if (cldDOB != null)
                //{
                //    cldDOB.SelectionChanged += cldDOB_SelectionChanged;
                //}
            }
        }

        //protected void cldDOB_SelectionChanged(object sender, EventArgs e)
        //{
        //    Calendar cldDOB = sender as Calendar;
        //    TextBox txtDOB = CreateUserWizard1.CreateUserStep.ContentTemplateContainer.FindControl("txtDOB") as TextBox;

        //    if (cldDOB != null && txtDOB != null)
        //    {
        //        txtDOB.Text = cldDOB.SelectedDate.ToShortDateString();
        //    }
        //}

        protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
        {
            // Get the username of the newly created user
            string username = CreateUserWizard1.UserName;

            // Add the user to the "student" role
            Roles.AddUserToRole(username, "student");
        }
    }
}
