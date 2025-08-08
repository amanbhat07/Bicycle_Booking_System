const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const rideRoutes = require('./routes/rideRoutes');

const app = express();
const PORT = 3000;

app.use(cors());
app.use(bodyParser.json());
app.use(express.static('public'));
app.use('/api/rides', rideRoutes);

app.listen(PORT, () => {
    console.log(`Server is running at http://localhost:${PORT}`);
});