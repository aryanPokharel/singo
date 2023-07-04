const express = require("express");
const router = express.Router();
const mongoose = require("mongoose");
const Performance = require("../models/Performance");

mongoose.set("strictQuery", true);
mongoose.connect("mongodb://localhost/singo");

router
  .route("/post")

  .post(async (req, res) => {
    console.log(req.body.createdBy);
    try {
      const createdBy = req.body.createdBy;
      //   const performer = req.body.performer;
      //   const video = req.body.video;
      //   const views = req.body.views;
      const title = req.body.title;
      const description = req.body.description;
      const rate = req.body.rate;

      const newPerformance = Performance({
        createdBy: createdBy,
        updatedBy : createdBy,
        title: title,
        description : description,
        rate : rate,
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
module.exports = router;
