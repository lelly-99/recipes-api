CREATE TABLE users (
    id SERIAL PRIMARY KEY, 
    user_name VARCHAR(50) NOT NULL,
    user_password VARCHAR(60) NOT NULL
);

CREATE TABLE leaderboard (
    Leaderboard_id INT PRIMARY KEY,
    user_id INT REFERENCES users(id),
    dishes_cooked INT,
    rank INT,
    score INT
);

CREATE TABLE dishes (
    dish_id SERIAL PRIMARY KEY,
    dish_name VARCHAR(200),
    dish_image VARCHAR(200)
);

CREATE TABLE recipes (
    Recipe_id SERIAL PRIMARY KEY,
    dishes_id INT REFERENCES dishes(dish_id),
    prep_time INT,
    cook_time INT,
    Instructions TEXT,
    ingredients TEXT
);



INSERT INTO dishes (dish_name, dish_image) VALUES
('Honey & Orange Glazed Carrots', 'https://www.eatingwell.com/thmb/F6HsFFEw9LHzy1ITrSzLzXxmeqM=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/7104339-4f33c5eae8594a1f9831e76f41ce99b9.jpg'),
('Carrot Soup', 'https://www.eatingwell.com/thmb/vluYF2Sx7V55Au64BUZdm6-Q_Wo=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/carrot-soup-e2a833ef5926415580ca4f1efaff31ba.jpg'),
('Maple Roasted Carrots', 'https://www.eatingwell.com/thmb/gwspOmQByJR2DdcECwY521kUcuE=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/4969963-9272b22302bd41949b72b9b78c05f845.jpg'),
('Carrot-Apple Smoothie', 'https://www.eatingwell.com/thmb/0kyBmPiwM8B0uRQ4ImG7NBHuq0Q=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/carrot-apple-smoothie-1244-8a4aced134a947f692e9ead8427ca858.jpg');



