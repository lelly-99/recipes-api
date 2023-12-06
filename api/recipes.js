export default function recipe_api(recipe_service_instance) {
  async function api(req, res) {
    try {
      res.json(
        "Recipe API" 
      );
    } catch (err) {
      console.log("Error getting api", err);
    }
  }
  
  async function all_dishes(req, res) {
    try {
      let allDishes = await recipe_service_instance.show_dishes();
      res.json({
        status: "success",
        data: allDishes,
      });
    } catch (err) {
			res.json({
				status: "error",
				error: err.stack
			});
		}
  }

  async function dish_by_id(req, res) {
    const dish = req.params.dish_id;
    try {
      let get_dish = await recipe_service_instance.select_dish_by_id(
        dish
      );
      res.json({
        status: "success",
        data: get_dish,
      });
    } catch (err) {
			res.json({
				status: "error getting dish",
				error: err.stack
			});
		}
  }

  async function selected_dish(req, res) {
    const dish = req.params.dishes_id;
    try {
      let display_dish = await recipe_service_instance.display_dish_by_id(dish);
      res.json({
        status: "success",
        data: display_dish,
      });
    } 
    catch (err) {
			res.json({
				status: "error getting selected dish",
				error: err.stack
			});
		}
  }

  return {
    api,
    all_dishes,
    dish_by_id,
    selected_dish,
  };
}
