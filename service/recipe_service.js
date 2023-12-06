
const recipe_service = (db) => {
  
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
  };
};
export default recipe_service;

