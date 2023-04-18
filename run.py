from flask import Flask
app = Flask(__name__)

@app.route("/", methods=['GET'])
def hello_world():
    return "Olá Mundo!"
http://127.0.0.1:5000