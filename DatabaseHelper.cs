using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;

namespace UniFinder
{
    public class DatabaseHelper
    {
        private string connectionString = @"Server=(localdb)\MSSQLLocalDB;AttachDbFilename=E:\UniFinder\App_Data\EduPathDatabase.mdf;Trusted_Connection=True;";

        public DataTable GetProgramData()
        {
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                        SELECT 
                            p.programName, 
                            p.introduction, 
                            p.duration, 
                            p.fees, 
                            u.uniNameEng, 
                            b.location,
                            b.address
                        FROM 
                            Programme p
                        JOIN 
                            University u ON p.uniID = u.uniID
                        JOIN 
                            Branch b ON p.branchID = b.branchID";

                SqlDataAdapter adapter = new SqlDataAdapter(query, conn);
                DataTable dataTable = new DataTable();
                adapter.Fill(dataTable);
                return dataTable;
            }
        }
    }
}