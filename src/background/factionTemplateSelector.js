import { ipcMain } from "electron";

import {
  SEARCH_FACTION_TEMPLATES_FOR_SELECTOR,
  COUNT_FACTION_TEMPLATES_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_FACTION_TEMPLATES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .select([
      "dft.ID",
      "dft.Faction",
      "df.Name_Lang_zhCN",
      "df.Description_Lang_zhCN",
    ])
    .from("foxy.dbc_faction_template as dft")
    .leftJoin("foxy.dbc_faction as df", "dft.Faction", "df.ID");
  if (payload.ID != undefined) {
    queryBuilder = queryBuilder.where("dft.ID", payload.ID);
  }
  if (payload.Name_Lang_zhCN != undefined) {
    queryBuilder = queryBuilder.where(
      "df.Name_Lang_zhCN",
      "like",
      `%${payload.Name_Lang_zhCN}%`
    );
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_FACTION_TEMPLATES_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_FACTION_TEMPLATES_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_FACTION_TEMPLATES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .count("* as total")
    .from("foxy.dbc_faction_template as dft")
    .leftJoin("foxy.dbc_faction as df", "dft.Faction", "df.ID");
  if (payload.ID != undefined) {
    queryBuilder = queryBuilder.where("dft.ID", payload.ID);
  }
  if (payload.Name_Lang_zhCN != undefined) {
    queryBuilder = queryBuilder.where(
      "df.Name_Lang_zhCN",
      "like",
      `%${payload.Name_Lang_zhCN}%`
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_FACTION_TEMPLATES_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_FACTION_TEMPLATES_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
