import { ipcMain } from "electron";

import {
  SEARCH_REFERENCE_LOOT_TEMPLATES_FOR_CARD,
  STORE_REFERENCE_LOOT_TEMPLATE_FOR_CARD,
  FIND_REFERENCE_LOOT_TEMPLATE_FOR_CARD,
  UPDATE_REFERENCE_LOOT_TEMPLATE_FOR_CARD,
  DESTROY_REFERENCE_LOOT_TEMPLATE_FOR_CARD,
  COPY_REFERENCE_LOOT_TEMPLATE_FOR_CARD,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_REFERENCE_LOOT_TEMPLATES_FOR_CARD, (event, payload) => {
  let queryBuilder = knex
    .select([
      "rlt.*",
      "it.name",
      "itl.Name as localeName",
      "it.Quality",
      "didi.InventoryIcon_1",
    ])
    .from("reference_loot_template as rlt")
    .leftJoin("item_template as it", "rlt.Item", "it.entry")
    .leftJoin("item_template_locale as itl", function () {
      this.on("it.entry", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    })
    .leftJoin("foxy.dbc_item_display_info as didi", "it.displayid", "didi.ID")
    .whereIn("rlt.Entry", payload.entries);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_REFERENCE_LOOT_TEMPLATES_FOR_CARD, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_REFERENCE_LOOT_TEMPLATES_FOR_CARD}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_REFERENCE_LOOT_TEMPLATE_FOR_CARD, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("reference_loot_template");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_REFERENCE_LOOT_TEMPLATE_FOR_CARD, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_REFERENCE_LOOT_TEMPLATE_FOR_CARD}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_REFERENCE_LOOT_TEMPLATE_FOR_CARD, (event, payload) => {
  let queryBuilder = knex
    .select()
    .from("reference_loot_template")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(
        FIND_REFERENCE_LOOT_TEMPLATE_FOR_CARD,
        rows.length > 0 ? rows[0] : {}
      );
    })
    .catch((error) => {
      event.reply(`${FIND_REFERENCE_LOOT_TEMPLATE_FOR_CARD}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_REFERENCE_LOOT_TEMPLATE_FOR_CARD, (event, payload) => {
  let queryBuilder = knex
    .table("reference_loot_template")
    .where(payload.credential)
    .update(payload.itemLootTemplate);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_REFERENCE_LOOT_TEMPLATE_FOR_CARD, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_REFERENCE_LOOT_TEMPLATE_FOR_CARD}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_REFERENCE_LOOT_TEMPLATE_FOR_CARD, (event, payload) => {
  let queryBuilder = knex
    .table("reference_loot_template")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_REFERENCE_LOOT_TEMPLATE_FOR_CARD, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_REFERENCE_LOOT_TEMPLATE_FOR_CARD}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_REFERENCE_LOOT_TEMPLATE_FOR_CARD, (event, payload) => {
  let item = undefined;
  let itemLootTemplate = undefined;

  let itemQueryBuilder = knex
    .select("Item")
    .from("reference_loot_template")
    .where("Entry", payload.Entry)
    .orderBy("Item", "desc");
  let findItemLootTempalteQueryBuilder = knex
    .select()
    .from("reference_loot_template")
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
      let queryBuilder = knex
        .insert(itemLootTemplate)
        .into("reference_loot_template");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_REFERENCE_LOOT_TEMPLATE_FOR_CARD, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_REFERENCE_LOOT_TEMPLATE_FOR_CARD}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_REFERENCE_LOOT_TEMPLATE_FOR_CARD}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on("CHECK_REFERENCE_ENTRIES_FOR_CARD", (event, payload) => {
  let queryBuilder = knex
    .distinct("Reference")
    .from("reference_loot_template")
    .whereIn("Entry", payload.entries);

  queryBuilder
    .then((rows) => {
      event.reply("CHECK_REFERENCE_ENTRIES_FOR_CARD", rows);
    })
    .catch((error) => {
      event.reply("CHECK_REFERENCE_ENTRIES_FOR_CARD_REJECT", error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
