const saltRounds = 10;
const bcrypt = require('bcrypt');
const UserModel = require('../../models').User;
const jwtUtils = require('../jwt.utils');

module.exports = {
    /**
     * Vérification que le mot de passe donné
     * en paramètre soit sécurisé un minimum
     * @param password
     * @returns {Promise<string>}
     */
    isPasswordValid: function(password){
        return new Promise((resolve, reject) => {
            //Vérification que le mot de passe fait au moins 8 caractères
            let passwordLength = password.length;

            if(passwordLength < 8) {
                reject({message: "Mot de passe trop court (Minimum 8 caractères)"});
            }

            //TODO Vérifier présence d'au moins 1 minuscule et 1 majuscule
            //TODO Vérifier présence d'au moins 1 chiffre
            //TODO Vérifier présence d'au moins 1 caractère spécial (Facultatif)

            resolve(password);
        });
    },

    /**
     * Hashage du mot de passe
     * @param password
     * @returns {Promise<string>}
     */
    hashPassword: function(password){
        //Chiffrement mot de passe par bcrypt
        return new Promise((resolve, reject) => {
            bcrypt.hash(password, saltRounds).then((hash, err) => {
                if(typeof err !== "undefined"){
                    reject({message: `Une erreur lors du hashage du mot de passe est survenue : ${err.message}`});
                }
                resolve(hash);
            });
        });
    },

    /**
     * Comparaison du mot de passe renseigné avec le mot de passe hashé en bdd
     * @param password
     * @param email
     * @returns {Promise<string>}
     */
    comparedPassword: function(password, email){
        //Chiffrement mot de passe par bcrypt
        return new Promise((resolve, reject) => {
            UserModel.findOne({where: {email: email}})
                .then(userFound => {
                    bcrypt.compare(password, userFound.password).then((hash, err) => {
                        if(typeof err !== "undefined"){
                            reject({message: `Une erreur lors du hashage du mot de passe est survenue : ${err.message}`});
                        }
                        if(hash){
                            resolve({
                                'token': jwtUtils.generateTokenForUser(userFound)
                            });
                        }
                        else{
                            reject({message: `Mauvais mot de passe`});
                        }
                    });
                })
        });
    }
};