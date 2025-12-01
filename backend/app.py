from flask import Flask, jsonify
import psycopg2
import sys

restaurants_bp = Flask(__name__)

db_params = {
            "host": "localhost",
            "database": "uni_eats",
            "user": "uni_eats_user",
            "password": "password",
            "port": 5432
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

@restaurants_bp.route("/")
def list_restaurants():
    """Placeholder endpoint.

    For now, the React app loads static data from `frontend/src/data/restaurants.js`.
    Once the database is wired up, this route should:
      - accept filter parameters (campus, cuisine, takeOut, delivery, text search)
      - query PostgreSQL
      - return JSON for the React UI
    """
    # make connection to database, cursor, execute query
    mSql = "SELECT * FROM public.cuisine ORDER BY cuisine_id ASC;"
    response = db_retrieve(mSql)
    ##print(db_retrieve(mSql))
    return jsonify(response)

if __name__ == "__main__":
    restaurants_bp.run(debug=True)