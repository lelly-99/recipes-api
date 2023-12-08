import assert from 'assert';
import pgPromise from 'pg-promise';
import dotenv from "dotenv"
import recipe_service from '../service/recipe_service.js';
dotenv.config()


const connectionString = process.env.DATABASE_URL_TEST ;


const pgp = pgPromise();
const db = pgp({ connectionString});

const recipService = recipe_service(db)

describe("The recipe_service Function", function () {
    this.timeout(8000);
    before(async ()=>{
        await db.none(`DELETE FROM leaderboard;`);
        await db.none(`DELETE FROM users ;`);
        await db.none(`ALTER SEQUENCE users_id_seq RESTART WITH 1;`);
        await db.query('ALTER SEQUENCE leaderboard_leaderboard_id_seq RESTART WITH 1;');

    })

    it("Should add a user",async ()=>{
        const username = 'user1';
        const userpassword = 'myPassword';
        const email = "user1@gmail.com"
        const checkTableQuery = `SELECT * FROM users;`

        await recipService.addUser(username, userpassword,email);
    
        const tableRows = await db.query(checkTableQuery);
    
        assert.equal(tableRows.length, 1);

    })
    it("Should be able to log a user in",async ()=>{
        const user = await recipService.logUserIn('user1@gmail.com', 'myPassword')
        

        assert.equal(user.user_email,'user1@gmail.com');
        assert.equal(user.user_name,'user1');

    })
    
    it("should be able get a dish by it's id", async function () {
        
        const dish = await recipService.select_dish_by_id(2)
     
        assert.deepEqual(dish, {
            dish_id: 2,
            dish_name: 'Carrot Soup',
            dish_image: 'https://www.eatingwell.com/thmb/vluYF2Sx7V55Au64BUZdm6-Q_Wo=/750x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/carrot-soup-e2a833ef5926415580ca4f1efaff31ba.jpg',
            dish_points: 22
          });
    });
    it("should be able get a dishes of the item scanned", async function () {
        
        const dishes = await recipService.selectDishesByItem('Carrot')
     
        assert.deepEqual(dishes[1].dish_name.includes('Carrot'), true);
        assert.deepEqual(dishes[2].dish_name.includes('Carrot'), true);
    });

    it("should be able get the recipe for a dish", async function () {
        
        const recipe = await recipService.selectRecipeByDishName('Honey & Orange Glazed Carrots')
     
        assert.strictEqual(recipe.ingredients, 'Carrots, Honey, Orange juice, Olive oil, Salt, Black pepper');
        assert.strictEqual(recipe.cook_time, 30);
    });

    it("should be update points on the leaderboard", async function () {
        
         await recipService.addOrUpdateUserPoints("user1@gmail.com",'Carrot Soup')
         await recipService.addOrUpdateUserPoints("user1@gmail.com",'Carrot Soup')

         const [leaderboardData] = await recipService.leaderboardData()
     
        assert.deepEqual(leaderboardData.points, 44);
        assert.equal(leaderboardData.dishes_cooked,2);
    });


   
    

    after(function () {
        db.$pool.end()
    });

});

