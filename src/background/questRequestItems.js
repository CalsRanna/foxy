import { ipcMain } from "electron";

import {
  STORE_QUEST_REQUEST_ITEMS,
  FIND_QUEST_REQUEST_ITEMS,
  UPDATE_QUEST_REQUEST_ITEMS,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(STORE_QUEST_REQUEST_ITEMS, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("quest_request_items");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_QUEST_REQUEST_ITEMS, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_QUEST_REQUEST_ITEMS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_QUEST_REQUEST_ITEMS, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("quest_request_items")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_QUEST_REQUEST_ITEMS, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_QUEST_REQUEST_ITEMS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_QUEST_REQUEST_ITEMS, (event, payload) => {
  let queryBuilder = knex()
    .table("quest_request_items")
    .where(payload.credential)
    .update(payload.questRequestItems);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_QUEST_REQUEST_ITEMS, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_QUEST_REQUEST_ITEMS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
