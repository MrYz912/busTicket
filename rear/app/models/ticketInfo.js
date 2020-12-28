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
    day: {
      type: DataTypes.DATEONLY,
      allowNull: true,
      defaultValue: null,
      primaryKey: false,
      autoIncrement: false,
      comment: null,
      field: "day"
    },
    time: {
      type: DataTypes.TIME,
      allowNull: false,
      defaultValue: null,
      primaryKey: false,
      autoIncrement: false,
      comment: null,
      field: "time"
    },
    startStation: {
      type: DataTypes.STRING(255),
      allowNull: false,
      defaultValue: null,
      primaryKey: false,
      autoIncrement: false,
      comment: null,
      field: "startStation"
    },
    endStation: {
      type: DataTypes.STRING(255),
      allowNull: false,
      defaultValue: null,
      primaryKey: false,
      autoIncrement: false,
      comment: null,
      field: "endStation"
    },
    userId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: null,
      primaryKey: false,
      autoIncrement: false,
      comment: null,
      field: "userId"
    },
    money: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: null,
      primaryKey: false,
      autoIncrement: false,
      comment: "价格",
      field: "money"
    },
    license_plate: {
      type: DataTypes.STRING(255),
      allowNull: true,
      defaultValue: null,
      primaryKey: false,
      autoIncrement: false,
      comment: "车牌",
      field: "license_plate"
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
    tableName: "ticketInfo",
    comment: "",
    indexes: []
  };
  const TicketInfoModel = sequelize.define("ticketInfo_model", attributes, options);
  return TicketInfoModel;
};