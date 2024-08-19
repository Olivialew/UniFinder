using System;
using System.Diagnostics;
using System.IO;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using Syn.Bot.Channels.Testing;
using Syn.Bot.Channels.Widget;
using Syn.Bot.Oscova;

namespace UniFinder
{
    public partial class BotService : Page
    {
        private static WidgetChannel WidgetChannel { get; }
        private static OscovaBot Bot { get; }

        static BotService()
        {
            Bot = new OscovaBot();
            WidgetChannel = new WidgetChannel(Bot);

            // Add the pre-built channel test dialog.
            Bot.Dialogs.Add(new ChannelTestDialog(Bot));

            // Start training.
            Bot.Trainer.StartTraining();

            var websiteUrl = HttpContext.Current.Request.Url.GetLeftPart(UriPartial.Authority);
            WidgetChannel.ServiceUrl = websiteUrl + "/BotService.aspx";
            WidgetChannel.ResourceUrl = websiteUrl + "/BotResources";

            WidgetChannel.WidgetTitle = "EduBot!";
            WidgetChannel.LaunchButtonText = "Ask";
            WidgetChannel.InputPlaceHolder = "Ask your query here...";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                WidgetChannel.Process(Request, Response);
            }
            catch (Exception ex)
            {
                // Log the exception to see if there's an issue
                Debug.WriteLine("BotService Error: " + ex.Message);
                Response.Write("Error: " + ex.Message);
            }
        }

        [WebMethod]
        public static string Chat(string message)
        {
            try
            {
                string result = RunPythonScript(message);
                return result;
            }
            catch (Exception ex)
            {
                return "Error: " + ex.Message;
            }
        }

        private static string RunPythonScript(string message)
        {
            ProcessStartInfo start = new ProcessStartInfo
            {
                FileName = "python",
                Arguments = $"\"E:\\UniFinder\\Scripts\\AIChatbot.py\" \"{message}\"",
                UseShellExecute = false,
                RedirectStandardOutput = true,
                RedirectStandardError = true,
                CreateNoWindow = true
            };

            using (Process process = Process.Start(start))
            {
                using (StreamReader reader = process.StandardOutput)
                {
                    string result = reader.ReadToEnd();
                    if (!string.IsNullOrEmpty(result))
                    {
                        return result;
                    }
                }

                using (StreamReader reader = process.StandardError)
                {
                    string error = reader.ReadToEnd();
                    if (!string.IsNullOrEmpty(error))
                    {
                        return $"Error: {error}";
                    }
                }
            }
            return "Error: No response from script.";
        }
    }
}
