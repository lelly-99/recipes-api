import pgPromise from "pg-promise";
import recipe_service from "./service/recipe_service.js";
import cors from "cors"
import express from "express";
import recipe_api from "./api/recipes.js";


const pgp = pgPromise();

//SSL connection
let useSSL = false;
let local = process.env.LOCAL || false;
if (process.env.DATABASE_URL && !local) {
    useSSL = true;
}

// Database connection
const connectionString = process.env.DATABASE_URL || "postgres://acmtsvuo:KO-AC2wJi3vXKoeaiMtUBPAj-fKXIXsR@kesavan.db.elephantsql.com/acmtsvuo?ssl=true";

const database = pgp(connectionString);

//database instance
const recipe_service_instance = recipe_service(database);

//api instance
const api = recipe_api(recipe_service_instance)

//expressJS instance
const app = express();

//middleware configuration
app.use(express.json());
app.use(cors());


//API routes
app.get('/api/',api.api );

//display all dishes for the scanned item
app.get('/api/dishes', api.all_dishes );

//display all dishes for the scanned item
app.get('/api/dishes/:dish_name', api.allDishesforItem );

//select dish by id
app.get('/api/dishes/:dish_id',api.dish_by_id );

//display dish based on selected id
app.get('/api/recipes/:dishes_id', api.selected_dish);

//Select recipe for dish
app.get('/api/dishes/:name', api.selectRecipeByDishName);

//Select recipe for dish
app.get('/api/signUp', api.addUser);

//Select recipe for dish
app.post('/api/logIn', api.logIn);

///update leaderboard infor for user
app.post('/api/leaderboard', api.updateLeaderboard)

///Get leaderboardData
app.get('/api/leaderboardData', api.getLeaderboardData)



// Start the server
const PORT = process.env.PORT || 3007;
app.listen(PORT, function () {
    console.log("App started at port:", PORT);
});