import { ipcMain } from "electron";

const DBC = require("warcrafty");

let path;

ipcMain.on("INIT_DBC_CONFIG", (event, payload) => {
  path = payload.path;
});

ipcMain.on("SEARCH_DBC_FACTIONS", event => {
  let dbc = DBC.read(`${path}/Faction.dbc`);
  event.reply("SEARCH_DBC_FACTIONS_REPLY", dbc);
});

ipcMain.on("SEARCH_DBC_FACTION_TEMPLATES", event => {
  let dbc = DBC.read(`${path}/FactionTemplate.dbc`);
  event.reply("SEARCH_DBC_FACTION_TEMPLATES_REPLY", dbc);
});

ipcMain.on("SEARCH_DBC_ITEM_DISPLAY_INFOS", event => {
  let dbc = DBC.read(`${path}/ItemDisplayInfo.dbc`);
  event.reply("SEARCH_DBC_ITEM_DISPLAY_INFOS_REPLY", dbc);
});

ipcMain.on("SEARCH_DBC_SPELLS", event => {
  let dbc = DBC.read(`${path}/Spell.dbc`);
  // 一次性传递所有技能，占用内存太大，会导致GC失败，分多次传递数据
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
    event.reply("SEARCH_DBC_SPELLS_REPLY", chunk);
  }
});

ipcMain.on("SEARCH_DBC_SPELL_DURATIONS", event => {
  let dbc = DBC.read(`${path}/SpellDuration.dbc`);
  event.reply("SEARCH_DBC_SPELL_DURATIONS_REPLY", dbc);
});
