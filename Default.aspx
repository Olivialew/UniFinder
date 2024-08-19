<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="UniFinder.Default" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>My Website with a Bot</title>
    <style>
        body {
            background-image: url(background.jpg);
            background-size: cover;
            background-repeat: no-repeat;
            margin: 0;
            padding: 0;
            height: 100vh;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
        }
        #chat-container {
            position: relative;
            z-index: 1000;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div id="chat-container">
            <!-- Chat widget will be injected here -->
        </div>
        <script type="text/javascript">
            (function () {
                var scriptElement = document.createElement('script');
                scriptElement.type = 'text/javascript';
                scriptElement.async = false;
                scriptElement.src = '/BotService.aspx?Get=Script';
                document.getElementById('chat-container').appendChild(scriptElement);
            })();
        </script>
    </form>
</body>
</html>
