using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UniFinder
{
    public partial class UploadCsv : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void UploadButton_Click(object sender, EventArgs e)
        {
            if (FileUpload1.HasFile)
            {
                string fileName = Path.GetFileName(FileUpload1.PostedFile.FileName);
                string filePath = Server.MapPath("~/App_Data/Uploads/" + fileName);
                FileUpload1.SaveAs(filePath);

                var csvData = ProcessCsvFile(filePath);
                SaveCsvDataToDatabase(csvData); 
                //GridView1.DataSource = csvData;

                GridView1.DataSource = GetCsvDataFromDatabase();
                GridView1.DataBind();
            }
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            if (FileUpload2.HasFile)
            {
                byte[] imageData = FileUpload2.FileBytes;
                SaveImageToDatabase(imageData);
            }
        }

        private void SaveImageToDatabase(byte[] imageData)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
            string query = "INSERT INTO UniLogo (ImageData) VALUES (@ImageData)";

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@ImageData", imageData);

                    connection.Open();
                    command.ExecuteNonQuery();
                }
            }
        }

        private List<string[]> ProcessCsvFile(string filePath)
        {
            var csvData = new List<string[]>();

            using (var reader = new StreamReader(filePath))
            {
                while (!reader.EndOfStream)
                {
                    var line = reader.ReadLine();
                    var values = line.Split(',');
                    csvData.Add(values);

                    // Debug: Print the values to ensure correct parsing
                    Console.WriteLine(string.Join("|", values));

                    // Ensure the row has the expected number of columns
                    if (values.Length == 6)
                    {
                        csvData.Add(values);
                    }
                    else
                    {
                        // Handle unexpected number of columns
                        Console.WriteLine("Row with unexpected number of columns: " + line);
                    }
                }
            }

            return csvData;
        }

        private void SaveCsvDataToDatabase(List<string[]> csvData)
        {
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                foreach (var row in csvData)
                {
                    string uniID = row[0];

                    if (!IsDuplicateEntry(connection, uniID))
                    {
                        string query = "INSERT INTO University (uniID, uniNameEng, uniNameMalay, uniAcronym, foundationYear, uniType) " +
                                   "VALUES (@uniID, @uniNameEng, @uniNameMalay, @uniAcronym, @foundationYear, @uniType)";
                        using (SqlCommand command = new SqlCommand(query, connection))
                        {
                            command.Parameters.AddWithValue("@uniID", row[0]);
                            command.Parameters.AddWithValue("@uniNameEng", row[1]);
                            command.Parameters.AddWithValue("@uniNameMalay", row[2]);
                            command.Parameters.AddWithValue("@uniAcronym", row[3]);
                            command.Parameters.AddWithValue("@foundationYear", row[4]);
                            command.Parameters.AddWithValue("@uniType", row[5]);

                            command.ExecuteNonQuery();
                        }
                    }
                }
            }
        }

        private bool IsDuplicateEntry(SqlConnection connection, string uniID)
        {
            string query = "SELECT COUNT(*) FROM University WHERE uniID = @uniID";
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@uniID", uniID);
                int count = (int)command.ExecuteScalar();
                return count > 0;
            }
        }

        private List<string[]> GetCsvDataFromDatabase()
        {
            var csvData = new List<string[]>();
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();
                string query = "SELECT uniID, uniNameEng, uniNameMalay, uniAcronym, foundationYear, uniType FROM University";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var row = new string[]
                            {
                            reader["uniID"].ToString(),
                            reader["uniNameEng"].ToString(),
                            reader["uniNameMalay"].ToString(),
                            reader["uniAcronym"].ToString(),
                            reader["foundationYear"].ToString(),
                            reader["uniType"].ToString()
                            };
                            csvData.Add(row);
                        }
                    }
                }
            }

            return csvData;
        }
    }
}