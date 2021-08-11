import { ipcMain } from "electron";

import {
  SEARCH_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR,
  COUNT_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex.select().from("foxy.dbc_scaling_stat_distribution");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.Stat) {
    queryBuilder = queryBuilder
      .where("StatID_1", payload.Stat)
      .orWhere("StatID_2", payload.Stat)
      .orWhere("StatID_3", payload.Stat)
      .orWhere("StatID_4", payload.Stat)
      .orWhere("StatID_5", payload.Stat)
      .orWhere("StatID_6", payload.Stat)
      .orWhere("StatID_7", payload.Stat)
      .orWhere("StatID_8", payload.Stat)
      .orWhere("StatID_9", payload.Stat)
      .orWhere("StatID_10", payload.Stat);
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(
        `${SEARCH_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR}_REJECT`,
        error
      );
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .count("* as total")
    .from("foxy.dbc_scaling_stat_distribution");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.Stat) {
    queryBuilder = queryBuilder
      .where("StatID_1", payload.Stat)
      .orWhere("StatID_2", payload.Stat)
      .orWhere("StatID_3", payload.Stat)
      .orWhere("StatID_4", payload.Stat)
      .orWhere("StatID_5", payload.Stat)
      .orWhere("StatID_6", payload.Stat)
      .orWhere("StatID_7", payload.Stat)
      .orWhere("StatID_8", payload.Stat)
      .orWhere("StatID_9", payload.Stat)
      .orWhere("StatID_10", payload.Stat);
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(
        `${COUNT_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR}_REJECT`,
        error
      );
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
