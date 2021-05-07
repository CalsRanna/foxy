import { knex } from "./config";

var search = function (payload) {
  console.log(`search in repository`);
  console.log(knex);
  return Promise((resolve, reject) => {
    let queryBuilder = knex.select().from("foxy.dbc_item").where(payload);

    queryBuilder.then((rows) => {
      resolve(rows);
    });
  });
};

export default {
  search,
};
