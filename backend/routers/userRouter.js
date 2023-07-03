const express = require("express");
const router = express.Router();
const mongoose = require("mongoose");
const User = require("../models/User");

mongoose.set("strictQuery", true);
mongoose.connect("mongodb://localhost/singo");

router.route("/").post(async (req, res) => {
  console.log("hit");
  try {
    const fullname = req.body.fullname;
    const email = req.body.email;
    const password = req.body.password;
    const phoneCountryCode = req.body.phone.countryCode;
    const phoneNumber = req.body.phone.number;
    const country = req.body.phone.country;
    const dob = req.body.dob;

    // Code to save the received user to database
    const newUser = User({
      fullName: fullname,
      email: email,
      password: password,
      phone: {
        countryCode: phoneCountryCode,
        country : country,
        number: phoneNumber,
      },
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
});

module.exports = router;
