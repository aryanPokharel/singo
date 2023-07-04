const mongoose = require("mongoose");

const userSchema = new mongoose.Schema({
  fullName: {
    type: String,
    required: true,
  },
  email: {
    type: String,
    unique: true,
    required: true,
  },
  password: {
    type: String,
    required: true,
  },
  phone: {
    countryCode: {
      type: String,
    },
    country : {
      type : String
    },
    number: {
      type: String,
    },
  },
  dob: {
    type: String,
  },
  singer : {
    type : Boolean,
    default : false,
  }
});

module.exports = mongoose.model("User", userSchema);
