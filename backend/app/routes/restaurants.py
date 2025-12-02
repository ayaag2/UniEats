from flask import Blueprint, jsonify
import psycopg2
import sys

restaurants_bp = Blueprint("restaurants", __name__)

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


@restaurants_bp.get("/")
def list_restaurants():
    mSql = '''
        SELECT 
        r.restaurant_id AS id,
        r.name,
        r.price_range AS pricerange,
        CAST(d.min_distance AS double precision) AS walkdistance,
        r.take_out_available AS takeoutavailable,
        r.delivery_available AS deliveryavailable,
        r.thumbnail_url AS thumbnailurl,
        r.cuisine_id AS cuisineid
        FROM public.restaurant r
    LEFT JOIN (
        SELECT restaurant_id, MIN(distance_miles) AS min_distance
        FROM public.campus_proximity
        GROUP BY restaurant_id
    ) d ON r.restaurant_id = d.restaurant_id
    ORDER BY r.restaurant_id ASC;

    '''
    response = db_retrieve(mSql)
    return jsonify(response)

