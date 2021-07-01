import { ipcMain } from "electron";

import {
  SEARCH_AREA_TABLES_FOR_ATOQS_SELECTOR,
  COUNT_AREA_TABLES_FOR_ATOQS_SELECTOR,
  SEARCH_QUEST_SORTS_FOR_ATOQS_SELECTOR,
  COUNT_QUEST_SORTS_FOR_ATOQS_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_AREA_TABLES_FOR_ATOQS_SELECTOR, (event, payload) => {
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
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_AREA_TABLES_FOR_ATOQS_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_AREA_TABLES_FOR_ATOQS_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_AREA_TABLES_FOR_ATOQS_SELECTOR, (event, payload) => {
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
      event.reply(COUNT_AREA_TABLES_FOR_ATOQS_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_AREA_TABLES_FOR_ATOQS_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(SEARCH_QUEST_SORTS_FOR_ATOQS_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .select(["ID", "SortName_Lang_zhCN"])
    .from("foxy.dbc_quest_sort");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.SortName_Lang_zhCN) {
    queryBuilder = queryBuilder.where(
      "SortName_Lang_zhCN",
      "like",
      `%${payload.SortName_Lang_zhCN}%`
    );
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_QUEST_SORTS_FOR_ATOQS_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_QUEST_SORTS_FOR_ATOQS_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_QUEST_SORTS_FOR_ATOQS_SELECTOR, (event, payload) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_quest_sort");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.SortName_Lang_zhCN) {
    queryBuilder = queryBuilder.where(
      "SortName_Lang_zhCN",
      "like",
      `%${payload.SortName_Lang_zhCN}%`
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_QUEST_SORTS_FOR_ATOQS_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_QUEST_SORTS_FOR_ATOQS_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
