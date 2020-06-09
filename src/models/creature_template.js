const Sequelize = require("sequelize");

const sequelize = new Sequelize("acore_world", "root", "password", {
  host: "10.0.0.13:3306",
  dialect: "mysql",
});

sequelize
  .authenticate()
  .then(() => {
    console.log('Connection has been established successfully.');
  })
  .catch(err => {
    console.error('Unable to connect to the database:', err);
  });

var CreatureTemplate = sequelize.define('creature_template', {
    entry: {type: Sequelize.INTEGER, allowNull: false, primaryKey: true, unique: true},
    name: {type: Sequelize.STRING},
    subname: {type: Sequelize.STRING},
    timestamps: false
});

module.exports = {
    CreatureTemplate
};
