const express = require('express');
const router = express.Router();
const UserModel = require('../models').User;
const EmailUtils = require('../utils/authentication/email');
const PasswordUtils = require('../utils/authentication/password');
const BaseUtils = require('../utils/base');
const AuthorizationUtils = require('../utils/authentication/authorization');
const Roles = require('../utils/authentication/roles');

/**
 * Route d'inscription à l'application Camarades
 * L'email et le mot de passe sont obligatoires
 */
router.put('/register', (req,res,next) => {
    let mandatoryFields = ['email', 'password'];

     /*
        J'ai utilisé les promesses pour gérer de façon propre les fonctions de vérification
        et surtout pour éviter des promises en cascade à tout va qui aurait été difficile à relire
        Je me suis basé sur ça : https://stackoverflow.com/questions/39659829/how-can-i-chain-these-functions-together-with-promises/39660257#39660257
     */
    BaseUtils.areMandatoryFieldsPresent(mandatoryFields, req.body)
        .then(arePresent => EmailUtils.isEmailValid(req.body.email))
        .then(email => EmailUtils.isEmailAvailable(email))
        .then(email => PasswordUtils.isPasswordValid(req.body.password))
        .then(password => PasswordUtils.hashPassword(password))
        .then(passwordHashed => {
            BaseUtils.convertBirthDate(req.body.birth_date)
                .then(birthDate => {
                    let firstName = typeof req.body.first_name === "string" ? req.body.first_name : "";
                    let lastName =  typeof req.body.last_name === "string" ? req.body.last_name : "";
                    UserModel.create({email: req.body.email, password: passwordHashed, firstName: firstName, lastName: lastName, birthDate: birthDate})
                        .then(user => {
                            res.json({success: true, 'message': `Utilisateur ${user.email} créée avec succès`});
                        }).catch(error=>{
                        res.json({success: false, 'error': `L'utilisateur n'a pas pu être créée. Raison : ${error.message}`});
                    });
            }).catch((error) => {
                res.json({success: false, error: error.message});
            });
        })
        .catch((error) => {
            res.json({success: false, error: error.message});
        });
});

/**
 * Authentification
 * Renvoi un Token JWT
 */
router.post('/login', (req,res,next) => {
    let mandatoryFields = ['email', 'password'];
    BaseUtils.areMandatoryFieldsPresent(mandatoryFields, req.body)
        .then(arePresent => EmailUtils.isEmailValid(req.body.email))
        .then(email => EmailUtils.emailExist(req.body.email))
        .then(password => PasswordUtils.comparedPassword(req.body.password, req.body.email))
        .then(tokenGenerate => {
            res.json({
                success: true,
                'message': `Utilisateur ${req.body.email} connecté`,
                token: {
                    token: tokenGenerate.token,
                    maxAge: 3600000, //1 semaine
                    domain: 'localhost:3000'
                }
            });
        }).catch(error => {
        res.json({
            success: false,
            'message': `L'utilisateur ${req.body.email} n'a pas pu se connecter. Raison : ${error.message}`
        });
    });
});

/**
 * Déconnecte du serveur
 */
router.get('/logout', AuthorizationUtils.authenticate, (req,res,next) => {
    res.json({success: true, message: "Coming soon !"});
});

router.post('/email', AuthorizationUtils.authenticate, (req,res, next) => {


    let tempId = 1;
    let dataToUpdate = {
        email: req.body.email
    };

    UserModel.findOne({where: {id: tempId}})
        .then(user => {
            EmailUtils.isEmailValid(dataToUpdate.email)
                .then(email => EmailUtils.isEmailAvailable(email))
                .then(() => {
                    bcrypt.compare(req.body.actualPassword, user.password).then((valid) => {
                        if(valid){
                            UserModel.update(dataToUpdate, {where: {id: tempId}})
                                .then(rowsUpdated => {
                                    res.json({success: true, rowsUpdated});
                                });
                        }
                        else{
                            throw new Error('Mot de passe erroné');
                        }
                    }).catch(err => {
                        res.json({success: false, error: "Le mot de passe actuel est incorrect"});
                    });
                }).catch( err => {
                    res.json({success: false, error: err.message});
                });
    }).catch(error => {
        res.json({success: false, error: error.message});
    });
});

router.post('/change-password',AuthorizationUtils.authenticate, (req,res, next) => {
    let tempId = 1;

    UserModel.findOne({where: {id: tempId}
    }).then(user => {
        bcrypt.compare(req.body.oldPassword, user.password).then((valid) => {
            if(valid){
                PasswordUtils.isPasswordValid(req.body.newPassword)
                    .then(password => PasswordUtils.hashPassword(req.body.newPassword))
                    .then(hash => {
                        UserModel.update({password: hash}, {where: {id: tempId}})
                            .then(rowsUpdated => {
                                res.json({success: true, rowsUpdated});
                            });
                }).catch(err => {
                    throw new Error('Mot de passe erroné');
                });
            }
            else{
                throw new Error('Mot de passe erroné');
            }

        }).catch(err => {
            res.json({success: false, error: "Le mot de passe actuel est incorrect"});
        });

    }).catch(error => {
        res.json({success: false, error: "Une erreur est survenue lors de la mise à jour de l'utilisateur : " + error.message});
    });
});

module.exports = router;