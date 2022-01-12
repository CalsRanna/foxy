import { ipcMain } from "electron";
import {
  STORE_ACHIEVEMENT_CATEGORY,
  FIND_ACHIEVEMENT_CATEGORY,
  UPDATE_ACHIEVEMENT_CATEGORY,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(STORE_ACHIEVEMENT_CATEGORY, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("foxy.dbc_achievement_category");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_ACHIEVEMENT_CATEGORY, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_ACHIEVEMENT_CATEGORY}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_ACHIEVEMENT_CATEGORY, (event, payload) => {
  let queryBuilder = knex
    .select()
    .from("foxy.dbc_achievement_category")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_ACHIEVEMENT_CATEGORY, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_ACHIEVEMENT_CATEGORY}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_ACHIEVEMENT_CATEGORY, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_achievement_category")
    .where(payload.credential)
    .update(payload.achievementCategory);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_ACHIEVEMENT_CATEGORY, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_ACHIEVEMENT_CATEGORY}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
