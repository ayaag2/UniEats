from flask import Blueprint, jsonify
import psycopg2
import sys

campusProximity_bp = Blueprint("campusProximity", __name__)

db_params = {
    "host": "localhost",
    "database": "uni_eats",
    "user": "uni_eats_user",
    "password": "password",
    "port": 5432
}

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


@campusProximity_bp.get("/")
def list_campusProximity():
    mSql = '''
        SELECT restaurant_id as restaurantid, campus_id as campusid, distance_miles as distance
        FROM public.campus_proximity
        ORDER BY restaurant_id ASC, campus_id ASC 
    '''
    response = db_retrieve(mSql)
    return jsonify(response)
