'use strict';
module.exports = (sequelize, DataTypes) => {
  const Experience = sequelize.define('Experience', {
    name: DataTypes.STRING,
    type: {
      type: DataTypes.ENUM,
      values: ['formation', 'experience_professionnelle']
    },
    title: DataTypes.STRING,
    description: DataTypes.STRING,
    trainingCourseCenterName: DataTypes.STRING,
    companyName: DataTypes.STRING,
    startDate: DataTypes.DATE,
    endDate: DataTypes.DATE
  }, {} );
  Experience.associate = function(models) {
    Experience.belongsTo(models.User);
    Experience.belongsTo(models.Company);
    Experience.belongsTo(models.TrainingCourseCenter);
  };
  return Experience;
};