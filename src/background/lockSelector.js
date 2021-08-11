import { ipcMain } from "electron";

import {
  SEARCH_LOCKS_FOR_SELECTOR,
  COUNT_LOCKS_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_LOCKS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .select([
      "dl.ID",
      "dlt1.Name_Lang_zhCN as Name_1",
      "dlt2.Name_Lang_zhCN as Name_2",
      "dlt3.Name_Lang_zhCN as Name_3",
      "dlt4.Name_Lang_zhCN as Name_4",
      "dlt5.Name_Lang_zhCN as Name_5",
      "dlt6.Name_Lang_zhCN as Name_6",
      "dlt7.Name_Lang_zhCN as Name_7",
      "dlt8.Name_Lang_zhCN as Name_8",
    ])
    .from("foxy.dbc_lock as dl")
    .leftJoin("foxy.dbc_lock_type as dlt1", "dl.Type_1", "dlt1.ID")
    .leftJoin("foxy.dbc_lock_type as dlt2", "dl.Type_2", "dlt2.ID")
    .leftJoin("foxy.dbc_lock_type as dlt3", "dl.Type_3", "dlt3.ID")
    .leftJoin("foxy.dbc_lock_type as dlt4", "dl.Type_4", "dlt4.ID")
    .leftJoin("foxy.dbc_lock_type as dlt5", "dl.Type_5", "dlt5.ID")
    .leftJoin("foxy.dbc_lock_type as dlt6", "dl.Type_6", "dlt6.ID")
    .leftJoin("foxy.dbc_lock_type as dlt7", "dl.Type_7", "dlt7.ID")
    .leftJoin("foxy.dbc_lock_type as dlt8", "dl.Type_8", "dlt8.ID");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("dl.ID", payload.ID);
  }
  if (payload.Name_Lang_zhCN) {
    queryBuilder = queryBuilder
      .where("dlt1.Name_Lang_zhCN", "like", `%${payload.Name_Lang_zhCN}%`)
      .orWhere("dlt2.Name_Lang_zhCN", "like", `%${payload.Name_Lang_zhCN}%`)
      .orWhere("dlt3.Name_Lang_zhCN", "like", `%${payload.Name_Lang_zhCN}%`)
      .orWhere("dlt4.Name_Lang_zhCN", "like", `%${payload.Name_Lang_zhCN}%`)
      .orWhere("dlt5.Name_Lang_zhCN", "like", `%${payload.Name_Lang_zhCN}%`)
      .orWhere("dlt6.Name_Lang_zhCN", "like", `%${payload.Name_Lang_zhCN}%`)
      .orWhere("dlt7.Name_Lang_zhCN", "like", `%${payload.Name_Lang_zhCN}%`)
      .orWhere("dlt8.Name_Lang_zhCN", "like", `%${payload.Name_Lang_zhCN}%`);
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_LOCKS_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_LOCKS_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_LOCKS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .count("dl.ID as total")
    .from("foxy.dbc_lock as dl")
    .leftJoin("foxy.dbc_lock_type as dlt1", "dl.Type_1", "dlt1.ID")
    .leftJoin("foxy.dbc_lock_type as dlt2", "dl.Type_2", "dlt2.ID")
    .leftJoin("foxy.dbc_lock_type as dlt3", "dl.Type_3", "dlt3.ID")
    .leftJoin("foxy.dbc_lock_type as dlt4", "dl.Type_4", "dlt4.ID")
    .leftJoin("foxy.dbc_lock_type as dlt5", "dl.Type_5", "dlt5.ID")
    .leftJoin("foxy.dbc_lock_type as dlt6", "dl.Type_6", "dlt6.ID")
    .leftJoin("foxy.dbc_lock_type as dlt7", "dl.Type_7", "dlt7.ID")
    .leftJoin("foxy.dbc_lock_type as dlt8", "dl.Type_8", "dlt8.ID");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("dl.ID", payload.ID);
  }
  if (payload.Name_Lang_zhCN) {
    queryBuilder = queryBuilder
      .where("dlt1.Name_Lang_zhCN", "like", `%${payload.Name_Lang_zhCN}%`)
      .orWhere("dlt2.Name_Lang_zhCN", "like", `%${payload.Name_Lang_zhCN}%`)
      .orWhere("dlt3.Name_Lang_zhCN", "like", `%${payload.Name_Lang_zhCN}%`)
      .orWhere("dlt4.Name_Lang_zhCN", "like", `%${payload.Name_Lang_zhCN}%`)
      .orWhere("dlt5.Name_Lang_zhCN", "like", `%${payload.Name_Lang_zhCN}%`)
      .orWhere("dlt6.Name_Lang_zhCN", "like", `%${payload.Name_Lang_zhCN}%`)
      .orWhere("dlt7.Name_Lang_zhCN", "like", `%${payload.Name_Lang_zhCN}%`)
      .orWhere("dlt8.Name_Lang_zhCN", "like", `%${payload.Name_Lang_zhCN}%`);
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_LOCKS_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_LOCKS_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
