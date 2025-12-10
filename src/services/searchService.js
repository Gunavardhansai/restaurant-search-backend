const db = require('../db');
exports.search = async ({ name, minPrice, maxPrice }) => {
  const conn = await db.getConnection();
  const [rows] = await conn.execute(`
    SELECT r.id as restaurantId, r.name as restaurantName, r.city,
    m.name as dishName, m.price as dishPrice, COUNT(o.id) as orderCount
    FROM menu_items m
    JOIN restaurants r ON m.restaurant_id = r.id
    JOIN orders o ON o.menu_item_id = m.id
    WHERE m.name LIKE CONCAT('%', ?, '%')
      AND m.price BETWEEN ? AND ?
    GROUP BY r.id, m.id
    ORDER BY orderCount DESC
    LIMIT 10
  `, [name, minPrice, maxPrice]);
  conn.release();
  return rows;
};
