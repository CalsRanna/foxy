import { ipcMain } from "electron";
import {
  STORE_SPELL_BONUS_DATA,
  FIND_SPELL_BONUS_DATA,
  UPDATE_SPELL_BONUS_DATA,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(STORE_SPELL_BONUS_DATA, (event, payload) => {
  let queryBuilder = knex().insert(payload).into("spell_bonus_data");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_SPELL_BONUS_DATA, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_SPELL_BONUS_DATA}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_SPELL_BONUS_DATA, (event, payload) => {
  let queryBuilder = knex().select().from("spell_bonus_data").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_SPELL_BONUS_DATA, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_SPELL_BONUS_DATA}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_SPELL_BONUS_DATA, (event, payload) => {
  let queryBuilder = knex()
    .table("spell_bonus_data")
    .where(payload.credential)
    .update(payload.creatureTemplateAddon);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_SPELL_BONUS_DATA, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_SPELL_BONUS_DATA}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
