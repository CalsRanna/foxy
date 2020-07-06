const Sequelize = require("sequelize");

const sequelize = new Sequelize(
  // "mysql://root:MaoRan1991@127.0.0.1:3306/acore_world"
  "mysql://root:password@10.0.0.13:3306/acore_world"
);

export {
  sequelize,
};
