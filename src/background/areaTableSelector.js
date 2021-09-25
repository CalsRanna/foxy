import { ipcMain } from "electron";

import {
  SEARCH_AREA_TABLES_FOR_SELECTOR,
  COUNT_AREA_TABLES_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_AREA_TABLES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .select(["ID", "AreaName_Lang_zhCN"])
    .from("foxy.dbc_area_table");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.AreaName_Lang_zhCN) {
    queryBuilder = queryBuilder.where(
      "AreaName_Lang_zhCN",
      "like",
      `%${payload.AreaName_Lang_zhCN}%`
    );
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_AREA_TABLES_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_AREA_TABLES_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_AREA_TABLES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_area_table");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.AreaName_Lang_zhCN) {
    queryBuilder = queryBuilder.where(
      "AreaName_Lang_zhCN",
      "like",
      `%${payload.AreaName_Lang_zhCN}%`
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_AREA_TABLES_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_AREA_TABLES_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
