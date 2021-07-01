import { ipcMain } from "electron";

import {
  SEARCH_QUEST_INFOS_FOR_SELECTOR,
  COUNT_QUEST_INFOS_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_QUEST_INFOS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .select(["ID", "InfoName_Lang_zhCN"])
    .from("foxy.dbc_quest_info");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.InfoName_Lang_zhCN) {
    queryBuilder = queryBuilder.where(
      "InfoName_Lang_zhCN",
      "like",
      `%${payload.InfoName_Lang_zhCN}%`
    );
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_QUEST_INFOS_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_QUEST_INFOS_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_QUEST_INFOS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_quest_info");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.InfoName_Lang_zhCN) {
    queryBuilder = queryBuilder.where(
      "InfoName_Lang_zhCN",
      "like",
      `%${payload.InfoName_Lang_zhCN}%`
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_QUEST_INFOS_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_QUEST_INFOS_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
