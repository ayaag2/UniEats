from flask import Flask
from .routes.restaurant_param import restaurants_bp

def create_app():
    app = Flask(__name__)

    # app.config.from_object("app.config.Config")

    app.register_blueprint(restaurants_bp, url_prefix="/api/restaurants")

    @app.get("/api/health")
    def health():
        return {"status": "ok", "service": "uni-eats-backend"}

    return app
