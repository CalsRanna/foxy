import { ipcMain } from "electron";

import {
  SEARCH_SPELL_LOOT_TEMPLATES,
  STORE_SPELL_LOOT_TEMPLATE,
  FIND_SPELL_LOOT_TEMPLATE,
  UPDATE_SPELL_LOOT_TEMPLATE,
  DESTROY_SPELL_LOOT_TEMPLATE,
  COPY_SPELL_LOOT_TEMPLATE,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_SPELL_LOOT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select(["slt.*", "it.name", "itl.Name as localeName"])
    .from("spell_loot_template as slt")
    .leftJoin("item_template as it", "slt.Item", "it.entry")
    .leftJoin("item_template_locale as itl", function() {
      this.on("it.entry", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex().raw("?", "zhCN")
      );
    })
    .where("slt.Entry", payload.Entry);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_SPELL_LOOT_TEMPLATES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_SPELL_LOOT_TEMPLATES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_SPELL_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("spell_loot_template");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_SPELL_LOOT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_SPELL_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_SPELL_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("spell_loot_template")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_SPELL_LOOT_TEMPLATE, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_SPELL_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_SPELL_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("spell_loot_template")
    .where(payload.credential)
    .update(payload.spellLootTemplate);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_SPELL_LOOT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_SPELL_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_SPELL_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("spell_loot_template")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_SPELL_LOOT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_SPELL_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_SPELL_LOOT_TEMPLATE, (event, payload) => {
  let item = undefined;
  let spellLootTemplate = undefined;

  let itemQueryBuilder = knex()
    .select("Item")
    .from("spell_loot_template")
    .where("Entry", payload.Entry)
    .orderBy("Item", "desc");
  let findSpellLootTempalteQueryBuilder = knex()
    .select()
    .from("spell_loot_template")
    .where(payload);
  Promise.all([
    itemQueryBuilder.then((rows) => {
      item = rows.length > 0 ? rows[0].Item : 0;
    }),
    findSpellLootTempalteQueryBuilder.then((rows) => {
      spellLootTemplate = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      spellLootTemplate.Item = item + 1;
      if (spellLootTemplate.Reference != 0) {
        spellLootTemplate.Reference = item + 1;
      }
      let queryBuilder = knex()
        .insert(spellLootTemplate)
        .into("spell_loot_template");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_SPELL_LOOT_TEMPLATE, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_SPELL_LOOT_TEMPLATE}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_SPELL_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});
