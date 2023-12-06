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
    Instructions TEXT,
    ingredients TEXT
);


INSERT INTO dishes (dish_name, dish_image) VALUES
('Honey & Orange Glazed Carrots', 'https://www.eatingwell.com/thmb/F6HsFFEw9LHzy1ITrSzLzXxmeqM=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/7104339-4f33c5eae8594a1f9831e76f41ce99b9.jpg'),
('Carrot Soup', 'https://www.eatingwell.com/thmb/vluYF2Sx7V55Au64BUZdm6-Q_Wo=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/carrot-soup-e2a833ef5926415580ca4f1efaff31ba.jpg'),
('Maple Roasted Carrots', 'https://www.eatingwell.com/thmb/gwspOmQByJR2DdcECwY521kUcuE=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/4969963-9272b22302bd41949b72b9b78c05f845.jpg'),
('Carrot-Apple Smoothie', 'https://www.eatingwell.com/thmb/0kyBmPiwM8B0uRQ4ImG7NBHuq0Q=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/carrot-apple-smoothie-1244-8a4aced134a947f692e9ead8427ca858.jpg');


INSERT INTO recipes (Instructions, ingredients) VALUES
( 'Place carrots in a high-sided skillet and add water to cover by about 1/4 inch. Bring to boil over medium-high; cook until just tender, about 5 to 6 minutes. Drain carrots in a large colander and rinse with cold water. Add honey, butter, orange juice and thyme leaves to skillet; bring mixture to a simmer over medium-high; add carrots and toss to coat. Cook, tossing gently, until honey mixture has reduced and carrots are coated and glazed, 5 to 6 minutes. Remove from heat, and sprinkle with salt and pepper, tossing gently to coat. Place carrots on a serving plate and drizzle with any remaining sauce. Serve immediately.',
 '2 pounds medium-size multi-colored carrots, peeled and tops trimmed; ¼ cup honey; 3 tablespoons unsalted butter; 3 tablespoons fresh orange juice (from 1 orange); 2 teaspoons fresh thyme leaves; 1 teaspoon kosher salt; ¼ teaspoon black pepper');

INSERT INTO recipes (Instructions, ingredients) VALUES
( 
 'Combine carrots, banana, apple, coconut milk, lemon juice, ginger and turmeric in a blender. Process until smooth, about 45 seconds. Add ice cubes and process until smooth, about 30 seconds. Serve immediately.',
 '2 large carrots, sliced (about 1 1/2 cups); 1 medium-ripe banana; 1 large Honeycrisp apple, cored and quartered; 1 cup light coconut milk; 2 tablespoons fresh lemon juice; 2 teaspoons minced fresh ginger; 2 teaspoons minced fresh turmeric or 1 teaspoon ground turmeric; ½ cup ice cubes');

INSERT INTO recipes (Instructions, ingredients) VALUES
( 
 'Preheat oven to 400°F. Stir carrots, butter, maple syrup, salt and pepper together in a large bowl. Spread evenly on a large rimmed baking sheet and roast, stirring once, until tender, 20 to 25 minutes. Sprinkle with chives, if desired.',
 '1 ½ pounds carrots, sliced 1/4 inch thick on the diagonal; 2 tablespoons melted butter; 2 tablespoons pure maple syrup; ½ teaspoon salt; ¼ teaspoon ground pepper; 2 teaspoons snipped fresh chives (Optional)');

INSERT INTO recipes (Instructions, ingredients) VALUES
(
 'Heat butter and oil in a Dutch oven over medium heat until the butter melts. Add onion and celery; cook, stirring occasionally, until softened, 4 to 6 minutes. Add garlic and thyme (or parsley); cook, stirring, until fragrant, about 10 seconds. Stir in carrots. Add water and broth; bring to a lively simmer over high heat. Reduce heat to maintain a lively simmer and cook until very tender, about 25 minutes.',
 '1 tablespoon butter; 1 tablespoon extra-virgin olive oil; 1 medium onion, chopped; 1 stalk celery, chopped; 2 cloves garlic, chopped; 1 teaspoon chopped fresh thyme or parsley; 5 cups chopped carrots; 2 cups water; 4 cups reduced-sodium chicken broth, "no-chicken" broth (see Note) or vegetable broth; ½ cup half-and-half (optional); ½ teaspoon salt; Freshly ground pepper to taste');

