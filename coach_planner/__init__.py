from flask import Flask
import os


def create_app(test_config=None):

    app = Flask(__name__)

    @app.route("/")
    def home():
        return "Hello, Flask!"

    return app
