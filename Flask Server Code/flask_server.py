from flask import Flask, request, jsonify

app = Flask(__name__)

sensors_data = []

@app.route('/receive_data', methods=['POST'])
def receive_data():
    data = request.json  # Get JSON data from the request
    #  process and store the data as 
    sensors_data.append(data)
    print("Received data:", data)
    response = {"message": "Data received successfully"}
    return jsonify(response)

@app.route('/sensorsdata', methods=['GET'])
def sendSensorData():
    
    return jsonify(sensors_data)
    


if __name__ == '__main__':
    app.run(debug=True,host='0.0.0.0', port=5000)  # Allow external access on port 5000
