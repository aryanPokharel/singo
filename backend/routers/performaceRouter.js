const express = require("express");
const router = express.Router();
const mongoose = require("mongoose");
const Performance = require("../models/Performance");

mongoose.set("strictQuery", true);
mongoose.connect(
  "mongodb+srv://ourSingo:cBJG4iJF9LAIgK5r@cluster0.2w5z0ad.mongodb.net/SingoAppDb?retryWrites=true&w=majority"
);

router
  .route("/post")

  .post(async (req, res) => {
    try {
      const createdBy = req.body.createdBy;
      const title = req.body.title;
      const description = req.body.description;
      const rate = req.body.rate;

      const newPerformance = Performance({
        createdBy: createdBy,
        updatedBy: createdBy,
        title: title,
        description: description,
        rate: rate,
      });
      await newPerformance
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

router.route("/").get(async (req, res) => {
  try {
    const Performances = await Performance.find();

    var response = [];
    for (var i = 0; i < Performances.length; i++) {
      if (Performances[i].performed == false) {
        response.push(Performances[i]);
      } else {
        console.log("true");
      }
    }
    res.json(response);
  } catch (error) {
    res.send("-1");
  }
});

router.route("/test").get((req, res) => {
  res.send("yeah");
});

router.route("/delete").delete(async (req, res) => {
  try {
    const toDelete = req.body.requestId;
    let response = "0";
    const deleteResult = await Performance.deleteOne({ _id: toDelete });
    if (deleteResult.deletedCount === 1) {
      response = "1";
    } else {
      response = "0";
    }
    res.send(response);
  } catch (err) {
    res.send("-1");
  }
});

module.exports = router;
