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
def db_retrieve(query, params=()):
    try:
        conn = psycopg2.connect(**db_params)
        cursor = conn.cursor()
        cursor.execute(query, params)
        columns = [desc[0] for desc in cursor.description]
        rows = cursor.fetchall()
        cursor.close()
        conn.close()
        result = [dict(zip(columns, row)) for row in rows]
        return result
    except Exception as e:
        print("Unable to retrieve content from the db.")
        print(e)
        sys.exit(1)

@restaurants_bp.get("/<int:selected_cuisine_id>")
def list_restaurants(selected_cuisine_id):
    mSql = "SELECT * FROM public.restaurant WHERE cuisine_id = %s ORDER BY restaurant_id ASC"
    response = db_retrieve(mSql, (selected_cuisine_id,))
    return jsonify(response)
