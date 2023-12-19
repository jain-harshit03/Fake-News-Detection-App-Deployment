from flask import Flask, request, jsonify
from flask_cors import CORS
from deploy import predict_sentiment

app = Flask(__name__)
CORS(app)  # Enable CORS to allow cross-origin requests

@app.route('/flask', methods=['POST'])
def predict():
    if request.method == 'POST':
        data = request.get_json()  # Assuming JSON data is sent in the request
        if 'text' in data:  # Assuming the text to analyze is sent as 'text' in the JSON data
            text_to_analyze = data['text']
            # Call your predict_sentiment function with the text
            (a, b) = predict_sentiment(text_to_analyze)
            # Return the results as JSON
            return jsonify({"sentiment": a, "auth": b})

    return "Invalid request"

if __name__ == "__main__":
    app.run(port=5000, debug=True)
