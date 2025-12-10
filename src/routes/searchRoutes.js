const express = require('express');
const router = express.Router();
const controller = require('../controllers/searchController');
router.get('/dishes', controller.searchDishes);
module.exports = router;
