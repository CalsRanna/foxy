import { ipcMain } from "electron";

import {
  SEARCH_GAME_OBJECT_LOOT_TEMPLATES,
  STORE_GAME_OBJECT_LOOT_TEMPLATE,
  FIND_GAME_OBJECT_LOOT_TEMPLATE,
  UPDATE_GAME_OBJECT_LOOT_TEMPLATE,
  DESTROY_GAME_OBJECT_LOOT_TEMPLATE,
  COPY_GAME_OBJECT_LOOT_TEMPLATE,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_GAME_OBJECT_LOOT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select(["golt.*", "it.name", "itl.Name as localeName"])
    .from("gameobject_loot_template as golt")
    .leftJoin("item_template as it", "golt.Item", "it.entry")
    .leftJoin("item_template_locale as itl", function() {
      this.on("it.entry", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex().raw("?", "zhCN")
      );
    })
    .where("golt.Entry", payload.Entry);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_GAME_OBJECT_LOOT_TEMPLATES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_GAME_OBJECT_LOOT_TEMPLATES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_GAME_OBJECT_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("gameobject_loot_template");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_GAME_OBJECT_LOOT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_GAME_OBJECT_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_GAME_OBJECT_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("gameobject_loot_template")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(
        FIND_GAME_OBJECT_LOOT_TEMPLATE,
        rows.length > 0 ? rows[0] : {}
      );
    })
    .catch((error) => {
      event.reply(`${FIND_GAME_OBJECT_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_GAME_OBJECT_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("gameobject_loot_template")
    .where(payload.credential)
    .update(payload.gameObjectLootTemplate);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_GAME_OBJECT_LOOT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_GAME_OBJECT_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_GAME_OBJECT_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("gameobject_loot_template")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_GAME_OBJECT_LOOT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_GAME_OBJECT_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_GAME_OBJECT_LOOT_TEMPLATE, (event, payload) => {
  let item = undefined;
  let gameObjectLootTemplate = undefined;

  let itemQueryBuilder = knex()
    .select("Item")
    .from("gameobject_loot_template")
    .where("Entry", payload.Entry)
    .orderBy("Item", "desc");
  let findGameObjectLootTempalteQueryBuilder = knex()
    .select()
    .from("gameobject_loot_template")
    .where(payload);
  Promise.all([
    itemQueryBuilder.then((rows) => {
      item = rows.length > 0 ? rows[0].Item : 0;
    }),
    findGameObjectLootTempalteQueryBuilder.then((rows) => {
      gameObjectLootTemplate = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      gameObjectLootTemplate.Item = item + 1;
      if (gameObjectLootTemplate.Reference != 0) {
        gameObjectLootTemplate.Reference = item + 1;
      }
      let queryBuilder = knex()
        .insert(gameObjectLootTemplate)
        .into("gameobject_loot_template");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_GAME_OBJECT_LOOT_TEMPLATE, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_GAME_OBJECT_LOOT_TEMPLATE}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_GAME_OBJECT_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});
