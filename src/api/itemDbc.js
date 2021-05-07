import { knex } from "@/repository/config";

export default {
  search(payload) {
    return Promise((resolve, reject) => {
      let queryBuilder = knex.select().from("foxy.dbc_item").where(payload);

      queryBuilder.then((rows) => {
        resolve(rows);
      });
    });
  },
};
