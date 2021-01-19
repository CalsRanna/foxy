import { ipcMain } from "electron";

import {
  SEARCH_CREATURE_TEMPLATE_LOCALES,
  STORE_CREATURE_TEMPLATE_LOCALES,
  GLOBAL_NOTICE
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_CREATURE_TEMPLATE_LOCALES, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("creature_template_locale")
    .where(payload);

  queryBuilder
    .then(rows => {
      event.reply(SEARCH_CREATURE_TEMPLATE_LOCALES, rows);
    })
    .catch(error => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString()
      });
    });
});

ipcMain.on(STORE_CREATURE_TEMPLATE_LOCALES, (event, payload) => {
  let deleteQueryBuilder = knex()
    .table("creature_template_locale")
    .where("entry", payload[0].entry)
    .delete();
  let insertQueryBuilder = knex()
    .insert(payload)
    .into("creature_template_locale");

  deleteQueryBuilder
    .then(rows => {
      insertQueryBuilder
        .then(rows => {
          event.reply(STORE_CREATURE_TEMPLATE_LOCALES, rows);
          event.reply(GLOBAL_NOTICE, {
            type: "success",
            category: "notification",
            title: "成功",
            message: `保存成功。`
          });
        })
        .catch(error => {
          throw error;
        })
        .finally(() => {
          event.reply(GLOBAL_NOTICE, {
            category: "message",
            message: insertQueryBuilder.toString()
          });
        });
    })
    .catch(error => {
      throw error;
    });
});
