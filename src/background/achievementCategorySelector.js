import { ipcMain } from "electron";
import {
  SEARCH_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR,
  COUNT_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .select([
      "dac.ID",
      "dac.Name_Lang_zhCN",
      "pdac.Name_Lang_zhCN as ParentName",
      "gpdac.Name_Lang_zhCN as GrandParentName",
    ])
    .from("foxy.dbc_achievement_category as dac")
    .leftJoin("foxy.dbc_achievement_category as pdac", "dac.Parent", "pdac.ID")
    .leftJoin(
      "foxy.dbc_achievement_category as gpdac",
      "pdac.Parent",
      "gpdac.ID"
    );
  if (payload.ID) {
    queryBuilder = queryBuilder.where("dac.ID", payload.ID);
  }
  if (payload.Name_Lang_zhCN) {
    queryBuilder = queryBuilder.where(
      "dac.Name_Lang_zhCN",
      "like",
      `%${payload.Name_Lang_zhCN}%`
    );
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(
        `${SEARCH_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR}_REJECT`,
        error
      );
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .count("* as total")
    .from("foxy.dbc_achievement_category as dac")
    .leftJoin("foxy.dbc_achievement_category as pdac", "dac.Parent", "pdac.ID")
    .leftJoin(
      "foxy.dbc_achievement_category as gpdac",
      "pdac.Parent",
      "gpdac.ID"
    );
  if (payload.ID) {
    queryBuilder = queryBuilder.where("dac.ID", payload.ID);
  }
  if (payload.Name_Lang_zhCN) {
    queryBuilder = queryBuilder.where(
      "dac.Name_Lang_zhCN",
      "like",
      `%${payload.Name_Lang_zhCN}%`
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
