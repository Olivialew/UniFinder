using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace UniFinder
{
    public partial class MasterPage : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Get the current page's name
            string currentPage = System.IO.Path.GetFileName(Request.Url.AbsolutePath).ToLower();

            // Check the current page and set the active class
            SetActiveNavLink(homeLink, "Home.aspx", currentPage);
            SetActiveNavLink(programmeLink, "Programme.aspx", currentPage);
            SetActiveNavLink(universityLink, "University.aspx", currentPage);
            SetActiveNavLink(careerTestLink, "CareerTest.aspx", currentPage);
            SetActiveNavLink(aiChatbotLink, "AIChatbot2.aspx", currentPage);
            SetActiveNavLink(aboutUsLink, "AboutUs.aspx", currentPage);
            SetActiveNavLink(wishlistLink, "Wishlist.aspx", currentPage);
            SetActiveNavLink(accountLink, "Account.aspx", currentPage);
        }

        private void SetActiveNavLink(HtmlAnchor anchor, string pageName, string currentPage)
        {
            if (currentPage.Equals(pageName, StringComparison.OrdinalIgnoreCase))
            {
                anchor.Attributes["class"] = "active";
            }
            else
            {
                anchor.Attributes["class"] = "";
            }
        }
    }
}