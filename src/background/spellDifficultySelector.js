import { ipcMain } from "electron";

import {
  SEARCH_SPELL_DIFFICULTIES_FOR_SELECTOR,
  COUNT_SPELL_DIFFICULTIES_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_SPELL_DIFFICULTIES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .select([
      "dsd.*",
      "ds1.Name_Lang_zhCN as Spell1",
      "ds1.NameSubtext_Lang_zhCN as Subtext1",
      "ds2.Name_Lang_zhCN as Spell2",
      "ds2.NameSubtext_Lang_zhCN as Subtext2",
      "ds3.Name_Lang_zhCN as Spell3",
      "ds3.NameSubtext_Lang_zhCN as Subtext3",
      "ds4.Name_Lang_zhCN as Spell4",
      "ds4.NameSubtext_Lang_zhCN as Subtext4",
    ])
    .from("foxy.dbc_spell_difficulty as dsd")
    .leftJoin("foxy.dbc_spell as ds1", "dsd.DifficultySpellID_1", "ds1.ID")
    .leftJoin("foxy.dbc_spell as ds2", "dsd.DifficultySpellID_2", "ds2.ID")
    .leftJoin("foxy.dbc_spell as ds3", "dsd.DifficultySpellID_3", "ds3.ID")
    .leftJoin("foxy.dbc_spell as ds4", "dsd.DifficultySpellID_4", "ds4.ID");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("dsd.ID", payload.ID);
  }
  if (payload.Spell) {
    queryBuilder = queryBuilder.whereRaw(
      "concat(`ds1`.`Name_Lang_zhCN`,`ds2`.`Name_Lang_zhCN`,`ds3`.`Name_Lang_zhCN`,`ds4`.`Name_Lang_zhCN`) like ?",
      [`%${payload.Spell}%`]
    );
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_SPELL_DIFFICULTIES_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_SPELL_DIFFICULTIES_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_SPELL_DIFFICULTIES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .count("* as total")
    .from("foxy.dbc_spell_difficulty as dsd")
    .leftJoin("foxy.dbc_spell as ds1", "dsd.DifficultySpellID_1", "ds1.ID")
    .leftJoin("foxy.dbc_spell as ds2", "dsd.DifficultySpellID_2", "ds2.ID")
    .leftJoin("foxy.dbc_spell as ds3", "dsd.DifficultySpellID_3", "ds3.ID")
    .leftJoin("foxy.dbc_spell as ds4", "dsd.DifficultySpellID_4", "ds4.ID");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("dsd.ID", payload.ID);
  }
  if (payload.Spell) {
    queryBuilder = queryBuilder.whereRaw(
      "concat(`ds1`.`Name_Lang_zhCN`,`ds2`.`Name_Lang_zhCN`,`ds3`.`Name_Lang_zhCN`,`ds4`.`Name_Lang_zhCN`) like ?",
      [`%${payload.Spell}%`]
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_SPELL_DIFFICULTIES_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_SPELL_DIFFICULTIES_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
