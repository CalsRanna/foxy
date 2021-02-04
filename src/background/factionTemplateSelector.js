import { ipcMain } from "electron";

import {
  SEARCH_FACTION_TEMPLATES_FOR_SELECTOR,
  COUNT_FACTION_TEMPLATES_FOR_SELECTOR,
  GLOBAL_NOTICE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_FACTION_TEMPLATES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex()
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
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_FACTION_TEMPLATES_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_FACTION_TEMPLATES_FOR_SELECTOR}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(COUNT_FACTION_TEMPLATES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex()
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
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});
