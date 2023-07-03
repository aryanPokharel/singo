const express = require("express");
const router = express.Router();
const mongoose = require("mongoose");
const User = require("../models/User");

mongoose.set("strictQuery", true);
mongoose.connect("mongodb://localhost/singo");

router
  .route("/")

  .get(async (req, res) => {
    try {
      const email = req.body.email;
      const password = req.body.password;

      const Users = await User.find();

      var response = 'na';
      for (var i = 0; i < Users.length; i++){
        if ((Users[i].email == email) && (Users[i].password == password)){
          response = "found";
        }
        else {
          response = "Not found"
        }
    }
      res.send(response)
    } catch {
      res.send("-1");
    }
  })

  .post(async (req, res) => {
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
          country: country,
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
