const {
  DataTypes
} = require('sequelize');

module.exports = sequelize => {
  const attributes = {
    id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: null,
      primaryKey: true,
      autoIncrement: true,
      comment: null,
      field: "id"
    },
    cityName: {
      type: DataTypes.STRING(255),
      allowNull: false,
      defaultValue: '',
      primaryKey: false,
      autoIncrement: false,
      comment: null,
      field: "cityName"
    },

  };
  const options = {
    tableName: "city",
    comment: "",
    indexes: []
  };
  const CityModel = sequelize.define("city_model", attributes, options);
  return CityModel;
};