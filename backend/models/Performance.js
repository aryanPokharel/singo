const mongoose = require("mongoose");

const performanceSchema = new mongoose.Schema({
  createdBy: {
    type: mongoose.Schema.Types.ObjectId, // Storing the user ID
    ref: "User", // Reference to the User model
    require: true,
  },
  rate : {
    type : String,
    require : true,
  },
  performer: {
    type: String,
    default: "N/A",
  },
  video: {
    type: String,
    default: "N/A",
  },
  views: {
    type: Number,
    default: 0,
  },
  title: {
    type: String,
    require: true,
  },
  description: {
    type: String,
    default: "N/A",
  },
  createdAt: {
    type: Date,
    default: Date.now,
    require: true,
  },
  updatedAt: {
    type: Date,
    default: Date.now,
  },
  updatedBy: {
    type: mongoose.Schema.Types.ObjectId, // Storing the user ID
    ref: "User", // Reference to the User model
  },
  performed : {
    type : Boolean,
    default : false
  }
});

module.exports = mongoose.model("Performance", performanceSchema);
