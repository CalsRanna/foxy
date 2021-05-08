import Knex from "knex";

var init = function (config) {
  window.knex = Knex({
    client: "mysql",
    connection: config,
  });
};

export { init };
