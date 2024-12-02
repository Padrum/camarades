const UserModel = require('../../models').User;

module.exports = {
    /**
     * Vérification que l'email donné
     * en paramètre soit une adresse mail valide
     * @param email
     * @returns {Promise<string>}
     */
    isEmailValid: function(email){
        return new Promise((resolve, reject) => {
            //Vérification email par regex
            var regex = /^(([^<>()\[\]\.,;:\s@\"]+(\.[^<>()\[\]\.,;:\s@\"]+)*)|(\".+\"))@(([^<>()[\]\.,;:\s@\"]+\.)+[^<>()[\]\.,;:\s@\"]{2,})$/i;
            let mailValid = regex.test(String(email).toLowerCase());

            if(!mailValid){
                reject({message:`Adresse email ${email} invalide`});
            }

            resolve(email);
        });
    },

    /**
     * Vérification que l'adresse email donné en paramètre
     * ne soit pas déjà utilisé
     * @param email
     * @returns {Promise<string>}
     */
    isEmailAvailable: function(email){
        return new Promise((resolve, reject) => {
            UserModel.count({where: {email: email}})
                .then(count => {
                    if (count !== 0) {
                        reject({message :`L'adresse email ${email} est déjà prise`});
                    }
                    resolve(email);
                });
        });
    },

    /**
     * Vérifie si l'email existe
     * @param email
     * @returns {Promise<object>}
     */
    emailExist: function(email){
        return new Promise((resolve, reject) => {
            UserModel.count({where: {email: email}})
                .then(count => {
                    if (count !== 0) {
                        resolve(email);
                    }
                    reject({message :`L'adresse email ${email} n'existe pas`});
                });
        });
    }
};