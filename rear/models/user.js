const bcryptjs = require('bcryptjs');
const {
  DataTypes
} = require('sequelize');

module.exports = sequelize => {
  const attributes = {
    userId: {
      type: DataTypes.INTEGER,
      allowNull: false,
      defaultValue: null,
      primaryKey: true,
      autoIncrement: true,
      comment: null,
      field: "userId"
    },
    nickname: {
      type: DataTypes.STRING(255),
      allowNull: false,
      defaultValue: '',
      primaryKey: false,
      autoIncrement: false,
      comment: null,
      field: "nickname"
    },
    password: {
      type: DataTypes.STRING(255),
      allowNull: false,
      defaultValue: '',
      primaryKey: false,
      autoIncrement: false,
      comment: null,
      field: "password",
      set(val) {
        const salt = bcryptjs.genSaltSync(10);
        const psw = bcryptjs.hashSync(val, salt);
        this.setDataValue('password', psw);
      }
    },
    root: {
      type: DataTypes.INTEGER,
      allowNull: true,
      defaultValue: null,
      primaryKey: false,
      autoIncrement: false,
      comment: "是否为管理员，1为管理员，0为普通用户",
      field: "root"
    },
    created_at: {
      type: DataTypes.DATE,
      allowNull: true,
      defaultValue: "CURRENT_TIMESTAMP(6)",
      primaryKey: false,
      autoIncrement: false,
      comment: null,
      field: "created_at"
    },
    updated_at: {
      type: DataTypes.DATE,
      allowNull: true,
      defaultValue: "CURRENT_TIMESTAMP(6)",
      primaryKey: false,
      autoIncrement: false,
      comment: null,
      field: "updated_at"
    }
  };
  const options = {
    tableName: "user",
    comment: "",
    indexes: []
  };
  const UserModel = sequelize.define("user_model", attributes, options);
  return UserModel;
};