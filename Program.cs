using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;

namespace UniFinder
{
    public class Program
    {
        public static void Main(string[] args)
        {
            DatabaseHelper dbHelper = new DatabaseHelper();
            DataTable programData = dbHelper.GetProgramData();
            Console.WriteLine("EduBot: Hello, I am EduBot. What programme criteria do you have today?");

            while (true)
            {
                string userInput = Console.ReadLine();
                if (userInput.ToLower() == "exit")
                {
                    Console.WriteLine("EduBot: I am happy to be at your service. See you again!");
                    break;
                }

                // Process userInput and apply filtering logic
                // Example: Call TextProcessor methods and filter programData

                Console.WriteLine("EduBot: Would you like to continue or end the session? (type 'continue' or 'end')");
                string continueOrEnd = Console.ReadLine().ToLower();
                if (continueOrEnd == "end")
                {
                    Console.WriteLine("EduBot: I am happy to be at your service. See you again!");
                    break;
                }
            }
        }
    }
}