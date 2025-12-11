# restaurant-search-backend
# Restaurant Search Backend

Simple Node.js + Express backend with MySQL that lets users **search restaurants by dish name** within a **mandatory price range**, returning the **top 10 restaurants** where that dish was ordered the most.

This repository is built to match a take-home assignment requirement and is interview-ready.

* * *

## Table of contents

*   Features
    
*   Tech stack
    
*   Project structure
    
*   Quick start (Windows / macOS / Linux)
    
*   Environment variables
    
*   Database schema & seed
    
*   API
    
*   Example request & response
    
*   Testing & validation
    
*   Deployment (Railway / Render)
    
*   Troubleshooting
    
*   Extensions & interview talking points
    
*   License
    

* * *

## Features

*   `GET /search/dishes?name=<>&minPrice=<>&maxPrice=<>` — search by dish name with mandatory price range
    
*   Returns top 10 restaurants by number of orders of that dish
    
*   Uses SQL `JOIN`, `GROUP BY`, `COUNT` and ordering for accurate counts
    
*   Seed SQL to create sample data (20 restaurants + dishes + orders)
    
*   Minimal, easy-to-read codebase for interview modifications
    

* * *

## Tech stack

*   Node.js (LTS)
    
*   Express
    
*   MySQL
    
*   `mysql2` (promise API)
    
*   `dotenv` for environment variables
    
*   `nodemon` (dev)
    

* * *

## Project structure

`. ├── src │   ├── app.js                 # Express app │   ├── routes │   │   └── searchRoutes.js │   ├── controllers │   │   └── searchController.js │   ├── services │   │   └── searchService.js │   └── db │       └── index.js           # mysql2 pool/connection ├── seed │   ├── schema.sql             # create DB, tables, indexes │   └── seed.sql               # sample data (20 restaurants) ├── .env.example ├── package.json └── README.md`

* * *

## Quick start (Windows / macOS / Linux)

### 1\. Clone repo

`git clone <your-repo-url> cd restaurant-search-backend`

### 2\. Install dependencies

`npm install`

### 3\. Set up MySQL

Make sure MySQL server is installed and running. Create the database and import schema + seed.

#### macOS / Linux / Git Bash

`mysql -u root -p < seed/schema.sql mysql -u root -p < seed/seed.sql`

#### Windows PowerShell

PowerShell does not support `<` redirection directly; use CMD wrapper:

`cmd /c "mysql -u root -p restaurant_finder_db < seed\schema.sql" cmd /c "mysql -u root -p restaurant_finder_db < seed\seed.sql"`

> If `mysql` is not recognized, add the MySQL `bin` folder to your PATH, then restart terminal.

### 4\. Configure environment variables

Copy `.env.example` to `.env` and update credentials:

`cp .env.example .env         # macOS / Linux copy .env.example .env       # PowerShell`

Edit `.env`:

`DB_HOST=localhost DB_PORT=3306 DB_USER=root DB_PASSWORD=your_mysql_password_or_empty DB_NAME=restaurant_finder_db PORT=3000`

### 5\. Run the server

`npm run dev`

Server should log:

`Server listening on port 3000`

* * *

## Environment variables

*   `DB_HOST` — MySQL host (default: `localhost`)
    
*   `DB_PORT` — MySQL port (default: `3306`)
    
*   `DB_USER` — MySQL username

*   `DB_PASSWORD` — MySQL password (empty value allowed)
    
*   `DB_NAME` — Database name (`restaurant_finder_db` by default)
    
*   `PORT` — HTTP server port (default: `3000`)
    

* * *

## Database schema & seed

*   `seed/schema.sql` creates tables:
    
    *   `restaurants` (id, name, city)
        
    *   `menu_items` (id, restaurant\_id, name, price)
        
    *   `orders` (id, menu\_item\_id, ordered\_at)
        
*   `seed/seed.sql` includes 20 restaurants, 3 menu items each and sample orders primarily for Chicken Biryani to generate meaningful top results.
    

If you need to reseed safely, the `seed.sql` provided truncates tables to avoid duplicates before inserting.

* * *

## API

### GET `/search/dishes`

