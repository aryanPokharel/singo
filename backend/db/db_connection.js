

const ConnectDB = ()=> {
    const mongoose = require('mongoose')

    mongoose.connect('mongocb://localhost/singo', ()=>{
    console.log("Connected!")
})

}

module.exports = ConnectDB;