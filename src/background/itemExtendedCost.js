import { ipcMain } from "electron";

import {
  SEARCH_ITEM_EXTENDED_COSTS,
  COUNT_ITEM_EXTENDED_COSTS,
  STORE_ITEM_EXTENDED_COST,
  FIND_ITEM_EXTENDED_COST,
  UPDATE_ITEM_EXTENDED_COST,
  DESTROY_ITEM_EXTENDED_COST,
  CREATE_ITEM_EXTENDED_COST,
  COPY_ITEM_EXTENDED_COST,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_ITEM_EXTENDED_COSTS, (event, payload) => {
  let queryBuilder = knex
    .select([
      "fdiec.ID",
      "fdiec.HonorPoints",
      "fdiec.ArenaPoints",
      "it_1.name as name_1",
      "itl_1.Name as localeName_1",
      "fdiec.ItemCount_1",
      "it_2.name as name_2",
      "itl_2.Name as localeName_2",
      "fdiec.ItemCount_2",
      "it_3.name as name_3",
      "itl_3.Name as localeName_3",
      "fdiec.ItemCount_3",
      "it_4.name as name_4",
      "itl_4.Name as localeName_4",
      "fdiec.ItemCount_4",
      "it_5.name as name_5",
      "itl_5.Name as localeName_5",
      "fdiec.ItemCount_5",
    ])
    .from("foxy.dbc_item_extended_cost as fdiec")
    .leftJoin("item_template as it_1", "it_1.entry", "fdiec.ItemID_1")
    .leftJoin("item_template_locale as itl_1", function () {
      this.on("fdiec.ItemID_1", "=", "itl_1.ID").andOn(
        "itl_1.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    })
    .leftJoin("item_template as it_2", "it_2.entry", "fdiec.ItemID_2")
    .leftJoin("item_template_locale as itl_2", function () {
      this.on("fdiec.ItemID_2", "=", "itl_2.ID").andOn(
        "itl_2.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    })
    .leftJoin("item_template as it_3", "it_3.entry", "fdiec.ItemID_3")
    .leftJoin("item_template_locale as itl_3", function () {
      this.on("fdiec.ItemID_3", "=", "itl_3.ID").andOn(
        "itl_3.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    })
    .leftJoin("item_template as it_4", "it_4.entry", "fdiec.ItemID_4")
    .leftJoin("item_template_locale as itl_4", function () {
      this.on("fdiec.ItemID_4", "=", "itl_4.ID").andOn(
        "itl_4.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    })
    .leftJoin("item_template as it_5", "it_5.entry", "fdiec.ItemID_5")
    .leftJoin("item_template_locale as itl_5", function () {
      this.on("fdiec.ItemID_5", "=", "itl_5.ID").andOn(
        "itl_5.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    });
  if (payload.ID) {
    queryBuilder = queryBuilder.where("fdiec.ID", payload.ID);
  }
  if (payload.Name) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("it_1.name", "like", `%${payload.Name}%`)
        .orWhere("itl_1.Name", "like", `%${payload.Name}%`)
        .orWhere("it_2.name", "like", `%${payload.Name}%`)
        .orWhere("itl_2.Name", "like", `%${payload.Name}%`)
        .orWhere("it_3.name", "like", `%${payload.Name}%`)
        .orWhere("itl_3.Name", "like", `%${payload.Name}%`)
        .orWhere("it_4.name", "like", `%${payload.Name}%`)
        .orWhere("itl_4.Name", "like", `%${payload.Name}%`)
        .orWhere("it_5.name", "like", `%${payload.Name}%`)
        .orWhere("itl_5.Name", "like", `%${payload.Name}%`)
    );
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_ITEM_EXTENDED_COSTS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_ITEM_EXTENDED_COSTS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_ITEM_EXTENDED_COSTS, (event, payload) => {
  let queryBuilder = knex.count("* as total")
    .from("foxy.dbc_item_extended_cost as fdiec")
    .leftJoin("item_template as it_1", "it_1.entry", "fdiec.ItemID_1")
    .leftJoin("item_template_locale as itl_1", function () {
      this.on("fdiec.ItemID_1", "=", "itl_1.ID").andOn(
        "itl_1.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    })
    .leftJoin("item_template as it_2", "it_2.entry", "fdiec.ItemID_2")
    .leftJoin("item_template_locale as itl_2", function () {
      this.on("fdiec.ItemID_2", "=", "itl_2.ID").andOn(
        "itl_2.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    })
    .leftJoin("item_template as it_3", "it_3.entry", "fdiec.ItemID_3")
    .leftJoin("item_template_locale as itl_3", function () {
      this.on("fdiec.ItemID_3", "=", "itl_3.ID").andOn(
        "itl_3.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    })
    .leftJoin("item_template as it_4", "it_4.entry", "fdiec.ItemID_4")
    .leftJoin("item_template_locale as itl_4", function () {
      this.on("fdiec.ItemID_4", "=", "itl_4.ID").andOn(
        "itl_4.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    })
    .leftJoin("item_template as it_5", "it_5.entry", "fdiec.ItemID_5")
    .leftJoin("item_template_locale as itl_5", function () {
      this.on("fdiec.ItemID_5", "=", "itl_5.ID").andOn(
        "itl_5.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    });
  if (payload.ID) {
    queryBuilder = queryBuilder.where("fdiec.ID", payload.ID);
  }
  if (payload.Name) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("it_1.name", "like", `%${payload.Name}%`)
        .orWhere("itl_1.Name", "like", `%${payload.Name}%`)
        .orWhere("it_2.name", "like", `%${payload.Name}%`)
        .orWhere("itl_2.Name", "like", `%${payload.Name}%`)
        .orWhere("it_3.name", "like", `%${payload.Name}%`)
        .orWhere("itl_3.Name", "like", `%${payload.Name}%`)
        .orWhere("it_4.name", "like", `%${payload.Name}%`)
        .orWhere("itl_4.Name", "like", `%${payload.Name}%`)
        .orWhere("it_5.name", "like", `%${payload.Name}%`)
        .orWhere("itl_5.Name", "like", `%${payload.Name}%`)
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_ITEM_EXTENDED_COSTS, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_ITEM_EXTENDED_COSTS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_ITEM_EXTENDED_COST, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("foxy.dbc_item_extended_cost");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_ITEM_EXTENDED_COST, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_ITEM_EXTENDED_COST}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_ITEM_EXTENDED_COST, (event, payload) => {
  let queryBuilder = knex.select().from("foxy.dbc_item_extended_cost").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_ITEM_EXTENDED_COST, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_ITEM_EXTENDED_COST}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_ITEM_EXTENDED_COST, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_item_extended_cost")
    .where(payload.credential)
    .update(payload.itemExtendedCost);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_ITEM_EXTENDED_COST, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_ITEM_EXTENDED_COST}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_ITEM_EXTENDED_COST, (event, payload) => {
  let queryBuilder = knex.table("foxy.dbc_item_extended_cost").where(payload).delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_ITEM_EXTENDED_COST, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_ITEM_EXTENDED_COST}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_ITEM_EXTENDED_COST, (event, payload) => {
  let queryBuilder = knex
    .select("ID")
    .from("foxy.dbc_item_extended_cost")
    .orderBy("ID", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_ITEM_EXTENDED_COST, {
        ID: rows[0].ID + 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_ITEM_EXTENDED_COST}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_ITEM_EXTENDED_COST, (event, payload) => {
  let ID = undefined;
  let itemExtendedCost = undefined;

  let IDQueryBuilder = knex
    .select("ID")
    .from("foxy.dbc_item_extended_cost")
    .orderBy("ID", "desc");
  let findItemExtendedCostQueryBuilder = knex
    .select()
    .from("foxy.dbc_item_extended_cost")
    .where(payload);
  Promise.all([
    IDQueryBuilder.then((rows) => {
      ID = rows[0].ID;
    }),
    findItemExtendedCostQueryBuilder.then((rows) => {
      itemExtendedCost = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      itemExtendedCost.ID = ID + 1;
      let queryBuilder = knex.insert(itemExtendedCost).into("foxy.dbc_item_extended_cost");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_ITEM_EXTENDED_COST, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_ITEM_EXTENDED_COST}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_ITEM_EXTENDED_COST}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
