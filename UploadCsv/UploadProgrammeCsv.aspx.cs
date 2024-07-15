using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CsvHelper;
using CsvHelper.Configuration;
using System.Globalization;

namespace UniFinder
{
    public partial class UploadProgrammeCsv : System.Web.UI.Page
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

                GridView1.DataSource = GetCsvDataFromDatabase();
                GridView1.DataBind();
            }
        }

        private List<string[]> ProcessCsvFile(string filePath)
        {
            var csvData = new List<string[]>();

            var config = new CsvConfiguration(CultureInfo.InvariantCulture)
            {
                HasHeaderRecord = false,
                BadDataFound = null,
                MissingFieldFound = null
            };

            using (var reader = new StreamReader(filePath))
            using (var csv = new CsvReader(reader, config))
            {
                while (csv.Read())
                {
                    try
                    {
                        var row = new string[10];
                        row[0] = csv.GetField(0);
                        row[1] = csv.GetField(1);
                        row[2] = csv.GetField(2);
                        row[3] = csv.GetField(3);
                        row[4] = csv.GetField(4);
                        row[5] = csv.GetField(5);
                        row[6] = csv.GetField(6);
                        row[7] = csv.GetField(7);
                        row[8] = csv.GetField(8);
                        row[9] = csv.GetField(9);

                        // Debug: Print the values to ensure correct parsing
                        Console.WriteLine(string.Join("|", row));

                        csvData.Add(row);
                    }
                    catch (Exception ex)
                    {
                        Console.WriteLine($"Error reading row: {ex.Message}");
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
                    // Ensure that the row has the expected number of columns
                    if (row.Length != 10)
                    {
                        Console.WriteLine("Skipping row due to incorrect number of columns: " + string.Join("|", row));
                        continue;
                    }

                    string programID = row[0];
                    string uniID = row[8];
                    string branchID = row[9];

                    // Ensure that the uniID and branchID exist in the respective tables
                    if (UniversityExists(connection, uniID) && BranchExists(connection, branchID))
                    {
                        if (!IsDuplicateEntry(connection, programID))
                        {
                            string query = "INSERT INTO Programme (programID, programName, programLink, introduction, contact, duration, fees, facLink, uniID, branchID) " +
                                           "VALUES (@programID, @programName, @programLink, @introduction, @contact, @duration, @fees, @facLink, @uniID, @branchID)";
                            using (SqlCommand command = new SqlCommand(query, connection))
                            {
                                command.Parameters.AddWithValue("@programID", row[0]);
                                command.Parameters.AddWithValue("@programName", row[1]);
                                command.Parameters.AddWithValue("@programLink", row[2]);
                                command.Parameters.AddWithValue("@introduction", row[3]);
                                command.Parameters.AddWithValue("@contact", row[4]);
                                command.Parameters.AddWithValue("@duration", row[5]);
                                command.Parameters.AddWithValue("@fees", row[6]);
                                command.Parameters.AddWithValue("@facLink", row[7]);
                                command.Parameters.AddWithValue("@uniID", row[8]);
                                command.Parameters.AddWithValue("@branchID", row[9]);

                                try
                                {
                                    command.ExecuteNonQuery();
                                    Console.WriteLine($"Inserted row: {string.Join("|", row)}");
                                }
                                catch (Exception ex)
                                {
                                    Console.WriteLine($"Error inserting row: {string.Join("|", row)} - Exception: {ex.Message}");
                                }
                            }
                        }
                        else
                        {
                            Console.WriteLine($"Duplicate programID found, skipping insertion: {programID}");
                        }
                    }
                    else
                    {
                        // Log invalid uniID or branchID entries for review
                        Console.WriteLine($"Invalid uniID or branchID not found in the respective tables: {uniID}, {branchID}");
                    }
                }
            }
        }

        private bool UniversityExists(SqlConnection connection, string uniID)
        {
            string query = "SELECT COUNT(*) FROM University WHERE uniID = @uniID";
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@uniID", uniID);
                int count = (int)command.ExecuteScalar();
                return count > 0;
            }
        }

        private bool BranchExists(SqlConnection connection, string branchID)
        {
            string query = "SELECT COUNT(*) FROM Branch WHERE branchID = @branchID";
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@branchID", branchID);
                int count = (int)command.ExecuteScalar();
                return count > 0;
            }
        }

        private bool IsDuplicateEntry(SqlConnection connection, string programID)
        {
            string query = "SELECT COUNT(*) FROM Programme WHERE programID = @programID";
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@programID", programID);
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
                string query = "SELECT programID, programName, programLink, introduction, contact, duration, fees, facLink, uniID, branchID FROM Programme";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var row = new string[]
                            {
                                reader["programID"].ToString(),
                                reader["programName"].ToString(),
                                reader["programLink"].ToString(),
                                reader["introduction"].ToString(),
                                reader["contact"].ToString(),
                                reader["duration"].ToString(),
                                reader["fees"].ToString(),
                                reader["facLink"].ToString(),
                                reader["uniID"].ToString(),
                                reader["branchID"].ToString()
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