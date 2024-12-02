'use strict';
module.exports = {
  up: (queryInterface, Sequelize) => {
    return queryInterface.createTable('Experiences', {
      id: {
        allowNull: false,
        autoIncrement: true,
        primaryKey: true,
        type: Sequelize.INTEGER
      },
      type:{
        type: Sequelize.ENUM,
        values: ['formation', 'experience_professionnelle']
      },
      title: {
        type: Sequelize.STRING
      },
      description: {
        type: Sequelize.STRING
      },
      startDate: {
        type: Sequelize.DATE
      },
      endDate: {
        type: Sequelize.DATE
      },
      establishmentName: {
        type: Sequelize.STRING
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE
      },
      userId: {
        type:Sequelize.INTEGER,
        references:{
          model:{
            tableName:'Users'
          },
          key:'id'
        }
      },
      companyId: {
        type: Sequelize.INTEGER,
        references: {
          model: {
            tableName: 'Companies'
          },
          key: 'id'
        }
      },

    });
  },
  down: (queryInterface, Sequelize) => {
    return queryInterface.dropTable('Experiences');
  }
};