const express = require('express')

const app = express()
const PORT_NUM = 80

const bodyParser = require('body-parser'); 
app.use(express.urlencoded({ extended: true}))

const cors = require('cors') 
app.use(cors());

app.use(bodyParser.json());
// Importing DB
// const db = require('./db/db_connection')
// app.use(db)

// Importing the routers
const userRouter = require('./routers/userRouter')
const performanceRouter = require('./routers/performaceRouter')


// Use the routers
app.use('/users',userRouter)
app.use('/performances', performanceRouter)

app.use(express.json())


app.listen(PORT_NUM)