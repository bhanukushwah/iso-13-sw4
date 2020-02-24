var express = require('express');
var router = express.Router();
var nodemailer = require('nodemailer');
var { MyContract,web3,coinbase } = require("../myContract");

/* GET home page. */
router.get('/', function(req, res, next) {
    res.render('hospital', { title: 'Express' });
  });

router.post('/setHospital', function (req, res, next) {
    var data = req.body;
    console.log(data);
    var publickey = web3.eth.personal.newAccount('').then((key)=>{
    MyContract.methods.setHospital(data.id, key, data.name, data.email, data.phone, data.ownership,data.haddress)
        .send({ from: coinbase, gas : 6000000 });
    res.send("Hospital Registered !")
  }).catch((err)=>{
console.log(err);
  });

    //sending login details to doctors email
    var transporter = nodemailer.createTransport({
        service: 'gmail',
        auth: {
          user: 'youremail',
          pass: 'password'
        }
      });
      
      var mailOptions = {
        from: 'youremail',
        to: data.email,
        subject: 'Hospital Registration Details',
        text:  'Your hospital has been registered in our network. Our developer will be reaching you with in 7 working days for the further installation process of the software in your hospital.' +
        
        'Your public key is : ' +publickey
      };
      
      transporter.sendMail(mailOptions, function(error, info){
        if (error) {
          console.log(error);
        } else {
          console.log('Email sent: ' + info.response);
        }
      });

});

router.get('/getHospital', function (req, res, next) {
    var data = req.query;
    console.log(data);
    MyContract.methods.getHospital(data.id)
        .call({ from: coinbase }).then((val) => {
            console.log(val);
            // require(![data]);
            res.render("hospital_profile", {myData : val});
        })
});

module.exports = router;


