from flask import Flask
from flask_cors import CORS
from app.routes.restaurants import restaurants_bp
from app.routes.cuisine import cuisine_bp
from app.routes.campuses import campuses_bp
from app.routes.campusProximity import campusProximity_bp



app = Flask(__name__)

CORS(app, resources={r"/*": {"origins": "*"}})

app.register_blueprint(restaurants_bp, url_prefix="/restaurants")
app.register_blueprint(cuisine_bp, url_prefix="/cuisine")
app.register_blueprint(campuses_bp, url_prefix="/campuses")
app.register_blueprint(campusProximity_bp, url_prefix="/campusProximity")


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5001, debug=True)
