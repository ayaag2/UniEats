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
            restaurant_id as id, 
            name, 
            price_range as pricerange, 
            CAST(0.1 AS double precision) as walkdistance,
            take_out_available as takeoutavailable, 
            delivery_available as deliveryavailable, 
            thumbnail_url as thumbnailurl,
            cuisine_id as cuisineid
        FROM public.restaurant
        ORDER BY restaurant_id ASC 
    '''
    response = db_retrieve(mSql)
    return jsonify(response)
