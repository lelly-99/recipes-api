CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

CREATE TABLE users (
    id SERIAL PRIMARY KEY, 
    user_id  uuid  DEFAULT uuid_generate_v4(),
    user_name VARCHAR(50) NOT NULL,
    user_email VARCHAR(50) NOT NULL UNIQUE,
    user_password VARCHAR(255) NOT NULL
);

CREATE TABLE leaderboard (
    Leaderboard_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users(id) UNIQUE,
    dishes_cooked INT NOT NULL,
    points INT
);

CREATE TABLE dishes (
    dish_id SERIAL PRIMARY KEY,
    dish_name VARCHAR(200) NOT NULL UNIQUE,
    dish_image VARCHAR(200) NOT NULL,
    dish_points INT NOT NULL
);

CREATE TABLE recipes (
    Recipe_id SERIAL PRIMARY KEY,
    dishes_id INT REFERENCES dishes(dish_id),
    prep_time INT,
    cook_time INT,
    Instructions TEXT,
    ingredients TEXT
);