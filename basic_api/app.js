// Import Express framework and define port server will listen
const express = require('express');
const app = express();
const port = 3000;

// Return welcome message when root accessed
app.get('/', (req, res) => {
	res.send('Welcome to the API test');
});

// Return JSON answer when API route found
app.get('/api/data', (req, res) => {
	res.json({message: 'Answer from the API response' });
});

// Start server and listen on the port
app.listen(port, () => {
	console.log(`API runs on port ${port}`);
});