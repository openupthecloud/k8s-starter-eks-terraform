const express = require('express');
const app = express();
const PORT = process.env.PORT || 3001;

app.get('/', (req, res) => {
    res.send('Hello World from Kubernetes via Microservice A Gitpod CDEs Again Running Port 3000 - 10:06');
});

app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`);
});

process.on('SIGINT', () => {
    console.info("Interrupted")
    process.exit(0)
})