<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPage.Master" AutoEventWireup="true" CodeBehind="CareerTestQuiz.aspx.cs" Inherits="UniFinder.CareerTestQuiz" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div>
        <h2>Career Quiz</h2>

        <!-- Question 1 -->
        <h3>1. What subjects do you enjoy the most in school?</h3>
        <asp:RadioButtonList ID="Question1" runat="server">
            <asp:ListItem Value="A">Math and Physics</asp:ListItem>
            <asp:ListItem Value="B">Biology and Chemistry</asp:ListItem>            
            <asp:ListItem Value="D">Art and Music</asp:ListItem>
            <asp:ListItem Value="E">Business Studies and Economics</asp:ListItem>
            <asp:ListItem Value="C">History and Literature</asp:ListItem>
        </asp:RadioButtonList>

        <!-- Question 2 -->
        <h3>2. What type of activities do you find most engaging?</h3>
        <asp:RadioButtonList ID="Question2" runat="server">
            <asp:ListItem Value="E">Organizing events or managing projects</asp:ListItem>
            <asp:ListItem Value="D">Drawing, painting, or designing</asp:ListItem>      
            <asp:ListItem Value="C">Reading and writinge</asp:ListItem>
            <asp:ListItem Value="B">Conducting experiments and researching</asp:ListItem>             
            <asp:ListItem Value="A">Solving puzzles and logical problems</asp:ListItem>
        </asp:RadioButtonList>

        <!-- Question 3 -->
        <h3>3. How do you prefer to work on projects?</h3>
        <asp:RadioButtonList ID="Question3" runat="server">
            <asp:ListItem Value="A">Independently with less supervision</asp:ListItem>
            <asp:ListItem Value="C">Writing and analyzing texts</asp:ListItem>
            <asp:ListItem Value="B">In a laboratory setting with a team</asp:ListItem>
            <asp:ListItem Value="E">Collaborating with others and leading groups</asp:ListItem>            
            <asp:ListItem Value="D">Creatively and visually</asp:ListItem>            
        </asp:RadioButtonList>

        <!-- Question 4 -->
        <h3>4. Which of the following best describes your ideal work environment?</h3>
        <asp:RadioButtonList ID="Question4" runat="server">
            <asp:ListItem Value="D">A design studio or art gallery</asp:ListItem>
            <asp:ListItem Value="A">A tech company or engineering firm</asp:ListItem>
            <asp:ListItem Value="B">A research laboratory or hospital</asp:ListItem>
            <asp:ListItem Value="C">A library or publishing house</asp:ListItem>
            <asp:ListItem Value="E">A corporate office or start-up</asp:ListItem>
        </asp:RadioButtonList>

        <!-- Question 5 -->
        <h3>5. What is your approach to problem-solving?</h3>
        <asp:RadioButtonList ID="Question5" runat="server">
            <asp:ListItem Value="A">Analytical and data-driven</asp:ListItem>            
            <asp:ListItem Value="D">Imaginative and innovative</asp:ListItem>
            <asp:ListItem Value="B">Methodical and experimental</asp:ListItem>
            <asp:ListItem Value="C">Thoughtful and reflective</asp:ListItem>
            <asp:ListItem Value="E">Practical and strategic</asp:ListItem>
        </asp:RadioButtonList>

        <!-- Question 6 -->
        <h3>6. What co-curricular activities do you enjoy?</h3>
        <asp:RadioButtonList ID="Question6" runat="server">            
            <asp:ListItem Value="C">Debate club or writing for the school newspaper</asp:ListItem>
            <asp:ListItem Value="D">Art club or theater productions</asp:ListItem>
            <asp:ListItem Value="A">Robotics club or coding competitions</asp:ListItem>
            <asp:ListItem Value="B">Science club or volunteering at a hospital</asp:ListItem>
            <asp:ListItem Value="E">Student council or business club</asp:ListItem>
        </asp:RadioButtonList>

        <!-- Question 7 -->
        <h3>7. Which of the following best describes your strengths?</h3>
        <asp:RadioButtonList ID="Question7" runat="server">
            <asp:ListItem Value="D">Creativity and artistic talent</asp:ListItem>
            <asp:ListItem Value="B">Attention to detail and scientific curiosity</asp:ListItem>
            <asp:ListItem Value="E">Leadership and organizational skills</asp:ListItem>
            <asp:ListItem Value="A">Logical thinking and programming skills</asp:ListItem>            
            <asp:ListItem Value="C">Strong communication and analytical skills</asp:ListItem>            
        </asp:RadioButtonList>

        <!-- Question 8 -->
        <h3>8. What type of career do you envision for yourself?</h3>
        <asp:RadioButtonList ID="Question8" runat="server">
            <asp:ListItem Value="A">Software engineer or data scientist</asp:ListItem>
            <asp:ListItem Value="B">Doctor, biologist, or pharmacist</asp:ListItem>            
            <asp:ListItem Value="D">Graphic designer or architect</asp:ListItem>
            <asp:ListItem Value="C">Journalist, historian, or writer</asp:ListItem>
            <asp:ListItem Value="E">Entrepreneur or business executive</asp:ListItem>
        </asp:RadioButtonList>

        <!-- Question 9 -->
        <h3>9. How do you handle challenges?</h3>
        <asp:RadioButtonList ID="Question9" runat="server">
            <asp:ListItem Value="C">By discussing and debating ideas</asp:ListItem>
            <asp:ListItem Value="D">By thinking outside the box</asp:ListItem>
            <asp:ListItem Value="E">By planning and executing strategies</asp:ListItem>
            <asp:ListItem Value="A">By breaking them down into smaller problems</asp:ListItem>
            <asp:ListItem Value="B">By researching and testing solutions</asp:ListItem>
        </asp:RadioButtonList>

        <!-- Question 10 -->
        <h3>10. What motivates you the most in your studies?</h3>
        <asp:RadioButtonList ID="Question10" runat="server">
            <asp:ListItem Value="A">The opportunity to innovate and create new technology</asp:ListItem>
            <asp:ListItem Value="D">The opportunity to create and showcase art</asp:ListItem>
            <asp:ListItem Value="B">The chance to make discoveries and help people</asp:ListItem>
            <asp:ListItem Value="C">The ability to express ideas and tell stories</asp:ListItem>
            <asp:ListItem Value="E">The potential to lead and achieve business success</asp:ListItem>
        </asp:RadioButtonList>

        <br />

        <!-- Submit Button -->
        <asp:Button ID="SubmitButton" runat="server" Text="Submit" OnClick="SubmitButton_Click" />
    </div>
</asp:Content>
