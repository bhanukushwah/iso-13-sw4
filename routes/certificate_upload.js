var express = require("express");
var router = express.Router();
var ipfsAPI = require("ipfs-api");
const fs = require("fs");
var { MyContract ,web3, coinbase } = require("../myContract");
// const ipfsAPI = require("ipfs-api");

/* GET home page. */
router.get("/", function(req, res, next) {
  res.render("certificate", { title: "Express" });
});

router.post("/setCertificate", function(req, res, next) {
  console.log(req.body.phone);
  var phoneNo = req.body.phone;
  var certificateBytes = req.files.certificate;
  console.log("Phone NO :", phoneNo);
  console.log("certificateBytes :", certificateBytes);

  const ipfs = ipfsAPI("ipfs.infura.io", "5001", { protocol: "https" });



  ipfs.files.add(certificateBytes, function(err, file) {
    if (err) throw err;
    var ipfsHash = file[0].hash;
    console.log("ipfsHash :", ipfsHash);

    MyContract.methods
      .setCertificate(phoneNo, ipfsHash)
      .send({ from: coinbase, gas: 6000000 })
      .then(result => {
        console.log("certificate added");
        console.log(result);
        //res.send("Certificate Added !");
        res.redirect("/");
      });
  });

  router.get("/getCertificate", function(req, res, next) {
    var data = req.query;
    console.log(data);
    var result = [];
    MyContract.methods
      .certcount(data.phone)
      .call()
      .then(async count => {
        for (var i = 0; i <= count; i++) {
          //await new Promise(next => {
          //console.log("ivide ethi");
          await MyContract.methods
            .addcerti(data.phone, i)
            .call()
            .then(res => {
              console.log(res);
              console.log(count);
              result.push(res);
            });
          //});
        }
        console.log(result);
        res.render("certificate_view", { result, count });
      });
  });


});
module.exports = router;
