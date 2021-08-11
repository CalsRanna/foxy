import { ipcMain } from "electron";

import {
  SEARCH_EMOTES_FOR_SELECTOR,
  COUNT_EMOTES_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_EMOTES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .select(["ID", "EmoteSlashCommand"])
    .from("foxy.dbc_emotes");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.EmoteSlashCommand) {
    queryBuilder = queryBuilder.where(
      "EmoteSlashCommand",
      "like",
      `%${payload.EmoteSlashCommand}%`
    );
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_EMOTES_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_EMOTES_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_EMOTES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_emotes");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.EmoteSlashCommand) {
    queryBuilder = queryBuilder.where(
      "EmoteSlashCommand",
      "like",
      `%${payload.EmoteSlashCommand}%`
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_EMOTES_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_EMOTES_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
