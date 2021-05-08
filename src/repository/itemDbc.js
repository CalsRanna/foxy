var search = function (payload) {
  return new Promise((resolve, reject) => {
    let queryBuilder = window.knex.select().from("foxy.dbc_item");
    if (payload) {
      queryBuilder = queryBuilder.where(payload);
    }

    queryBuilder.then((rows) => {
      resolve(rows);
    });
  });
};

export default {
  search,
};
