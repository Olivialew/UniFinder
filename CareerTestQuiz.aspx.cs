using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniFinder
{
    public partial class CareerTestQuiz : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void SubmitButton_Click(object sender, EventArgs e)
        {
            // Collect answers
            List<string> answers = new List<string>
        {
            Question1.SelectedValue,
            Question2.SelectedValue,
            // Repeat for other questions
        };

            // Calculate result
            string result = CalculateResult(answers);

            // Store result in session
            Session["QuizResult"] = result;

            // Redirect to result page
            Response.Redirect("~/CareerTestResults.aspx");
        }

        private string CalculateResult(List<string> answers)
        {
            int countA = 0, countB = 0, countC = 0, countD = 0, countE = 0;

            foreach (var answer in answers)
            {
                switch (answer)
                {
                    case "A": countA++; break;
                    case "B": countB++; break;
                    case "C": countC++; break;
                    case "D": countD++; break;
                    case "E": countE++; break;
                }
            }

            if (countA >= countB && countA >= countC && countA >= countD && countA >= countE) return "Engineering or Computer Science";
            if (countB >= countA && countB >= countC && countB >= countD && countB >= countE) return "Medical or Biological Sciences";
            if (countC >= countA && countC >= countB && countC >= countD && countC >= countE) return "Humanities or Social Sciences";
            if (countD >= countA && countD >= countB && countD >= countC && countD >= countE) return "Arts or Design";
            return "Business or Management";
        }

        protected void CancelButton_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/CareerTest.aspx");
        }

        protected void ResetButton_Click(object sender, EventArgs e)
        {
            Question1.ClearSelection();
            Question2.ClearSelection();
            Question3.ClearSelection();
            Question4.ClearSelection();
            Question5.ClearSelection();
            Question6.ClearSelection();
            Question7.ClearSelection();
            Question8.ClearSelection();
            Question9.ClearSelection();
            Question10.ClearSelection();
        }
    }
}