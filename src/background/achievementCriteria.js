import { ipcMain } from "electron";
import {
  STORE_ACHIEVEMENT_CRITERIA,
  FIND_ACHIEVEMENT_CRITERIA,
  UPDATE_ACHIEVEMENT_CRITERIA,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(STORE_ACHIEVEMENT_CRITERIA, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("foxy.dbc_achievement_criteria");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_ACHIEVEMENT_CRITERIA, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_ACHIEVEMENT_CRITERIA}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_ACHIEVEMENT_CRITERIA, (event, payload) => {
  let queryBuilder = knex
    .select()
    .from("foxy.dbc_achievement_criteria")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_ACHIEVEMENT_CRITERIA, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_ACHIEVEMENT_CRITERIA}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_ACHIEVEMENT_CRITERIA, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_achievement_criteria")
    .where(payload.credential)
    .update(payload.achievementCriteria);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_ACHIEVEMENT_CRITERIA, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_ACHIEVEMENT_CRITERIA}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
