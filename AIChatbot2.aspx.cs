using System;
using System.Diagnostics;
using System.IO;
using System.Web;
using System.Web.Services;

namespace UniFinder
{
    public partial class AIChatbot2 : System.Web.UI.Page
    {
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
            try
            {
                ProcessStartInfo start = new ProcessStartInfo
                {
                    FileName = "python",
                    Arguments = $"\"E:\\UniFinder\\Scripts\\geminiBot.py\" \"{message}\"",
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
                        process.WaitForExit(); // Ensure process has finished
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
            }
            catch (Exception ex)
            {
                return $"Error: {ex.Message}";
            }
            return "Error: No response from script.";
        }

    }
}
