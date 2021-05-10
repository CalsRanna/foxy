import { ipcMain } from "electron";

import {
  STORE_QUEST_TEMPLATE_ADDON,
  FIND_QUEST_TEMPLATE_ADDON,
  UPDATE_QUEST_TEMPLATE_ADDON,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(STORE_QUEST_TEMPLATE_ADDON, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("quest_template_addon");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_QUEST_TEMPLATE_ADDON, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_QUEST_TEMPLATE_ADDON}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_QUEST_TEMPLATE_ADDON, (event, payload) => {
  let queryBuilder = knex.select().from("quest_template_addon").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_QUEST_TEMPLATE_ADDON, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_QUEST_TEMPLATE_ADDON}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_QUEST_TEMPLATE_ADDON, (event, payload) => {
  let queryBuilder = knex
    .table("quest_template_addon")
    .where(payload.credential)
    .update(payload.questTemplateAddon);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_QUEST_TEMPLATE_ADDON, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_QUEST_TEMPLATE_ADDON}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
