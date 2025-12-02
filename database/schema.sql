-- UniEats PostgreSQL schema

CREATE TABLE cuisine (
    cuisine_id SERIAL PRIMARY KEY,
    name        VARCHAR(80) NOT NULL
);

CREATE TABLE campus (
    campus_id  SERIAL PRIMARY KEY,
    name       VARCHAR(120) NOT NULL,
    address    VARCHAR(255) NOT NULL,
    short_label VARCHAR(64) NOT NULL
);

CREATE TABLE restaurant (
    restaurant_id SERIAL PRIMARY KEY,
    name          VARCHAR(160) NOT NULL,
    price_range   VARCHAR(16)  NOT NULL CHECK (price_range IN ('<$5', '$5-$10', '$10-$20')),
    take_out_available   BOOLEAN NOT NULL DEFAULT FALSE,
    delivery_available   BOOLEAN NOT NULL DEFAULT FALSE,
    thumbnail_url        TEXT,
    cuisine_id           INTEGER NOT NULL REFERENCES cuisine(cuisine_id)
);

CREATE TABLE campus_proximity (
    restaurant_id INTEGER NOT NULL REFERENCES restaurant(restaurant_id),
    campus_id     INTEGER NOT NULL REFERENCES campus(campus_id),
    distance_miles NUMERIC(4, 2) NOT NULL,
    PRIMARY KEY (restaurant_id, campus_id)
);

CREATE TABLE user_rating (
    rating_id     SERIAL PRIMARY KEY,
    restaurant_id INTEGER NOT NULL REFERENCES restaurant(restaurant_id),
    user_name     VARCHAR(80),
    user_rating   INTEGER NOT NULL CHECK (user_rating BETWEEN 1 AND 5),
    review_text   TEXT NOT NULL,
    created_at    TIMESTAMP WITHOUT TIME ZONE DEFAULT NOW()
);
