const express = require('express');
const app = express();
const PORT = process.env.PORT || 3001;

app.get('/', (req, res) => {
    res.send('Hello World from Kubernetes via Microservice A Gitpod CDEs');
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});