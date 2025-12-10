const service = require('../services/searchService');
exports.searchDishes = async (req, res) => {
  try {
    const { name, minPrice, maxPrice } = req.query;
    if (!name || !minPrice || !maxPrice)
      return res.status(400).json({ error: 'Missing params' });
    const data = await service.search({ name, minPrice, maxPrice });
    res.json({ restaurants: data });
  } catch (e) {
    console.error(e);
    res.status(500).json({ error: 'Internal server error' });
  }
};
