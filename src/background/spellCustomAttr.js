import { ipcMain } from "electron";
import {
  STORE_SPELL_CUSTOM_ATTR,
  FIND_SPELL_CUSTOM_ATTR,
  UPDATE_SPELL_CUSTOM_ATTR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(STORE_SPELL_CUSTOM_ATTR, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("spell_custom_attr");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_SPELL_CUSTOM_ATTR, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_SPELL_CUSTOM_ATTR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_SPELL_CUSTOM_ATTR, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("spell_custom_attr")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_SPELL_CUSTOM_ATTR, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_SPELL_CUSTOM_ATTR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_SPELL_CUSTOM_ATTR, (event, payload) => {
  let queryBuilder = knex()
    .table("spell_custom_attr")
    .where(payload.credential)
    .update(payload.creatureTemplateAddon);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_SPELL_CUSTOM_ATTR, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_SPELL_CUSTOM_ATTR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
