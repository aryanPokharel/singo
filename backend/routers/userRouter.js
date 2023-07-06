const express = require("express");
const router = express.Router();
const mongoose = require("mongoose");
const User = require("../models/User");

mongoose.set("strictQuery", true);
mongoose.connect(
  "mongodb+srv://ourSingo:cBJG4iJF9LAIgK5r@cluster0.2w5z0ad.mongodb.net/SingoAppDb?retryWrites=true&w=majority"
);

router.route("/").post(async (req, res) => {
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

router
  .route("/login")

  .post(async (req, res) => {
    try {
      const email = req.body.email;
      const password = req.body.password;

      const Users = await User.find();
      var response = "Not found";

      for (var i = 0; i < Users.length; i++) {
        if (Users[i].email === email && Users[i].password === password) {
          response = {
            id: Users[i]._id,
            fullName: Users[i].fullName,
            email: Users[i].email,
            password: Users[i].password,
            phone: Users[i].phone,
            dob: Users[i].dob,
            photo: Users[i].photo,
          };
          break;
        }
      }
      res.send(response);
    } catch {
      res.send("-1");
    }
  });
module.exports = router;
