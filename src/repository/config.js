import Knex from "knex";

var instance = null;

exports.init = (config) => {
  instance = Knex({
    client: "mysql",
    connection: config,
  });
};

exports.knex = instance;