Search top restaurants for a dish within a mandatory price range.

**Query parameters (required):**

*   `name` — dish name (partial match; `LIKE %name%`)
    
*   `minPrice` — minimum price (inclusive)
    
*   `maxPrice` — maximum price (inclusive)
    

**Response shape:**

`{   "restaurants": [     {       "restaurantId": 1,       "restaurantName": "Hyderabadi Spice House",       "city": "Hyderabad",       "dishName": "Chicken Biryani",       "dishPrice": "220.00",       "orderCount": 6     }   ] }`

**Validation rules**

*   All three parameters are required
    
*   `minPrice` and `maxPrice` must be numbers
    
*   `minPrice` must be <= `maxPrice`
    

* * *

## Example request & response

**Request (curl):**

`curl "http://localhost:3000/search/dishes?name=biryani&minPrice=200&maxPrice=260"`

**Sample response:**

`{   "restaurants": [     {       "restaurantId": 1,       "restaurantName": "Hyderabadi Spice House",       "city": "Hyderabad",       "dishName": "Chicken Biryani",       "dishPrice": "220.00",       "orderCount": 10     },     {       "restaurantId": 2,       "restaurantName": "Royal Dum Biryani",       "city": "Bangalore",       "dishName": "Chicken Biryani",       "dishPrice": "230.00",       "orderCount": 9     }   ] }`

* * *

## Testing & validation

Manual tests:

*   Health check:
    
    `GET /health`
    
    → `{ "status": "ok" }`
    
*   Missing param test:
    
    `GET /search/dishes?name=biryani&minPrice=200`
    
    → `400` with error message.
    

Automated tests (optional):

*   Add `jest` + `supertest` to test endpoints.
    
*   Test cases: valid query, missing params, invalid prices, DB errors.
    

* * *

## Deployment (Railway / Render)

**High-level steps**

1.  Push code to GitHub.
    
2.  Create a MySQL database on the platform (Railway or Render managed DB).
    
3.  Obtain DB credentials and set environment variables in the platform dashboard.
    
4.  Run `schema.sql` and `seed.sql` against the hosted DB (Railway has a SQL runner; otherwise use an external client).
    
5.  Deploy the Node app and set start command (`node src/app.js` or `npm start`).
    
6.  Confirm the deployed route:
    
    `https://<your-app>.railway.app/search/dishes?name=biryani&minPrice=200&maxPrice=260`
    

**Notes**

*   Use connection pooling (`mysql2` pool is already set up).
    
*   Make sure the platform allows outbound connections to the managed MySQL (Railway binds them automatically).
    

* * *

## Troubleshooting

*   `ER_ACCESS_DENIED_ERROR` — incorrect DB user/password. Fix `.env`.
    
*   `ECONNREFUSED` — MySQL server not running or host wrong.
    
*   `mysql not recognized` (Windows) — add MySQL `bin` folder to PATH and restart terminal.
    
*   Duplicate rows after reseeding — truncate tables before inserting (seed file already handles this if included).
    
*   If `orderCount` shows `0` rows: ensure seed created orders, or change `LEFT JOIN orders` to `JOIN orders` in `src/services/searchService.js` to exclude zero-order menu items.
    

* * *

## Extensions & interview talking points

*   Add `city` filter: `?city=Hyderabad`
    
*   Add pagination: `limit` and `offset`
    
*   Add exact match vs partial match toggle
    
*   Add caching (Redis) for frequent queries
    
*   Add restaurant rating and sort by weighted score (orders \* rating)
    
*   Discuss indexes: `menu_items(name)`, `menu_items(price)`, and `orders(menu_item_id)` — these speed up the search.
    

Be prepared to:

*   Explain why `GROUP BY` + `COUNT` is used
    
*   Walk through the SQL query and indexes
    
*   Modify an endpoint live (e.g., add city filter)
    

* * *

## Git & deploy checklist

`git init git add . git commit -m "Initial: restaurant search backend" git branch -M main git remote add origin https://github.com/<your-username>/restaurant-search-backend.git git push -u origin main`

Then connect the GitHub repo to Railway / Render and deploy.

* * *

## License

MIT License — feel free to reuse and adapt the code.
