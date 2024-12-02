const moment = require('moment');

module.exports = {
    /**
     * Vérification que les champs donnés en paramètre
     * aient bien été renseigné dans le corps de la requête
     * @param mandatoryFields
     * @param requestBody
     * @returns {Promise<boolean>}
     */
    areMandatoryFieldsPresent: function (mandatoryFields, requestBody){
        return new Promise((resolve, reject) => {
            let length = mandatoryFields.length;

            for(let i = 0; i < length; i++){
                if(typeof requestBody[mandatoryFields[i]] === 'undefined' || requestBody[mandatoryFields[i]].length === 0){
                    reject({message:`Le champ ${mandatoryFields[i]} est obligatoire et ne peut être vide`});
                }
            }
            resolve(true);
        });

    },

    convertBirthDate: function (birthDate){
        return new Promise((resolve, reject) => {
            let birthDateConverted = null;
            //Conversion date de naissance en object moment
            if(typeof birthDate === "string"){
                birthDateConverted = moment(birthDate, "DD-MM-YYYY");
                if(! birthDateConverted.isValid()){
                    reject({message: `Date de naissance incorrecte (Format: JJ/MM/AAAA)`});
                }
            }
            resolve(birthDateConverted);
        });
    }
};

