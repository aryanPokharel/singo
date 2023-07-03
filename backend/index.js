const express = require('express')

const app = express()
const PORT_NUM = 80

const bodyParser = require('body-parser'); 
app.use(express.urlencoded({ extended: true}))

const cors = require('cors') 
app.use(cors({origin: true, credentials: true}));

app.use(bodyParser.json());

// Importing the routers
app.use(express.json())


app.listen(PORT_NUM)