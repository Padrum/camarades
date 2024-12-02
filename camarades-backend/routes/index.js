var express = require('express');
var router = express.Router();

/* GET home page. */
router.get('/', function(req, res, next) {
  let response = {
    message: "Bienvenue sur l'API de Camarades !",
    success: true
  };

  res.json(response);
});


module.exports = router;
