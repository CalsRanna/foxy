import { ipcMain } from "electron";

import {
  INIT_DBC_CONFIG,
  SEARCH_DBC_FACTIONS,
  SEARCH_DBC_FACTION_TEMPLATES,
  SEARCH_DBC_ITEM_DISPLAY_INFOS,
  SEARCH_DBC_ITEMS,
  SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS,
  SEARCH_DBC_SCALING_STAT_VALUES,
  SEARCH_DBC_SPELLS,
  EXPORT_SPELL_DBC,
  SEARCH_DBC_SPELL_DURATIONS,
  GLOBAL_NOTICE,
} from "../constants";

const DBC = require("warcrafty");
const { foxyKnex } = require("../libs/mysql");

let path;

ipcMain.on(INIT_DBC_CONFIG, (event, payload) => {
  path = payload.path;
  event.reply(INIT_DBC_CONFIG);
});

ipcMain.on(SEARCH_DBC_FACTIONS, (event) => {
  let dbc = DBC.read(`${path}/Faction.dbc`);
  event.reply(SEARCH_DBC_FACTIONS, dbc);
});

ipcMain.on(SEARCH_DBC_FACTION_TEMPLATES, (event) => {
  let dbc = DBC.read(`${path}/FactionTemplate.dbc`);
  event.reply(SEARCH_DBC_FACTION_TEMPLATES, dbc);
});

ipcMain.on(SEARCH_DBC_ITEMS, (event) => {
  let dbc = DBC.read(`${path}/Item.dbc`);
  event.reply(SEARCH_DBC_ITEMS, dbc);
});

ipcMain.on(SEARCH_DBC_ITEM_DISPLAY_INFOS, (event) => {
  let dbc = DBC.read(`${path}/ItemDisplayInfo.dbc`);
  event.reply(SEARCH_DBC_ITEM_DISPLAY_INFOS, dbc);
});

ipcMain.on(SEARCH_DBC_SPELLS, (event) => {
  // const os = require("os");
  // const isDevelopment = process.env.NODE_ENV !== "production";

  foxyKnex()
    .raw("select count(*) as total from `foxy`.`dbc_spell`")
    .then((rows) => {
      if (rows[0][0].total == 0) {
        let dbc = DBC.read(`${path}/Spell.dbc`);
        for (let i = 0; i < dbc.recordCount; i = i + 1000) {
          let chunk = [];
          let end = i + 1000;
          if (end < dbc.recordCount) {
            chunk = dbc.records.slice(i, end);
          } else {
            chunk = dbc.records.slice(i);
          }
          foxyKnex()
            .insert(chunk)
            .into("dbc_spell")
            .then(() => {});
        }
        event.reply(SEARCH_DBC_SPELLS);
      } else {
        event.reply(SEARCH_DBC_SPELLS);
      }
    });
});

ipcMain.on(EXPORT_SPELL_DBC, (event) => {
  foxyKnex()
    .select()
    .from("dbc_spell")
    .then((rows) => {
      try {
        DBC.write(`${path}/Spell.dbc`, rows);
        event.reply(EXPORT_SPELL_DBC);
      } catch (error) {
        event.reply(`${EXPORT_SPELL_DBC}_REJECT`);
        event.reply(GLOBAL_NOTICE, {
          category: "alert",
          type: "error",
          title: `${error.code}`,
          message: `${error.stack}`,
        });
      }
    })
    .catch((error) => {
      event.reply(GLOBAL_NOTICE, {
        category: "alert",
        type: "error",
        title: `${error.code}`,
        message: `${error.stack}`,
      });
    });
});

ipcMain.on(SEARCH_DBC_SPELL_DURATIONS, (event) => {
  let dbc = DBC.read(`${path}/SpellDuration.dbc`);
  event.reply(SEARCH_DBC_SPELL_DURATIONS, dbc);
});

ipcMain.on(SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS, (event) => {
  let dbc = DBC.read(`${path}/ScalingStatDistribution.dbc`);
  event.reply(SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS, dbc);
});

ipcMain.on(SEARCH_DBC_SCALING_STAT_VALUES, (event) => {
  let dbc = DBC.read(`${path}/ScalingStatValues.dbc`);
  event.reply(SEARCH_DBC_SCALING_STAT_VALUES, dbc);
});
