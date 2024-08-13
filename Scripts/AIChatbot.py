import pyodbc
import re
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

def clean_text(text):
    # Clean and remove unwanted characters
    return text.replace('\xa0', ' ').strip()

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
            'programName': clean_text(result.programName),
            'introduction': clean_text(result.introduction),
            'duration': result.duration,
            'fees': result.fees,
            'university': clean_text(result.uniNameEng),
            'location': clean_text(result.location)
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
            'universityName': clean_text(result.uniNameEng),
            'universityAcronym': clean_text(result.uniAcronym),
            'foundationYear': result.foundationYear,
            'uniType': result.uniType,
            'location': clean_text(result.location),
            'address': clean_text(result.address)
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

# Recommend programs based on location, max_fees, and program_type
def recommend_program(location=None, max_fees=None, program_type=None, duration=None):
    query = """
    SELECT TOP 10
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
        1=1
    """
    
    params = []
    if location:
        query += " AND b.location LIKE ?"
        params.append(f"%{location}%")
    if max_fees is not None:
        query += " AND p.fees <= ?"
        params.append(max_fees)
    if program_type:
        query += " AND p.programName LIKE ?"
        params.append(f"%{program_type}%")
    if duration:
        query += " AND p.duration <= ?"
        params.append(duration)

    cursor.execute(query, params)
    results = cursor.fetchall()
    
    if results:
        recommendations = "Recommended Programs:<br>"
        for result in results:
            recommendations += (
                f"Program: {result.programName}<br>"
                f"Introduction: {result.introduction}<br>"
                f"Duration: {result.duration} years<br>"
                f"Fees: {result.fees}<br>"
                f"University: {result.uniNameEng}<br>"
                f"Location: {result.location}<br><br>"
            )
        return recommendations
    else:
        return "No programs found matching your criteria."

# Classify query to provide information on a university or program
def classify_query(query):
    query = query.lower()

    if 'fees' in query:
        program_name = match_name(query, program_names)
        if program_name:
            details = fetch_program_details(program_name)
            if details:
                return f"Program: {details['programName']}<br>Fees: {details['fees']}"
            else:
                return "No program found with the given name."
        else:
            return "Please specify the program name to get the fee details."
    
    elif 'duration' in query:
        program_name = match_name(query, program_names)
        if program_name:
            details = fetch_program_details(program_name)
            if details:
                return f"Program: {details['programName']}<br>Duration: {details['duration']}"
            else:
                return "No program found with the given name."
        else:
            return "Please specify the program name to get the duration details."

    elif 'location' in query:
        program_name = match_name(query, program_names)
        if program_name:
            details = fetch_program_details(program_name)
            if details:
                return f"Program: {details['programName']}<br>Location: {details['location']}"
            else:
                return "No location found with the given name."
        else:
            return "Please specify the program name to get the location details."
    
    elif 'university' in query:
        university_name = match_name(query, university_names)
        if university_name:
            details = fetch_university_details(university_name)
            if details:
                return (f"University: {details['universityName']}<br>"
                        f"Acronym: {details['universityAcronym']}<br>"
                        f"Founded Year: {details['foundationYear']}<br>"
                        f"University Type: {details['uniType']}<br>"
                        f"Location: {details['location']}<br>"
                        f"Address: {details['address']}")
            else:
                return "No university found with the given name."
        else:
            return "Please specify the university name to get the details."

    elif 'recommend' in query:
        # Extract criteria from the query
        location = re.search(r'(in|near) (\w+)', query)
        max_fees_match = re.search(r'(below|under|within) (\d+)', query)
        program_type = re.search(r'(computer science|engineering|business|it|law|art|biology|social science|medicine)', query)
        duration_match = re.search(r'(\d+) years', query)

        location = location.group(2) if location else None
        max_fees = int(max_fees_match.group(2)) if max_fees_match else None
        program_type = program_type.group(0) if program_type else None
        duration = int(duration_match.group(1)) if duration_match else None
        
        return recommend_program(location=location, max_fees=max_fees, program_type=program_type, duration=duration)

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

def format_output_for_html(text):
    return text.replace('\n', '<br>')

# Main function to choose between the algorithms
def main():
    Message = sys.argv[1]
    Message = re.sub("[']",'',Message)

    input_query = Message.strip()
    
    response = classify_query(input_query)

    # When outputting the response:
    response = format_output_for_html(response)

    print(response)

if __name__ == "__main__":
    main()

    # Close the database connection
    cursor.close()
    conn.close()
