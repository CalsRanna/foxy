var knex = null;

var init = function (config) {
  knex = require("knex")({
    client: "mysql",
    connection: config,
  });
};

export { knex, init };
