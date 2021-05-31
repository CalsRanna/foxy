import { ipcMain } from "electron";

import {
  SEARCH_SPELL_ICONS_FOR_SELECTOR,
  COUNT_SPELL_ICONS_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_SPELL_ICONS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .select(["ID", "TextureFilename"])
    .from("foxy.dbc_spell_icon");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", "like", `%${payload.ID}%`);
  }
  if (payload.TextureFilename) {
    queryBuilder = queryBuilder.where(
      "TextureFilename",
      "like",
      `%${payload.TextureFilename}%`
    );
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_SPELL_ICONS_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_SPELL_ICONS_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_SPELL_ICONS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_spell_icon");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", "like", `%${payload.ID}%`);
  }
  if (payload.TextureFilename) {
    queryBuilder = queryBuilder.where(
      "TextureFilename",
      "like",
      `%${payload.TextureFilename}%`
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_SPELL_ICONS_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_SPELL_ICONS_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
