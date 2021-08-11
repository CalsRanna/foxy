import { ipcMain } from "electron";

import {
  SEARCH_CREATURE_SPELL_DATAS_FOR_SELECTOR,
  COUNT_CREATURE_SPELL_DATAS_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_CREATURE_SPELL_DATAS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .select([
      "dcsd.ID as ID",
      "ds_1.Name_Lang_zhCN as Spells_1",
      "ds_2.Name_Lang_zhCN as Spells_2",
      "ds_3.Name_Lang_zhCN as Spells_3",
      "ds_4.Name_Lang_zhCN as Spells_4",
    ])
    .from("foxy.dbc_creature_spell_data as dcsd")
    .leftJoin("foxy.dbc_spell as ds_1", "dcsd.Spells_1", "ds_1.ID")
    .leftJoin("foxy.dbc_spell as ds_2", "dcsd.Spells_2", "ds_2.ID")
    .leftJoin("foxy.dbc_spell as ds_3", "dcsd.Spells_3", "ds_3.ID")
    .leftJoin("foxy.dbc_spell as ds_4", "dcsd.Spells_4", "ds_4.ID");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("dcsd.ID", payload.ID);
  }
  if (payload.Spell) {
    queryBuilder = queryBuilder
      .where("ds_1.Name_Lang_zhCN", "like", `%${payload.Spell}%`)
      .orWhere("ds_2.Name_Lang_zhCN", "like", `%${payload.Spell}%`)
      .orWhere("ds_3.Name_Lang_zhCN", "like", `%${payload.Spell}%`)
      .orWhere("ds_4.Name_Lang_zhCN", "like", `%${payload.Spell}%`);
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_CREATURE_SPELL_DATAS_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_CREATURE_SPELL_DATAS_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_CREATURE_SPELL_DATAS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .count("* as total")
    .from("foxy.dbc_creature_spell_data as dcsd")
    .leftJoin("foxy.dbc_spell as ds_1", "dcsd.Spells_1", "ds_1.ID")
    .leftJoin("foxy.dbc_spell as ds_2", "dcsd.Spells_2", "ds_2.ID")
    .leftJoin("foxy.dbc_spell as ds_3", "dcsd.Spells_3", "ds_3.ID")
    .leftJoin("foxy.dbc_spell as ds_4", "dcsd.Spells_4", "ds_4.ID");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("dcsd.ID", payload.ID);
  }
  if (payload.Spell) {
    queryBuilder = queryBuilder
      .where("ds_1.Name_Lang_zhCN", "like", `%${payload.Spell}%`)
      .orWhere("ds_2.Name_Lang_zhCN", "like", `%${payload.Spell}%`)
      .orWhere("ds_3.Name_Lang_zhCN", "like", `%${payload.Spell}%`)
      .orWhere("ds_4.Name_Lang_zhCN", "like", `%${payload.Spell}%`);
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_CREATURE_SPELL_DATAS_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_CREATURE_SPELL_DATAS_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
