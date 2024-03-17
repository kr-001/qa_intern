from flask import Flask, request, jsonify
import logging, uuid
from datetime import datetime
logging.basicConfig(level=logging.INFO)
app = Flask(__name__)

@app.route('/submit-json', methods=["POST"])
def handle_json():
    try:
        data = request.get_json()
        if not all(key in data for key in ["name", "email"]):
            return jsonify({"error":"Missing required fields in JSON Payload."}), 400
        
        name = data["name"]
        email = data["email"]
        #for eg: Gen unique id
        unique_id = str(uuid.uuid4())
        current_time = datetime.now().strftime("%d-%m-%Y %H:%M:%S")
        response_data = {
            "id" : unique_id,
            "name" : name,
            "email": email,
            "created_at" : current_time
        }
        return jsonify({"data" : response_data,"message" : "Data received successfully!"}), 201
    except Exception as e:
        logging.error(f"An error occurred: {str(e)}")
        return jsonify({"error": f"An error occurred: {str(e)}"}), 500
    
@app.route('/submit-data', methods=['POST'])
def submit_data():
    if request.method == 'POST':
        if request.is_json:
            data = request.get_json()
            name = data.get('name')
            email = data.get('email')
            # Process JSON data
            response_data = {'message': 'JSON data received successfully', 'name': name, 'email': email}
        else:
            name = request.form.get('name')
            email = request.form.get('email')
            unique_id = str(uuid.uuid4())
            current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
            response_data = {'message': 'Form data received successfully',
                             'name': name,
                             'email': email,
                             'id': unique_id,
                             'created_at': current_time}
        return jsonify({"data": response_data, "message": "Form data received successfully!"})



if __name__ == "__main__":
    app.run()
