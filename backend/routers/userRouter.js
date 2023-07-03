const express = require("express");
const router = express.Router();
const mongoose = require("mongoose");
const User = require("../models/User");

mongoose.set("strictQuery", true);
mongoose.connect("mongodb://localhost/singo");

router.route("/").post(
  async (req, res) => {
    try {
      const fullname = req.body.fullname;
      const email = req.body.email;
      const phone = req.body.phone;
      const dob = req.body.dob;
      // Code to save the received user to database
      const newUser = User({
        fullName: fullname,
        email: email,
        phone: phone,
        dob: dob,
      });
      await newUser
        .save()
        .then(() => {
          res.send("1");
        })
        .catch((e) => {
          console.log(e);
        });
    } catch {
      res.send("-1");
    }
  }
)

module.exports = router;
