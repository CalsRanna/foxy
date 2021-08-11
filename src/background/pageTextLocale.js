import { ipcMain } from "electron";

import {
  SEARCH_PAGE_TEXT_LOCALES,
  STORE_PAGE_TEXT_LOCALES,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_PAGE_TEXT_LOCALES, (event, payload) => {
  let queryBuilder = knex.select().from("page_text_locale").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_PAGE_TEXT_LOCALES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_PAGE_TEXT_LOCALES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_PAGE_TEXT_LOCALES, (event, payload) => {
  let deleteQueryBuilder = knex
    .table("page_text_locale")
    .where("ID", payload[0].ID)
    .delete();
  let insertQueryBuilder = knex.insert(payload).into("page_text_locale");

  deleteQueryBuilder
    .then((rows) => {
      insertQueryBuilder
        .then((rows) => {
          event.reply(STORE_PAGE_TEXT_LOCALES, rows);
        })
        .catch((error) => {
          event.reply(`${STORE_PAGE_TEXT_LOCALES}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, insertQueryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${STORE_PAGE_TEXT_LOCALES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
