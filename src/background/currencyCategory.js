import { ipcMain } from "electron";
import {
  STORE_CURRENCY_CATEGORY,
  FIND_CURRENCY_CATEGORY,
  UPDATE_CURRENCY_CATEGORY,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(STORE_CURRENCY_CATEGORY, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("foxy.dbc_currency_category");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_CURRENCY_CATEGORY, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_CURRENCY_CATEGORY}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_CURRENCY_CATEGORY, (event, payload) => {
  let queryBuilder = knex
    .select()
    .from("foxy.dbc_currency_category")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_CURRENCY_CATEGORY, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_CURRENCY_CATEGORY}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_CURRENCY_CATEGORY, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_currency_category")
    .where(payload.credential)
    .update(payload.currencyCategory);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_CURRENCY_CATEGORY, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_CURRENCY_CATEGORY}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
