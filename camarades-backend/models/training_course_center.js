'use strict';
module.exports = (sequelize, DataTypes) => {
  const TrainingCourseCenter = sequelize.define('TrainingCourseCenter', {
    name: DataTypes.STRING,
    address: DataTypes.STRING,
    zipCode: DataTypes.STRING,
    city: DataTypes.STRING,
    website: DataTypes.STRING,
    phone: DataTypes.STRING
  }, {
    tableName: 'training_course_centers'
  });
  TrainingCourseCenter.associate = function(models) {
  };
  return TrainingCourseCenter;
};