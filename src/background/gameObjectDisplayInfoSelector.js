import { ipcMain } from "electron";

import {
  SEARCH_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR,
  COUNT_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .select(["ID", "ModelName"])
    .from("foxy.dbc_game_object_display_info");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.ModelName) {
    queryBuilder = queryBuilder.where(
      "ModelName",
      "like",
      `%${payload.ModelName}%`
    );
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(
        `${SEARCH_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR}_REJECT`,
        error
      );
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .count("* as total")
    .from("foxy.dbc_game_object_display_info");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.ModelName) {
    queryBuilder = queryBuilder.where(
      "ModelName",
      "like",
      `%${payload.ModelName}%`
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(
        `${COUNT_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR}_REJECT`,
        error
      );
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
