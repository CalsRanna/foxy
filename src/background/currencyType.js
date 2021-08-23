import { ipcMain } from "electron";

import {
  SEARCH_CURRENCY_TYPES,
  COUNT_CURRENCY_TYPES,
  STORE_CURRENCY_TYPE,
  FIND_CURRENCY_TYPE,
  UPDATE_CURRENCY_TYPE,
  DESTROY_CURRENCY_TYPE,
  CREATE_CURRENCY_TYPE,
  COPY_CURRENCY_TYPE,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_CURRENCY_TYPES, (event, payload) => {
  let queryBuilder = knex
    .select([
      "fdct.ID",
      "it.name",
      "itl.Name as localeName",
      "it.Quality",
      "didi.InventoryIcon_1",
      "fdcc.Name_Lang_zhCN as Category",
    ])
    .from("foxy.dbc_currency_types as fdct")
    .leftJoin('item_template as it', "fdct.ItemID", 'it.entry')
    .leftJoin("item_template_locale as itl", function () {
      this.on("fdct.ItemID", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    })
    .leftJoin("foxy.dbc_item_display_info as didi", "it.displayid", "didi.ID")
    .leftJoin("foxy.dbc_currency_category as fdcc", "fdct.CategoryID", "fdcc.ID");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("fdct.ID", payload.ID);
  }
  if (payload.Name) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("it.name", "like", `%${payload.Name}%`)
        .orWhere("itl.Name", "like", `%${payload.Name}%`)
    );
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_CURRENCY_TYPES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_CURRENCY_TYPES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_CURRENCY_TYPES, (event, payload) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_currency_types as fdct")
    .leftJoin('item_template as it', "fdct.ItemID", 'it.entry')
    .leftJoin("item_template_locale as itl", function () {
      this.on("fdct.ItemID", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    })
    .leftJoin("foxy.dbc_item_display_info as didi", "it.displayid", "didi.ID");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("fdct.ID", payload.ID);
  }
  if (payload.Name) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("it.name", "like", `%${payload.Name}%`)
        .orWhere("itl.Name", "like", `%${payload.Name}%`)
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_CURRENCY_TYPES, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_CURRENCY_TYPES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_CURRENCY_TYPE, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("foxy.dbc_currency_types");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_CURRENCY_TYPE, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_CURRENCY_TYPE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_CURRENCY_TYPE, (event, payload) => {
  let queryBuilder = knex.select().from("foxy.dbc_currency_types").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_CURRENCY_TYPE, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_CURRENCY_TYPE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_CURRENCY_TYPE, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_currency_types")
    .where(payload.credential)
    .update(payload.currencyType);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_CURRENCY_TYPE, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_CURRENCY_TYPE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_CURRENCY_TYPE, (event, payload) => {
  let queryBuilder = knex.table("foxy.dbc_currency_types").where(payload).delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_CURRENCY_TYPE, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_CURRENCY_TYPE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_CURRENCY_TYPE, (event, payload) => {
  let queryBuilder = knex
    .select("ID")
    .from("foxy.dbc_currency_types")
    .orderBy("ID", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_CURRENCY_TYPE, {
        ID: rows[0].ID + 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_CURRENCY_TYPE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_CURRENCY_TYPE, (event, payload) => {
  let ID = undefined;
  let currency_type = undefined;

  let IDQueryBuilder = knex
    .select("ID")
    .from("foxy.dbc_currency_types")
    .orderBy("ID", "desc");
  let findCurrencyTypeQueryBuilder = knex
    .select()
    .from("foxy.dbc_currency_types")
    .where(payload);
  Promise.all([
    IDQueryBuilder.then((rows) => {
      ID = rows[0].ID;
    }),
    findCurrencyTypeQueryBuilder.then((rows) => {
      currency_type = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      currency_type.ID = ID + 1;
      let queryBuilder = knex.insert(currency_type).into("foxy.dbc_currency_types");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_CURRENCY_TYPE, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_CURRENCY_TYPE}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_CURRENCY_TYPE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
