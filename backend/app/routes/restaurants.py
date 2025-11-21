from flask import Blueprint, jsonify

restaurants_bp = Blueprint("restaurants", __name__)

import psycopg2
import sys

db_params = {
            "host": "localhost",
            "database": "uni_eats",
            "user": "uni_eats_user",
            "password": "password",
            "port": 5432 # Default port is 5432
        }

# I believe params has to be a tuple
def db_retrieve(query, params=[]):
    try:
        conn = psycopg2.connect(**db_params)
        cursor = conn.cursor()
        
        # params would be used for parameterized queries
        cursor.execute(query, *params)
        res = cursor.fetchall()
        
        cursor.close()
        conn.close()
        
        return res
    except Exception as e:
        print("Unable to retrieve content from the db.")
        print(e)
        sys.exit(1)

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
    print(db_retrieve("Select VERSION();"))
    return jsonify({"message": "TODO: implement restaurant listing API"})