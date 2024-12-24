const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const mysql = require('mysql');

const app = express();
const PORT = 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());

// Connect to MySQL database
const db = mysql.createConnection({
    host: 'localhost',
    user: 'root', // XAMPP default user
    password: '', // XAMPP default password
    database: 'weather_app', // Your MySQL database name
});

// Connect to MySQL
db.connect((err) => {
    if (err) {
        console.error('Error connecting to MySQL database:', err.message);
        return;
    }
    console.log('Connected to MySQL database.');
});

// Create the weather table if it doesn't exist
const createTableQuery = `
    CREATE TABLE IF NOT EXISTS weather (
        id INT AUTO_INCREMENT PRIMARY KEY,
        city VARCHAR(255),
        temperature FLOAT,
        description VARCHAR(255),
        humidity INT,
        date DATE
    )
`;
db.query(createTableQuery, (err) => {
    if (err) {
        console.error('Error creating table:', err.message);
    } else {
        console.log('Weather table ready.');
    }
});

// Save weather data
app.post('/saveWeather', (req, res) => {
    const { city, temperature, description, humidity } = req.body;
    const date = new Date().toISOString().split('T')[0]; // Format: YYYY-MM-DD

    const insertQuery = `
        INSERT INTO weather (city, temperature, description, humidity, date)
        VALUES (?, ?, ?, ?, ?)
    `;
    db.query(
        insertQuery,
        [city, temperature, description, humidity, date],
        (err, result) => {
            if (err) {
                console.error('Error inserting data:', err.message);
                res.status(500).send('Failed to save weather data.');
                return;
            }
            res.send('Weather data saved.');
        }
    );
});

// Retrieve the last 7 days of weather data
app.get('/getWeather', (req, res) => {
    const selectQuery = `
        SELECT * FROM weather
        WHERE date >= DATE_SUB(CURDATE(), INTERVAL 7 DAY)
        ORDER BY date DESC
    `;
    db.query(selectQuery, (err, rows) => {
        if (err) {
            console.error('Error retrieving data:', err.message);
            res.status(500).send('Failed to retrieve weather data.');
            return;
        }
        res.json(rows);
    });
});

// Start the server
app.listen(PORT, () => {
    console.log(`Server running at http://localhost:${PORT}`);
});
