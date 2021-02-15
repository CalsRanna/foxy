import { ipcMain } from "electron";

import {
  SEARCH_ITEM_TEMPLATE_LOCALES,
  STORE_ITEM_TEMPLATE_LOCALES,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_ITEM_TEMPLATE_LOCALES, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("item_template_locale")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_ITEM_TEMPLATE_LOCALES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_ITEM_TEMPLATE_LOCALES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_ITEM_TEMPLATE_LOCALES, (event, payload) => {
  let deleteQueryBuilder = knex()
    .table("item_template_locale")
    .where("ID", payload[0].ID)
    .delete();
  let insertQueryBuilder = knex()
    .insert(payload)
    .into("item_template_locale");

  deleteQueryBuilder
    .then((rows) => {
      insertQueryBuilder
        .then((rows) => {
          event.reply(STORE_ITEM_TEMPLATE_LOCALES, rows);
        })
        .catch((error) => {
          event.reply(`${STORE_ITEM_TEMPLATE_LOCALES}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, insertQueryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${STORE_ITEM_TEMPLATE_LOCALES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
