from flask import Flask
from app.routes.restaurants import restaurants_bp

app = Flask(__name__)
app.register_blueprint(restaurants_bp, url_prefix="/restaurants")

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000, debug=True)
