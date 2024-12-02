var express = require('express');
var router = express.Router();
var UserModel = require('../models').User;
const AuthorizationUtils = require('../utils/authentication/authorization');

/**
 * Retourne les informations sur le profil utilisateur connecté
 */
router.get('/profile',AuthorizationUtils.authenticate, (req,res,next) => {

    UserModel.findOne({where: {id: req.user.userId}
    }).then(user => {
        res.json(user);
    }).catch(error => {
        res.json({success: false, error: "Une erreur est survenue lors de la récupération de l'utilisateur : " + error.message});
    })
});

router.post('/profile',AuthorizationUtils.authenticate, (req,res,next) => {
    let tempId = 1;
    let dataToUpdate = {
        firstName: req.body.firstName,
        lastName: req.body.lastName,
        gender: req.body.gender
    };

    UserModel.update(dataToUpdate,{where: {id: tempId}
    }).then(rowsUpdated => {
        res.json({success: true, rowsUpdated});
    }).catch(error => {
        res.json({success: false, error: "Une erreur est survenue lors de la mise à jour de l'utilisateur : " + error.message});
    });
});

module.exports = router;