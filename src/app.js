require('dotenv').config();
const express = require('express');
const searchRoutes = require('./routes/searchRoutes');
const app = express();
app.use(express.json());
app.get('/health', (req, res) => res.json({ status: 'ok' }));
app.use('/search', searchRoutes);
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Server listening on port ${PORT}`));
