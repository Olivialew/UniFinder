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
    public partial class UploadBranchCsv : System.Web.UI.Page
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

            using (var reader = new StreamReader(filePath))
            using (var csv = new CsvReader(reader, new CsvConfiguration(CultureInfo.InvariantCulture)
            {
                HasHeaderRecord = false,
            }))
            {
                while (csv.Read())
                {
                    var row = new string[4];
                    row[0] = csv.GetField(0);
                    row[1] = csv.GetField(1);
                    row[2] = csv.GetField(2);
                    row[3] = csv.GetField(3);
                    csvData.Add(row);
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
                    // Check for null values before processing
                    if (row.Length != 4 || string.IsNullOrEmpty(row[0]) || string.IsNullOrEmpty(row[1]) || string.IsNullOrEmpty(row[2]) || string.IsNullOrEmpty(row[3]))
                    {
                        Console.WriteLine("Skipping row due to null or empty values: " + string.Join("|", row));
                        continue;
                    }

                    string branchID = row[0];
                    string uniID = row[1];
                    string location = row[2];
                    string address = row[3];

                    // Ensure that the uniID exists in the University table
                    if (UniversityExists(connection, uniID))
                    {
                        if (!IsBranchDuplicate(connection, branchID))
                        {
                            string query = "INSERT INTO Branch (branchID, uniID, location, address) " +
                                           "VALUES (@branchID, @uniID, @location, @address)";
                            using (SqlCommand command = new SqlCommand(query, connection))
                            {
                                command.Parameters.AddWithValue("@branchID", branchID);
                                command.Parameters.AddWithValue("@uniID", uniID);
                                command.Parameters.AddWithValue("@location", location);
                                command.Parameters.AddWithValue("@address", address);

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
                            Console.WriteLine($"Duplicate branchID found, skipping insertion: {branchID}");
                        }
                    }
                    else
                    {
                        // Log invalid uniID entries for review
                        Console.WriteLine($"Invalid uniID not found in University table: {uniID}");
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

        private bool IsBranchDuplicate(SqlConnection connection, string branchID)
        {
            string query = "SELECT COUNT(*) FROM Branch WHERE branchID = @branchID";
            using (SqlCommand command = new SqlCommand(query, connection))
            {
                command.Parameters.AddWithValue("@branchID", branchID);
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
                string query = "SELECT branchID, uniID, location, address FROM Branch";

                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    using (SqlDataReader reader = command.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            var row = new string[]
                            {
                                reader["branchID"].ToString(),
                                reader["uniID"].ToString(),
                                reader["location"].ToString(),
                                reader["address"].ToString()
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