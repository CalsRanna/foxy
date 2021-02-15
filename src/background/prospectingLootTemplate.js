import { ipcMain } from "electron";

import {
  SEARCH_PROSPECTING_LOOT_TEMPLATES,
  STORE_PROSPECTING_LOOT_TEMPLATE,
  FIND_PROSPECTING_LOOT_TEMPLATE,
  UPDATE_PROSPECTING_LOOT_TEMPLATE,
  DESTROY_PROSPECTING_LOOT_TEMPLATE,
  COPY_PROSPECTING_LOOT_TEMPLATE,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_PROSPECTING_LOOT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select(["plt.*", "it.name", "itl.Name as localeName"])
    .from("prospecting_loot_template as plt")
    .leftJoin("item_template as it", "plt.Item", "it.entry")
    .leftJoin("item_template_locale as itl", function() {
      this.on("it.entry", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex().raw("?", "zhCN")
      );
    })
    .where("plt.Entry", payload.Entry);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_PROSPECTING_LOOT_TEMPLATES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_PROSPECTING_LOOT_TEMPLATES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_PROSPECTING_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("prospecting_loot_template");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_PROSPECTING_LOOT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_PROSPECTING_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_PROSPECTING_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("prospecting_loot_template")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(
        FIND_PROSPECTING_LOOT_TEMPLATE,
        rows.length > 0 ? rows[0] : {}
      );
    })
    .catch((error) => {
      event.reply(`${FIND_PROSPECTING_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_PROSPECTING_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("prospecting_loot_template")
    .where(payload.credential)
    .update(payload.prospectingLootTemplate);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_PROSPECTING_LOOT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_PROSPECTING_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_PROSPECTING_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("prospecting_loot_template")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_PROSPECTING_LOOT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_PROSPECTING_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_PROSPECTING_LOOT_TEMPLATE, (event, payload) => {
  let item = undefined;
  let prospectingLootTemplate = undefined;

  let itemQueryBuilder = knex()
    .select("Item")
    .from("prospecting_loot_template")
    .where("Entry", payload.Entry)
    .orderBy("Item", "desc");
  let findProspectingLootTempalteQueryBuilder = knex()
    .select()
    .from("prospecting_loot_template")
    .where(payload);
  Promise.all([
    itemQueryBuilder.then((rows) => {
      item = rows.length > 0 ? rows[0].Item : 0;
    }),
    findProspectingLootTempalteQueryBuilder.then((rows) => {
      prospectingLootTemplate = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      prospectingLootTemplate.Item = item + 1;
      if (prospectingLootTemplate.Reference != 0) {
        prospectingLootTemplate.Reference = item + 1;
      }
      let queryBuilder = knex()
        .insert(prospectingLootTemplate)
        .into("prospecting_loot_template");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_PROSPECTING_LOOT_TEMPLATE, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_PROSPECTING_LOOT_TEMPLATE}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_PROSPECTING_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
