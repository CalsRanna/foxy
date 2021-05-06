import { ipcMain } from "electron";

import {
  SEARCH_DISENCHANT_LOOT_TEMPLATES,
  STORE_DISENCHANT_LOOT_TEMPLATE,
  FIND_DISENCHANT_LOOT_TEMPLATE,
  UPDATE_DISENCHANT_LOOT_TEMPLATE,
  DESTROY_DISENCHANT_LOOT_TEMPLATE,
  COPY_DISENCHANT_LOOT_TEMPLATE,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_DISENCHANT_LOOT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select(["dlt.*", "it.name", "itl.Name as localeName"])
    .from("disenchant_loot_template as dlt")
    .leftJoin("item_template as it", "dlt.Item", "it.entry")
    .leftJoin("item_template_locale as itl", function () {
      this.on("it.entry", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex().raw("?", "zhCN")
      );
    })
    .where("dlt.Entry", payload.Entry);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_DISENCHANT_LOOT_TEMPLATES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_DISENCHANT_LOOT_TEMPLATES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_DISENCHANT_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex().insert(payload).into("disenchant_loot_template");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_DISENCHANT_LOOT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_DISENCHANT_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_DISENCHANT_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("disenchant_loot_template")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(
        FIND_DISENCHANT_LOOT_TEMPLATE,
        rows.length > 0 ? rows[0] : {}
      );
    })
    .catch((error) => {
      event.reply(`${FIND_DISENCHANT_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_DISENCHANT_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("disenchant_loot_template")
    .where(payload.credential)
    .update(payload.disenchantLootTemplate);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_DISENCHANT_LOOT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_DISENCHANT_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_DISENCHANT_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("disenchant_loot_template")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_DISENCHANT_LOOT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_DISENCHANT_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_DISENCHANT_LOOT_TEMPLATE, (event, payload) => {
  let item = undefined;
  let disenchantLootTemplate = undefined;

  let itemQueryBuilder = knex()
    .select("Item")
    .from("disenchant_loot_template")
    .where("Entry", payload.Entry)
    .orderBy("Item", "desc");
  let findDisenchantLootTempalteQueryBuilder = knex()
    .select()
    .from("disenchant_loot_template")
    .where(payload);
  Promise.all([
    itemQueryBuilder.then((rows) => {
      item = rows.length > 0 ? rows[0].Item : 0;
    }),
    findDisenchantLootTempalteQueryBuilder.then((rows) => {
      disenchantLootTemplate = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      disenchantLootTemplate.Item = item + 1;
      if (disenchantLootTemplate.Reference != 0) {
        disenchantLootTemplate.Reference = item + 1;
      }
      let queryBuilder = knex()
        .insert(disenchantLootTemplate)
        .into("disenchant_loot_template");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_DISENCHANT_LOOT_TEMPLATE, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_DISENCHANT_LOOT_TEMPLATE}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_DISENCHANT_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});
