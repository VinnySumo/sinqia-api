const cors = require('cors'); 
const express = require("express");
const fileUpload = require("express-fileupload");
const router = require('./routes/routes');

const app = express(); 

app.use(cors()); 
app.use(express.json()); 
app.use(fileUpload({ useTempFiles: true, tempFileDir: "/tmp/" }));
app.use(router);

const porta = 3333;

app.listen(porta, () => {
    console.log(`Servidor iniciado na porta ${porta}`);
});

// Rota de verificação de status
app.get('/health', (req, res) => {
    res.status(200).send('API funcionando corretamente!');
});

app.get('/', (request, response) => {
    response.send('Hello World');
});
