import google.generativeai as genai

# Configure the API key
API_KEY = 'AIzaSyAwVFvBqpup8Zx-Ybl8AyqiGBH4q2EQsvU'
genai.configure(api_key=API_KEY)

# Create the model instance
model = genai.GenerativeModel('gemini-pro')

def get_response(user_input):
    """Function to get a response from the model"""
    response = model.generate_content(user_input)
    return response.text

if __name__ == "__main__":
    import sys
    user_input = sys.argv[1]
    response = get_response(user_input)
    print(response)
