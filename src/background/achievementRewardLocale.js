import { ipcMain } from "electron";

import {
  SEARCH_ACHIEVEMENT_REWARD_LOCALES,
  STORE_ACHIEVEMENT_REWARD_LOCALES,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_ACHIEVEMENT_REWARD_LOCALES, (event, payload) => {
  let queryBuilder = knex
    .select()
    .from("achievement_reward_locale")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_ACHIEVEMENT_REWARD_LOCALES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_ACHIEVEMENT_REWARD_LOCALES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_ACHIEVEMENT_REWARD_LOCALES, (event, payload) => {
  let deleteQueryBuilder = knex
    .table("achievement_reward_locale")
    .where("entry", payload[0].entry)
    .delete();
  let insertQueryBuilder = knex
    .insert(payload)
    .into("achievement_reward_locale");

  deleteQueryBuilder
    .then((rows) => {
      insertQueryBuilder
        .then((rows) => {
          event.reply(STORE_ACHIEVEMENT_REWARD_LOCALES, rows);
        })
        .catch((error) => {
          event.reply(`${STORE_ACHIEVEMENT_REWARD_LOCALES}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, insertQueryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${STORE_ACHIEVEMENT_REWARD_LOCALES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
