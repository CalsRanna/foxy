import { ipcMain } from "electron";

import {
  SEARCH_GAME_OBJECT_TEMPLATE_LOCALES,
  STORE_GAME_OBJECT_TEMPLATE_LOCALES,
  GLOBAL_NOTICE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_GAME_OBJECT_TEMPLATE_LOCALES, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("gameobject_template_locale")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_GAME_OBJECT_TEMPLATE_LOCALES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_GAME_OBJECT_TEMPLATE_LOCALES}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(STORE_GAME_OBJECT_TEMPLATE_LOCALES, (event, payload) => {
  let deleteQueryBuilder = knex()
    .table("gameobject_template_locale")
    .where("entry", payload[0].entry)
    .delete();
  let insertQueryBuilder = knex()
    .insert(payload)
    .into("gameobject_template_locale");

  deleteQueryBuilder
    .then((rows) => {
      insertQueryBuilder
        .then((rows) => {
          event.reply(STORE_GAME_OBJECT_TEMPLATE_LOCALES, rows);
          event.reply(GLOBAL_NOTICE, {
            type: "success",
            category: "notification",
            title: "成功",
            message: `保存成功。`,
          });
        })
        .catch((error) => {
          event.reply(`${STORE_GAME_OBJECT_TEMPLATE_LOCALES}_REJECT`, error);
        })
        .finally(() => {
          event.reply(GLOBAL_NOTICE, {
            category: "message",
            message: insertQueryBuilder.toString(),
          });
        });
    })
    .catch((error) => {
      event.reply(`${STORE_GAME_OBJECT_TEMPLATE_LOCALES}_REJECT`, error);
    });
});
