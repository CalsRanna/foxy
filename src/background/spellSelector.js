import { ipcMain } from "electron";

import {
  SEARCH_SPELLS_FOR_SELECTOR,
  COUNT_SPELLS_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_SPELLS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex()
    .select([
      "ds.ID as ID",
      "Name_Lang_zhCN",
      "NameSubtext_Lang_zhCN",
      "Description_Lang_zhCN",
      "AuraDescription_Lang_zhCN",
      "DurationIndex",
      "EffectBasePoints_1",
      "EffectBasePoints_2",
      "EffectBasePoints_3",
      "EffectDieSides_1",
      "EffectDieSides_2",
      "EffectDieSides_3",
      "EffectAuraPeriod_1",
      "EffectAuraPeriod_2",
      "EffectAuraPeriod_3",
      "ProcCharges",
      "dsd.Duration as Duration",
    ])
    .from("foxy.dbc_spell as ds")
    .leftJoin("foxy.dbc_spell_duration as dsd", "ds.DurationIndex", "dsd.ID");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ds.ID", "like", `%${payload.ID}%`);
  }
  if (payload.Name) {
    queryBuilder = queryBuilder.where(
      "Name_Lang_zhCN",
      "like",
      `%${payload.Name}%`
    );
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_SPELLS_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_SPELLS_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_SPELLS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("foxy.dbc_spell as ds")
    .leftJoin("foxy.dbc_spell_duration as dsd", "ds.DurationIndex", "dsd.ID");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ds.ID", "like", `%${payload.ID}%`);
  }
  if (payload.Name) {
    queryBuilder = queryBuilder.where(
      "Name_Lang_zhCN",
      "like",
      `%${payload.Name}%`
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_SPELLS_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_SPELLS_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
