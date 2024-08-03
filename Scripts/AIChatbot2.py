import pyodbc
import re
import sys
import pandas as pd
from sklearn.feature_extraction.text import TfidfVectorizer
from sklearn.metrics.pairwise import cosine_similarity

print("Script started")

# Set up the connection string
connection_string = (
    r'DRIVER={ODBC Driver 18 for SQL Server};'
    r'SERVER=(localdb)\MSSQLLocalDB;'
    r'AttachDbFilename=E:\UniFinder\App_Data\EduPathDatabase.mdf;'
    r'Trusted_Connection=yes;'
)

print("Connecting to database")
# Connect to the database
conn = pyodbc.connect(connection_string)
cursor = conn.cursor()

print("Fetching all data")
# Fetch all programs and universities
program_query = """
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
"""
cursor.execute(program_query)
programs = cursor.fetchall()

university_query = """
SELECT 
    u.uniNameEng, 
    u.uniAcronym,
    u.foundationYear,
    u.uniType,
    b.location,
    b.address,
    u.website
FROM 
    University u
JOIN 
    Branch b ON u.uniID = b.uniID
"""
cursor.execute(university_query)
universities = cursor.fetchall()

# Convert fetched data to pandas DataFrame
program_df = pd.DataFrame(programs, columns=['programName', 'introduction', 'duration', 'fees', 'uniNameEng', 'location'])
university_df = pd.DataFrame(universities, columns=['uniNameEng', 'uniAcronym', 'foundationYear', 'uniType', 'location', 'address', 'website'])

# Close the database connection
cursor.close()
conn.close()

print("Data fetched and processed")

# Vectorize program names for TF-IDF matching
vectorizer = TfidfVectorizer()
tfidf_matrix = vectorizer.fit_transform(program_df['programName'])

# Function to match programs using TF-IDF
def match_program(query):
    query_vec = vectorizer.transform([query])
    similarity = cosine_similarity(query_vec, tfidf_matrix)
    best_match_idx = similarity.argmax()
    return program_df.iloc[best_match_idx]

# Rule-based function to handle specific inquiries
def handle_inquiry(query):
    query = query.lower()

    if 'university' in query:
        for idx, row in university_df.iterrows():
            if row['uniNameEng'].lower() in query or row['uniAcronym'].lower() in query:
                return f"University: {row['uniNameEng']}\nAcronym: {row['uniAcronym']}\nFoundation Year: {row['foundationYear']}\nType: {row['uniType']}\nLocation: {row['location']}\nAddress: {row['address']}\nWebsite: {row['website']}"
    elif 'fees' in query or 'duration' in query or 'location' in query:
        for idx, row in program_df.iterrows():
            if row['programName'].lower() in query:
                return f"Program: {row['programName']}\nIntroduction: {row['introduction']}\nDuration: {row['duration']} years\nFees: {row['fees']}\nUniversity: {row['uniNameEng']}\nLocation: {row['location']}"
    else:
        return "Sorry, I couldn't understand your query. Please provide more details."

# Main function
def main():
    query = sys.argv[1]
    query = re.sub("[']",'',query)
    print(f"Received query: {query}")

    # Match using TF-IDF
    if any(word in query.lower() for word in ['program', 'course', 'fees', 'duration', 'location']):
        match = match_program(query)
        response = f"Program: {match['programName']}\nIntroduction: {match['introduction']}\nDuration: {match['duration']} years\nFees: {match['fees']}\nUniversity: {match['uniNameEng']}\nLocation: {match['location']}"
    else:
        response = handle_inquiry(query)

    print(response)

if __name__ == "__main__":
    main()

print("Script ended")
