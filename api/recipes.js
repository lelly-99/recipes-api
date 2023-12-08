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

      const dishes = await recipe_service_instance.show_dishes();
      res.json({
        status: "success",
        data: dishes,
      });
    } catch (err) {
			res.json({
				status: "error",
				error: err.stack
			});
		}
  }
  
  async function allDishesforItem(req, res) {
    try {
      const item = req.params.item

      const dishesForItem = await recipe_service_instance.selectDishesByItem(item);
      res.json({
        status: "success",
        data: dishesForItem,
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
        data: display_dish
      });
    } 
    catch (err) {
			res.json({
				status: "error getting selected dish",
				error: err.stack
			});
		}
  }
//start here
  async function addUser(req, res) {
    const {name, password, email} = req.body;
    try {
       await recipe_service_instance.display_dish_by_id(name, password, email);
      res.json({
        status: "success"
      });
    } 
    catch (err) {
			res.json({
				status: "error",
				error: err.stack
			});
		}
  }

  async function logIn(req, res) {
    const {email, password} = req.body;
    try {
       const userData = await recipe_service_instance.logUserIn(email, password);
      res.json({
        status: "success",
        data:userData
      });
    } 
    catch (err) {
			res.json({
				status: "error",
				error: err.stack
			});
		}
  }

  async function selectRecipeByDishName(req, res) {
    const dishName = req.params.dishName;
    try {
       const dishData = await recipe_service_instance.selectRecipeByDishName(dishName);
      res.json({
        status: "success",
        data:dishData
      });
    } 
    catch (err) {
			res.json({
				status: "error",
				error: err.stack
			});
		}
  }

  async function updateLeaderboard(req, res) {
    const {email , dishesCooked} = req.body.dishName;
    try {
        await recipe_service_instance.addOrUpdateUserPoints(email, dishesCooked);
      res.json({
        status: "success"
      });
    } 
    catch (err) {
			res.json({
				status: "error",
				error: err.stack
			});
		}
  }
  async function getLeaderboardData(req, res) {
    
    try {
       const leaderboardData = await recipe_service_instance.leaderboardData();
      res.json({
        status: "success",
        data:leaderboardData
      });
    } 
    catch (err) {
			res.json({
				status: "error",
				error: err.stack
			});
		}
  }

  return {
    api,
    all_dishes,
    dish_by_id,
    selected_dish,
    addUser,
    logIn,
    selectRecipeByDishName,
    updateLeaderboard,
    getLeaderboardData,
    allDishesforItem
  };
}
