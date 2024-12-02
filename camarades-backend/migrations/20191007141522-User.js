'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.sequelize.transaction((t) => {
      return Promise.all([
        queryInterface.addColumn('Users', 'gender', {
          type: Sequelize.ENUM,
          values: ['homme', 'femme', 'autre']
        }, { transaction: t }),
        queryInterface.addColumn('Users', 'status', {
          type: Sequelize.ENUM,
          values: ['etudiant', 'professeur', 'professionnel', 'non_actif']
        }, { transaction: t })
      ])
    })
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.sequelize.transaction((t) => {
      return Promise.all([
        queryInterface.removeColumn('Users', 'gender', { transaction: t }),
        queryInterface.removeColumn('Users', 'status', { transaction: t })
      ])
    })
  }
};
