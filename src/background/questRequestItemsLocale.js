import { ipcMain } from "electron";

import {
  SEARCH_QUEST_REQUEST_ITEMS_LOCALES,
  STORE_QUEST_REQUEST_ITEMS_LOCALES,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_QUEST_REQUEST_ITEMS_LOCALES, (event, payload) => {
  let queryBuilder = knex.select().from("quest_request_items_locale").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_QUEST_REQUEST_ITEMS_LOCALES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_QUEST_REQUEST_ITEMS_LOCALES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_QUEST_REQUEST_ITEMS_LOCALES, (event, payload) => {
  let deleteQueryBuilder = knex
    .table("quest_request_items_locale")
    .where("ID", payload[0].ID)
    .delete();
  let insertQueryBuilder = knex.insert(payload).into("quest_request_items_locale");

  deleteQueryBuilder
    .then((rows) => {
      insertQueryBuilder
        .then((rows) => {
          event.reply(STORE_QUEST_REQUEST_ITEMS_LOCALES, rows);
        })
        .catch((error) => {
          event.reply(`${STORE_QUEST_REQUEST_ITEMS_LOCALES}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, insertQueryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${STORE_QUEST_REQUEST_ITEMS_LOCALES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
