import { ipcMain } from "electron";
import {
  INIT_DBC_CONFIG,
  SEARCH_DBC_FACTIONS,
  SEARCH_DBC_FACTION_TEMPLATES,
  SEARCH_DBC_ITEM_DISPLAY_INFOS,
  SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS,
  SEARCH_DBC_SCALING_STAT_VALUES,
  SEARCH_DBC_SPELLS,
  SEARCH_DBC_SPELL_DURATIONS
} from "../constants";

const DBC = require("warcrafty");

let path;

ipcMain.on(INIT_DBC_CONFIG, (event, payload) => {
  path = payload.path;
  event.reply(INIT_DBC_CONFIG);
});

ipcMain.on(SEARCH_DBC_FACTIONS, event => {
  let dbc = DBC.read(`${path}/Faction.dbc`);
  event.reply(SEARCH_DBC_FACTIONS, dbc);
});

ipcMain.on(SEARCH_DBC_FACTION_TEMPLATES, event => {
  let dbc = DBC.read(`${path}/FactionTemplate.dbc`);
  event.reply(SEARCH_DBC_FACTION_TEMPLATES, dbc);
});

ipcMain.on(SEARCH_DBC_ITEM_DISPLAY_INFOS, event => {
  let dbc = DBC.read(`${path}/ItemDisplayInfo.dbc`);
  event.reply(SEARCH_DBC_ITEM_DISPLAY_INFOS, dbc);
});

ipcMain.on(SEARCH_DBC_SPELLS, event => {
  const os = require("os");
  const isDevelopment = process.env.NODE_ENV !== "production";

  if (!(isDevelopment && os < 8568436736)) {
    let dbc = DBC.read(`${path}/Spell.dbc`);
    // 一次性传递所有技能，占用内存太大，会导致GC失败，分多次传递数据, 已证明无效
    for (let i = 0; i < dbc.recordCount; i = i + 100) {
      let chunk = {
        signature: dbc.signature,
        recordCount: dbc.recordCount,
        fieldCount: dbc.fieldCount,
        recordSize: dbc.recordSize,
        stringBlockSize: dbc.stringBlockSize,
        stringBlockOffset: dbc.stringBlockOffset,
        records: []
      };
      let end = i + 100;
      if (end < dbc.recordCount) {
        chunk.records = dbc.records.slice(i, end);
      } else {
        chunk.records = dbc.records.slice(i);
      }
      event.reply(SEARCH_DBC_SPELLS, chunk);
    }
  }
});

ipcMain.on(SEARCH_DBC_SPELL_DURATIONS, event => {
  let dbc = DBC.read(`${path}/SpellDuration.dbc`);
  event.reply(SEARCH_DBC_SPELL_DURATIONS, dbc);
});

ipcMain.on(SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS, event => {
  let dbc = DBC.read(`${path}/ScalingStatDistribution.dbc`);
  event.reply(SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS, dbc);
});

ipcMain.on(SEARCH_DBC_SCALING_STAT_VALUES, event => {
  let dbc = DBC.read(`${path}/ScalingStatValues.dbc`);
  event.reply(SEARCH_DBC_SCALING_STAT_VALUES, dbc);
});
