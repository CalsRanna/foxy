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
  event.reply("SEARCH_DBC_SPELLS_REPLY", dbc);
});
