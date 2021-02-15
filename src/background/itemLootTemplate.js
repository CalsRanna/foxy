import { ipcMain } from "electron";

import {
  SEARCH_ITEM_LOOT_TEMPLATES,
  STORE_ITEM_LOOT_TEMPLATE,
  FIND_ITEM_LOOT_TEMPLATE,
  UPDATE_ITEM_LOOT_TEMPLATE,
  DESTROY_ITEM_LOOT_TEMPLATE,
  COPY_ITEM_LOOT_TEMPLATE,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_ITEM_LOOT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select(["ilt.*", "it.name", "itl.Name as localeName"])
    .from("item_loot_template as ilt")
    .leftJoin("item_template as it", "ilt.Item", "it.entry")
    .leftJoin("item_template_locale as itl", function() {
      this.on("it.entry", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex().raw("?", "zhCN")
      );
    })
    .where("ilt.Entry", payload.Entry);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_ITEM_LOOT_TEMPLATES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_ITEM_LOOT_TEMPLATES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_ITEM_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("item_loot_template");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_ITEM_LOOT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_ITEM_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_ITEM_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("item_loot_template")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_ITEM_LOOT_TEMPLATE, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_ITEM_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_ITEM_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("item_loot_template")
    .where(payload.credential)
    .update(payload.itemLootTemplate);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_ITEM_LOOT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_ITEM_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_ITEM_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("item_loot_template")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_ITEM_LOOT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_ITEM_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_ITEM_LOOT_TEMPLATE, (event, payload) => {
  let item = undefined;
  let itemLootTemplate = undefined;

  let itemQueryBuilder = knex()
    .select("Item")
    .from("item_loot_template")
    .where("Entry", payload.Entry)
    .orderBy("Item", "desc");
  let findItemLootTempalteQueryBuilder = knex()
    .select()
    .from("item_loot_template")
    .where(payload);
  Promise.all([
    itemQueryBuilder.then((rows) => {
      item = rows.length > 0 ? rows[0].Item : 0;
    }),
    findItemLootTempalteQueryBuilder.then((rows) => {
      itemLootTemplate = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      itemLootTemplate.Item = item + 1;
      if (itemLootTemplate.Reference != 0) {
        itemLootTemplate.Reference = item + 1;
      }
      let queryBuilder = knex()
        .insert(itemLootTemplate)
        .into("item_loot_template");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_ITEM_LOOT_TEMPLATE, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_ITEM_LOOT_TEMPLATE}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_ITEM_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});
