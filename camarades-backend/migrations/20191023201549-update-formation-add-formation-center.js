'use strict';

module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.sequelize.transaction((transaction) => {
      return Promise.all([
        queryInterface.addColumn('Experiences', 'trainingCourseCenterId', {
          type: Sequelize.INTEGER,
          references:{
            model:{
              tableName: 'Training_Course_Centers',
            },
            key: 'id'
          }
        }, {transaction})
      ])
    })
  },

  down: (queryInterface, Sequelize) => {
    return queryInterface.sequelize.transaction((transaction) => {
      return Promise.all([
        queryInterface.removeColumn('Experiences', 'trainingCourseCenterId',{ transaction})
      ])
    })
  }
};
