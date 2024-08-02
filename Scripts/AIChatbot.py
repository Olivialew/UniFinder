import pyodbc
import pandas as pd
import re
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity
import numpy as np
import sys

# Set up the connection string
connection_string = (
    r'DRIVER={ODBC Driver 18 for SQL Server};'
    r'SERVER=(localdb)\MSSQLLocalDB;'
    r'AttachDbFilename=E:\UniFinder\App_Data\EduPathDatabase.mdf;'
    r'Trusted_Connection=yes;'
)

# Connect to the database
conn = pyodbc.connect(connection_string)
cursor = conn.cursor()

# Fetch all program names and university names
def fetch_all_names():
    program_query = "SELECT programName FROM Programme"
    university_query = "SELECT uniNameEng FROM University"
    
    cursor.execute(program_query)
    program_names = [row.programName for row in cursor.fetchall()]
    
    cursor.execute(university_query)
    university_names = [row.uniNameEng for row in cursor.fetchall()]
    
    return program_names, university_names

program_names, university_names = fetch_all_names()

# Fetch program details
def fetch_program_details(program_name):
    query = """
    SELECT 
        p.programName, 
        p.introduction, 
        p.duration, 
        p.fees, 
        u.uniNameEng, 
        b.location
    FROM 
        Programme p
    JOIN 
        University u ON p.uniID = u.uniID
    JOIN 
        Branch b ON u.uniID = b.uniID
    WHERE 
        p.programName = ?
    """
    cursor.execute(query, (program_name,))
    result = cursor.fetchone()
    if result:
        return {
            'programName': result.programName,
            'introduction': result.introduction,
            'duration': result.duration,
            'fees': result.fees,
            'university': result.uniNameEng,
            'location': result.location
        }
    else:
        return None

# Fetch university details
def fetch_university_details(university_name):
    query = """
    SELECT 
        u.uniNameEng, 
        u.uniAcronym,
        u.foundationYear,
        u.uniType,
        b.location,
        b.address
    FROM 
        University u
    JOIN 
        Branch b ON u.uniID = b.uniID
    WHERE 
        u.uniNameEng = ?
    """
    cursor.execute(query, (university_name,))
    result = cursor.fetchone()
    if result:
        return {
            'universityName': result.uniNameEng,
            'universityAcronym': result.uniAcronym,
            'foundationYear': result.foundationYear,
            'uniType': result.uniType,
            'location': result.location,
            'address': result.address
        }
    else:
        return None

# Match names from a list
def match_name(query, names_list):
    query = query.lower()
    for name in names_list:
        if name.lower() in query:
            return name
    return None

# Classify query to provide information on a university or program
def classify_query(query):
    query = query.lower()

    if 'fees' in query:
        program_name = match_name(query, program_names)
        if program_name:
            details = fetch_program_details(program_name)
            if details:
                return f"Program: {details['programName']}\nFees: {details['fees']}"
            else:
                return "No program found with the given name."
        else:
            return "Please specify the program name to get the fee details."
    
    elif 'duration' in query:
        program_name = match_name(query, program_names)
        if program_name:
            details = fetch_program_details(program_name)
            if details:
                return f"Program: {details['programName']}\nDuration: {details['duration']}"
            else:
                return "No program found with the given name."
        else:
            return "Please specify the program name to get the duration details."
    
    elif 'university' in query:
        university_name = match_name(query, university_names)
        if university_name:
            details = fetch_university_details(university_name)
            if details:
                return (f"University: {details['universityName']}\nAcronym: {details['universityAcronym']}\n"
                        f"Founded Year: {details['foundationYear']}\nUniversity Type: {details['uniType']}\n"
                        f"Location: {details['location']}\nAddress: {details['address']}")
            else:
                return "No university found with the given name."
        else:
            return "Please specify the university name to get the details."
    
    else:
        # Extract criteria from the query
        location = re.search(r'near (\w+)', query)
        budget = re.search(r'within (\d+) budget', query)
        duration = re.search(r'(\d+) years', query)
        program_type = re.search(r'(computer science|engineering|business)', query)
        
        if location and budget and duration and program_type:
            location = location.group(1)
            budget = int(budget.group(1))
            duration = int(duration.group(1))
            program_type = program_type.group(1)
            return recommend_program(location, budget, duration, program_type)
        
        return "Sorry, I couldn't understand your query. Please provide more details."

# Recommend programs based on location, budget, duration, and program type
def recommend_program(location, budget, duration, program_type):
    query = """
    SELECT 
        p.programName, 
        p.introduction, 
        p.duration, 
        p.fees, 
        u.uniNameEng, 
        b.location
    FROM 
        Programme p
    JOIN 
        University u ON p.uniID = u.uniID
    JOIN 
        Branch b ON u.uniID = b.uniID
    WHERE 
        b.location = ? AND p.fees <= ? AND p.duration <= ? AND p.programName LIKE ?
    """
    cursor.execute(query, (location, budget, duration, f'%{program_type}%'))
    results = cursor.fetchall()
    
    if results:
        recommendations = "Recommended Programs:\n"
        for result in results:
            recommendations += (f"Program: {result.programName}\n"
                                f"Introduction: {result.introduction}\n"
                                f"Duration: {result.duration} years\n"
                                f"Fees: {result.fees}\n"
                                f"University: {result.uniNameEng}\n"
                                f"Location: {result.location}\n\n")
        return recommendations
    else:
        return "No programs found matching your criteria."

# Main function to choose between the algorithms
def main():
    input_query = sys.stdin.read().strip()
    print(f"Received query: {input_query}")
    
    response = classify_query(input_query)
    print(response)

if __name__ == "__main__":
    main()

    # Close the database connection
    cursor.close()
    conn.close()
