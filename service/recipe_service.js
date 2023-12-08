//import bcrypt
import bcrypt from "bcrypt";

const recipe_service = (db) => {


  const addUser = async (name, password, email) => {
    
    
    //hash the password
    const saltRounds = 10;
    const hashedPassword = await bcrypt.hash(password, saltRounds);

    //Insert user in the waiter table
    const insertQuery = `
        INSERT INTO users (user_name, user_password,user_email)
        VALUES ($1, $2,$3);
      `;

    await db.none(insertQuery, [name, hashedPassword, email]);

  }
  const logUserIn = async (email, enteredPassword) => {
    //check if user exists
    const checkUsernameQuery = `
    SELECT * FROM users WHERE user_email = $1;
    `;
    const [results] = await db.query(checkUsernameQuery, [email]);


    if (!results) {
      throw new Error("User not found");
    }
    const storedPassword = results.user_password;


    //Check if the password matches
    const passwordMatch = await bcrypt.compare(enteredPassword, storedPassword)

    //Return role if password is correct and throw error if they dont match
    if (passwordMatch) {
      return results;
    } else {
      throw new Error("Incorrect password");
    }

  }

  const selectDishByName = async (dish_name) => {
    return await db.oneOrNone("SELECT * FROM dishes WHERE dish_name = $1", dish_name);

  };

  const selectDishesByItem = async (item) => {
    
    return await db.manyOrNone("SELECT * FROM dishes WHERE Lower(dish_name) LIKE $1", [`%${item.toLowerCase()}%`]);
  };


  const selectRecipeByDishName = async (dishName) => {
    
    const dishId = await db.one(
      'SELECT dish_id FROM dishes WHERE dish_name = $1',
      [dishName]
    );
    return await db.one(`SELECT recipes.*, dishes.dish_name
    FROM recipes
    JOIN dishes ON recipes.dishes_id = dishes.dish_id;`, [dishId.dish_id]);
  };

  const addOrUpdateUserPoints = async (userEmail, dishesCooked) => {

    const userId = await db.one(
      'SELECT id FROM users WHERE user_email = $1',
      [userEmail]
    );

    const dishPoints = await db.one(
      'SELECT dish_points FROM dishes WHERE dish_name = $1',
      [dishesCooked]
    );


    // Attempt to insert a new row into the leaderboard table
    await db.none(`
      INSERT INTO leaderboard (user_id, dishes_cooked, points)
      VALUES ($1, $2, $3)
      ON CONFLICT (user_id)
      DO UPDATE
      SET dishes_cooked = leaderboard.dishes_cooked + $2,
          points = leaderboard.points + $3;
    `, [userId.id, 1, dishPoints.dish_points]);


  };

  const leaderboardData = async () => {

    return await db.manyOrNone(
      `SELECT * FROM leaderboard
      ORDER BY points DESC
      LIMIT 6;`
    );

  };




  const show_dishes = async () => {
    return await db.manyOrNone("SELECT * FROM Dishes");
  };

  const select_dish_by_id = async (dish_id) => {
    return await db.oneOrNone("SELECT * FROM dishes WHERE dish_id = $1", dish_id);

  };

  const display_dish_by_id = async (dishes_id) => {
    return await db.manyOrNone("SELECT dishes.dish_id, dishes.dish_name, dishes.dish_image, recipes.Instructions, recipes.ingredients FROM dishes INNER JOIN recipes ON dishes.dish_id = recipes.dishes_id WHERE dishes.dish_id = $1 ", dishes_id);
  };

  return {
    show_dishes,
    select_dish_by_id,
    display_dish_by_id,
    addUser,
    logUserIn,
    selectDishByName,
    selectDishesByItem,
    addOrUpdateUserPoints,
    leaderboardData,
    selectRecipeByDishName
  };
};
export default recipe_service;

