import { ipcMain } from "electron";
import {
  STORE_ACHIEVEMENT_REWARD,
  FIND_ACHIEVEMENT_REWARD,
  UPDATE_ACHIEVEMENT_REWARD,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(STORE_ACHIEVEMENT_REWARD, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("achievement_reward");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_ACHIEVEMENT_REWARD, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_ACHIEVEMENT_REWARD}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_ACHIEVEMENT_REWARD, (event, payload) => {
  let queryBuilder = knex.select().from("achievement_reward").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_ACHIEVEMENT_REWARD, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_ACHIEVEMENT_REWARD}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_ACHIEVEMENT_REWARD, (event, payload) => {
  let queryBuilder = knex
    .table("achievement_reward")
    .where(payload.credential)
    .update(payload.achievementCategory);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_ACHIEVEMENT_REWARD, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_ACHIEVEMENT_REWARD}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
