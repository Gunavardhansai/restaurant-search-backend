USE restaurant_finder_db;

SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE orders;
TRUNCATE TABLE menu_items;
TRUNCATE TABLE restaurants;
SET FOREIGN_KEY_CHECKS = 1;

-- 20 restaurants
INSERT INTO restaurants (id, name, city) VALUES
  (1, 'Hyderabadi Spice House', 'Hyderabad'),
  (2, 'Royal Dum Biryani', 'Bangalore'),
  (3, 'Nizam''s Delight', 'Hyderabad'),
  (4, 'Spice Route Diner', 'Mumbai'),
  (5, 'Coastal Cravings', 'Mangaluru'),
  (6, 'Biryani Junction', 'Pune'),
  (7, 'Curry Leaf Kitchen', 'Delhi'),
  (8, 'Masala Trails', 'Chennai'),
  (9, 'Tandoor Tales', 'Kolkata'),
  (10, 'Urban Tadka', 'Mumbai'),
  (11, 'Deccan Darbar', 'Hyderabad'),
  (12, 'Paradise Platter', 'Hyderabad'),
  (13, 'Pepper Pot', 'Kochi'),
  (14, 'Saffron Stories', 'Jaipur'),
  (15, 'Grill & Grains', 'Ahmedabad'),
  (16, 'Bombay Spice Co', 'Mumbai'),
  (17, 'Chennai Chettinad Corner', 'Chennai'),
  (18, 'Lucknowi Aroma', 'Lucknow'),
  (19, 'Punjabi Haveli', 'Amritsar'),
  (20, 'Royal Rasoi', 'Surat');

-- 3 dishes per restaurant (60 menu items total)
-- For each restaurant: Chicken Biryani, Veg Biryani, Paneer Butter Masala
INSERT INTO menu_items (id, restaurant_id, name, price) VALUES
  (1, 1, 'Chicken Biryani', 220.00),
  (2, 1, 'Veg Biryani', 180.00),
  (3, 1, 'Paneer Butter Masala', 240.00),

  (4, 2, 'Chicken Biryani', 230.00),
  (5, 2, 'Veg Biryani', 175.00),
  (6, 2, 'Paneer Butter Masala', 235.00),

  (7, 3, 'Chicken Biryani', 210.00),
  (8, 3, 'Veg Biryani', 170.00),
  (9, 3, 'Paneer Butter Masala', 230.00),

  (10, 4, 'Chicken Biryani', 225.00),
  (11, 4, 'Veg Biryani', 185.00),
  (12, 4, 'Paneer Butter Masala', 250.00),

  (13, 5, 'Chicken Biryani', 215.00),
  (14, 5, 'Veg Biryani', 175.00),
  (15, 5, 'Paneer Butter Masala', 245.00),

  (16, 6, 'Chicken Biryani', 205.00),
  (17, 6, 'Veg Biryani', 170.00),
  (18, 6, 'Paneer Butter Masala', 235.00),

  (19, 7, 'Chicken Biryani', 240.00),
  (20, 7, 'Veg Biryani', 190.00),
  (21, 7, 'Paneer Butter Masala', 260.00),

  (22, 8, 'Chicken Biryani', 220.00),
  (23, 8, 'Veg Biryani', 180.00),
  (24, 8, 'Paneer Butter Masala', 250.00),

  (25, 9, 'Chicken Biryani', 230.00),
  (26, 9, 'Veg Biryani', 185.00),
  (27, 9, 'Paneer Butter Masala', 255.00),

  (28, 10, 'Chicken Biryani', 225.00),
  (29, 10, 'Veg Biryani', 180.00),
  (30, 10, 'Paneer Butter Masala', 245.00),

  (31, 11, 'Chicken Biryani', 220.00),
  (32, 11, 'Veg Biryani', 175.00),
  (33, 11, 'Paneer Butter Masala', 240.00),

  (34, 12, 'Chicken Biryani', 215.00),
  (35, 12, 'Veg Biryani', 180.00),
  (36, 12, 'Paneer Butter Masala', 235.00),

  (37, 13, 'Chicken Biryani', 210.00),
  (38, 13, 'Veg Biryani', 170.00),
  (39, 13, 'Paneer Butter Masala', 230.00),

  (40, 14, 'Chicken Biryani', 235.00),
  (41, 14, 'Veg Biryani', 185.00),
  (42, 14, 'Paneer Butter Masala', 255.00),

  (43, 15, 'Chicken Biryani', 220.00),
  (44, 15, 'Veg Biryani', 175.00),
  (45, 15, 'Paneer Butter Masala', 240.00),

  (46, 16, 'Chicken Biryani', 230.00),
  (47, 16, 'Veg Biryani', 180.00),
  (48, 16, 'Paneer Butter Masala', 250.00),

  (49, 17, 'Chicken Biryani', 215.00),
  (50, 17, 'Veg Biryani', 175.00),
  (51, 17, 'Paneer Butter Masala', 245.00),

  (52, 18, 'Chicken Biryani', 225.00),
  (53, 18, 'Veg Biryani', 180.00),
  (54, 18, 'Paneer Butter Masala', 250.00),

  (55, 19, 'Chicken Biryani', 235.00),
  (56, 19, 'Veg Biryani', 185.00),
  (57, 19, 'Paneer Butter Masala', 255.00),

  (58, 20, 'Chicken Biryani', 220.00),
  (59, 20, 'Veg Biryani', 175.00),
  (60, 20, 'Paneer Butter Masala', 240.00);

-- Orders: we mainly add orders for Chicken Biryani in each restaurant
-- menu_item_ids for Chicken Biryani are: 1,4,7,10,13,16,19,22,25,28,31,34,37,40,43,46,49,52,55,58
-- More orders for first few to simulate "top" restaurants
INSERT INTO orders (menu_item_id) VALUES
  -- Restaurant 1 (id=1) - very popular
  (1),(1),(1),(1),(1),(1),(1),(1),(1),(1),

  -- Restaurant 2
  (4),(4),(4),(4),(4),(4),(4),(4),(4),

  -- Restaurant 3
  (7),(7),(7),(7),(7),(7),(7),(7),

  -- Restaurant 4
  (10),(10),(10),(10),(10),(10),(10),

  -- Restaurant 5
  (13),(13),(13),(13),(13),(13),

  -- Restaurant 6
  (16),(16),(16),(16),(16),

  -- Restaurant 7
  (19),(19),(19),(19),

  -- Restaurant 8
  (22),(22),(22),

  -- Restaurant 9
  (25),(25),

  -- Restaurant 10
  (28);
