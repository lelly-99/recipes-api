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

INSERT INTO dishes (dish_id, dish_name, dish_image, dish_points)
VALUES
  (1, 'Apple Cinnamon & Nuts Oatmeal', 'https://veggiecurean.com/wp-content/uploads/2016/04/steel-cut-oatmeal-with-apples-1500x750.jpg', 38),
  (2, 'Oat Cookies', 'https://lovingitvegan.com/wp-content/uploads/2021/10/Vegan-Oatmeal-Cookies-17.jpg', 40),
  (3, 'Overnight Oats', 'https://feelgoodfoodie.net/wp-content/uploads/2023/04/Overnight-Oats-18.jpg', 20),
  (4, 'Oat Muffins', 'https://www.ihearteating.com/wp-content/uploads/2019/01/Oatmeal-muffins-5-800.jpg', 40);
