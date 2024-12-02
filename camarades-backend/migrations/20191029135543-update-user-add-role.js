'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.sequelize.transaction((transaction) => {
      return Promise.all([
        queryInterface.addColumn('Users', 'role', {
          type: Sequelize.ENUM,
          values: ['admin', 'utilisateur', 'ecole'],
          defaultValue: 'utilisateur'
        }, {transaction})
      ])
    })
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.sequelize.transaction((transaction) => {
      return Promise.all([
        queryInterface.removeColumn('Users', 'role',{ transaction})
      ])
    });
  }
};
