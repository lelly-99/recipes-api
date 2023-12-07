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


INSERT INTO dishes (dish_name, dish_image,dish_points) VALUES
('Honey & Orange Glazed Carrots', 'https://www.eatingwell.com/thmb/F6HsFFEw9LHzy1ITrSzLzXxmeqM=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/7104339-4f33c5eae8594a1f9831e76f41ce99b9.jpg',12),
('Carrot Soup', 'https://www.eatingwell.com/thmb/vluYF2Sx7V55Au64BUZdm6-Q_Wo=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/carrot-soup-e2a833ef5926415580ca4f1efaff31ba.jpg',22),
('Maple Roasted Carrots', 'https://www.eatingwell.com/thmb/gwspOmQByJR2DdcECwY521kUcuE=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/4969963-9272b22302bd41949b72b9b78c05f845.jpg',42),
('Carrot-Apple Smoothie', 'https://www.eatingwell.com/thmb/0kyBmPiwM8B0uRQ4ImG7NBHuq0Q=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/carrot-apple-smoothie-1244-8a4aced134a947f692e9ead8427ca858.jpg',32);


INSERT INTO recipes (dishes_id, prep_time, cook_time, Instructions, ingredients)
VALUES
  (1, 15, 30, '1. Peel and slice the carrots.\n2. Mix honey, orange juice, olive oil, salt, and black pepper in a bowl.\n3. Toss the carrots in the mixture.\n4. Roast in the oven until glazed and tender.',
   'Carrots, Honey, Orange juice, Olive oil, Salt, Black pepper');

