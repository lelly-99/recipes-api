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

INSERT INTO dishes (dish_name, dish_image, dish_points) VALUES 
('Apple Cinnamon & Nuts Oatmeal', 'https://veggiecurean.com/wp-content/uploads/2016/04/steel-cut-oatmeal-with-apples-1500x750.jpg', 38),
('Oat Cookies', 'https://lovingitvegan.com/wp-content/uploads/2021/10/Vegan-Oatmeal-Cookies-17.jpg', 40),
('Overnight Oats', 'https://feelgoodfoodie.net/wp-content/uploads/2023/04/Overnight-Oats-18.jpg', 20),
('Oat Muffins', 'https://www.ihearteating.com/wp-content/uploads/2019/01/Oatmeal-muffins-5-800.jpg', 40);


INSERT INTO recipes (dishes_id, prep_time, cook_time, Instructions, ingredients) VALUES 
((SELECT dish_id FROM dishes WHERE dish_name = 'Apple Cinnamon & Nuts Oatmeal'),10, 15, 
'The night before, place the steel-cut oats in a small bowl and add water over the top to soak. Let it soak overnight in the refrigerator.
The morning of, pour the milk in a medium saucepan and heat over medium heat, then let it warm through and simmer for 1 minute.
Drain the oats and add them to the milk in the pan. Bring the mixture to a boil, then reduce to a gentle simmer and cook for 10-15 minutes on low, stirring occasionally. (If you like your oatmeal thicker and dryer, cook for an additional 5 minutes.)
Take the pan off of the heat and stir in the maple syrup, chopped apples, cinnamon, and walnuts. Mix well and cover it with a lid, then let it sit for 5 minutes so all the flavors come together and the apples soften slightly.
Serve immediately.',
'1 cup steel-cut oats (gluten-free if preferred)
1 1/2 cups almond or soy milk
1/4 cup maple syrup
1 cup red apple (unpeeled, chopped)
1/4 teaspoon cinnamon
1/2 cup walnuts (chopped)'
);



  