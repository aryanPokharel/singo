const mongoose = require('mongoose');

const userSchema = new mongoose.Schema({
  fullName: {
    type: String,
    require : true,
  },
  email: {
    type: String,
    unique: true,
    require : true
  },
  phone : {
    type : String,

  },
  dob : {
    type : String,
 
  }
});

module.exports = mongoose.model(
    "User", userSchema
)
