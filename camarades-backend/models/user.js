'use strict';
module.exports = (sequelize, DataTypes) => {
  const User = sequelize.define('User', {
    firstName: DataTypes.STRING,
    lastName: DataTypes.STRING,
    email: DataTypes.STRING,
    password: DataTypes.STRING,
    birthDate: DataTypes.DATE,
    gender: {
      type: DataTypes.ENUM,
      values: ['homme', 'femme', 'autre']
    },
    status: {
      type: DataTypes.ENUM,
      values: ['etudiant', 'professeur', 'professionnel', 'non_actif']
    },
    role: {
      type: DataTypes.ENUM,
      values: ['admin', 'utilisateur', 'ecole']
    }

  }, {});
  User.associate = function(models) {
  };
  return User;
};