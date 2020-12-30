let knex;

exports.init = config => {
  knex = require("knex")({
    client: "mysql",
    connection: config
  });
};

exports.knex = () => knex;
