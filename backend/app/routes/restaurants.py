from flask import Blueprint, jsonify

restaurants_bp = Blueprint("restaurants", __name__)

import psycopg2
import sys

params = {
            "host": "localhost",
            "database": "uni_eats",
            "user": "uni_eats_user",
            "password": "password",
            "port": 5432 # Default port is 5432
        }

@restaurants_bp.get("/")
def list_restaurants():
    """Placeholder endpoint.

    For now, the React app loads static data from `frontend/src/data/restaurants.js`.
    Once the database is wired up, this route should:
      - accept filter parameters (campus, cuisine, takeOut, delivery, text search)
      - query PostgreSQL
      - return JSON for the React UI
    """
    # make connection to database, cursor, execute query
    return jsonify({"message": "TODO: implement restaurant listing API"})