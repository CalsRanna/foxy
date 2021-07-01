import { ipcMain } from "electron";

import {
  SEARCH_WAYPOINT_DATAS_FOR_SELECTOR,
  COUNT_WAYPOINT_DATAS_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_WAYPOINT_DATAS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .select(["id", knex.raw("count(point) as points")])
    .groupBy("id")
    .from("waypoint_data");
  if (payload.id) {
    queryBuilder = queryBuilder.where("id", payload.id);
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_WAYPOINT_DATAS_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_WAYPOINT_DATAS_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_WAYPOINT_DATAS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .count({ total: knex.raw("distinct id") })
    .from("waypoint_data");
  if (payload.id) {
    queryBuilder = queryBuilder.where("id", payload.id);
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_WAYPOINT_DATAS_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_WAYPOINT_DATAS_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
