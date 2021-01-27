let knex;

let foxyKnex;

exports.init = (config) => {
  knex = require("knex")({
    client: "mysql",
    connection: config,
  });
};

exports.initFoxy = (config) => {
  foxyKnex = require("knex")({
    client: "mysql",
    connection: {
      host: config.host,
      user: config.user,
      password: config.password,
      database: "foxy",
    },
  });
};

exports.knex = () => knex;

exports.foxyKnex = () => foxyKnex;
