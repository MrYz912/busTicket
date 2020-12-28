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
    name: {
      type: DataTypes.STRING(255),
      allowNull: false,
      defaultValue: null,
      primaryKey: false,
      autoIncrement: false,
      comment: null,
      field: "name"
    },
    age: {
      type: DataTypes.INTEGER,
      allowNull: true,
      defaultValue: null,
      primaryKey: false,
      autoIncrement: false,
      comment: null,
      field: "age"
    },
    sex: {
      type: DataTypes.STRING(255),
      allowNull: true,
      defaultValue: null,
      primaryKey: false,
      autoIncrement: false,
      comment: null,
      field: "sex"
    },
    founder: {
      type: DataTypes.STRING(255),
      allowNull: true,
      defaultValue: null,
      primaryKey: false,
      autoIncrement: false,
      comment: "创建者",
      field: "founder"
    },
    modifier: {
      type: DataTypes.STRING(255),
      allowNull: true,
      defaultValue: null,
      primaryKey: false,
      autoIncrement: false,
      comment: "修改者",
      field: "modifier"
    },
    create_time: {
      type: DataTypes.DATE,
      allowNull: true,
      defaultValue: "CURRENT_TIMESTAMP(6)",
      primaryKey: false,
      autoIncrement: false,
      comment: null,
      field: "create_time"
    },
    update_time: {
      type: DataTypes.DATE,
      allowNull: true,
      defaultValue: "CURRENT_TIMESTAMP(6)",
      primaryKey: false,
      autoIncrement: false,
      comment: null,
      field: "update_time"
    }
  };
  const options = {
    tableName: "driver",
    comment: "",
    indexes: []
  };
  const DriverModel = sequelize.define("driver_model", attributes, options);
  return DriverModel;
};