const express = require('express');
const router = express.Router();
const db = require('../db_connection');

// book a ride
router.post('/book', (req, res) => {
    const { ride_id, customer_id, bike_id, start_location_id, end_location_id, start_time, end_time, distance_covered, cost } = req.body;
    const sql = `insert into ride (ride_id, customer_id, bike_id, start_location_id, end_location_id, start_time, end_time, distance_covered, cost) values(?, ?, ?, ?, ?, ?, ?, ?, ?)`;
    db.query(sql, [ride_id, customer_id, bike_id, start_location_id, end_location_id, start_time, end_time, distance_covered, cost], (err) => {
        if (err) return res.status(500).json({error: err.message});
        res.send('Ride booked successfully.');
    });
});

// Top spender (calling of stored procedure)
router.get('/top-spender', (req, res) => {
    const sql = `call topSpender()`;
    db.query(sql, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results[0]);
    });
});

// Most driven bike (calling of stored procedure)
router.get('/most-driven-bike', (req, res) => {
    const sql = `call mostDrivenBike()`;
    db.query(sql, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results[0]);
    });
});

// Inspection needing bike (calling of stored procedure)
router.get('/inspection-needed', (req, res) => {
    const sql = `call inspectionNeeded()`;
    db.query(sql, (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results[0]);
    });
});

// Most recent ride histoty of the customer (calling os stored procedure)
router.get('/ride-history/:customer_id', (req, res) => {
    const cid = req.params.customer_id;
    const sql = `call rideHistory(?)`;
    db.query(sql, [cid], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results[0]);
    });
});

// Show bikes available at a particular location (calling of stored procedure)
router.get('/show-bikes/:bike_location_id', (req, res) => {
    const bid = req.params.bike_location_id;
    const sql = `call showBikes(?)`;
    db.query(sql, [bid], (err, results) => {
        if (err) return res.status(500).json({ error: err.message });
        res.json(results[0]);
    });
});

module.exports = router;