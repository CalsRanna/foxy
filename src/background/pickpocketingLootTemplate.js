import { ipcMain } from "electron";

import {
  SEARCH_PICKPOCKETING_LOOT_TEMPLATES,
  STORE_PICKPOCKETING_LOOT_TEMPLATE,
  FIND_PICKPOCKETING_LOOT_TEMPLATE,
  UPDATE_PICKPOCKETING_LOOT_TEMPLATE,
  DESTROY_PICKPOCKETING_LOOT_TEMPLATE,
  COPY_PICKPOCKETING_LOOT_TEMPLATE,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_PICKPOCKETING_LOOT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select(["plt.*", "it.name", "itl.Name as localeName"])
    .from("pickpocketing_loot_template as plt")
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
      event.reply(SEARCH_PICKPOCKETING_LOOT_TEMPLATES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_PICKPOCKETING_LOOT_TEMPLATES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_PICKPOCKETING_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("pickpocketing_loot_template");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_PICKPOCKETING_LOOT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_PICKPOCKETING_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_PICKPOCKETING_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("pickpocketing_loot_template")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(
        FIND_PICKPOCKETING_LOOT_TEMPLATE,
        rows.length > 0 ? rows[0] : {}
      );
    })
    .catch((error) => {
      event.reply(`${FIND_PICKPOCKETING_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_PICKPOCKETING_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("pickpocketing_loot_template")
    .where(payload.credential)
    .update(payload.pickpocketingLootTemplate);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_PICKPOCKETING_LOOT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_PICKPOCKETING_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_PICKPOCKETING_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("pickpocketing_loot_template")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_PICKPOCKETING_LOOT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_PICKPOCKETING_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_PICKPOCKETING_LOOT_TEMPLATE, (event, payload) => {
  let item = undefined;
  let pickpocketingLootTemplate = undefined;

  let itemQueryBuilder = knex()
    .select("Item")
    .from("pickpocketing_loot_template")
    .where("Entry", payload.Entry)
    .orderBy("Item", "desc");
  let findPickpocketingLootTemplateQueryBuilder = knex()
    .select()
    .from("pickpocketing_loot_template")
    .where(payload);
  Promise.all([
    itemQueryBuilder.then((rows) => {
      item = rows.length > 0 ? rows[0].Item : 0;
    }),
    findPickpocketingLootTemplateQueryBuilder.then((rows) => {
      pickpocketingLootTemplate = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      pickpocketingLootTemplate.Item = item + 1;
      if (pickpocketingLootTemplate.Reference != 0) {
        pickpocketingLootTemplate.Reference = item + 1;
      }
      let queryBuilder = knex()
        .insert(pickpocketingLootTemplate)
        .into("pickpocketing_loot_template");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_PICKPOCKETING_LOOT_TEMPLATE, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_PICKPOCKETING_LOOT_TEMPLATE}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_PICKPOCKETING_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});
