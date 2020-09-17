import { ipcMain } from "electron";

const DBC = require("warcrafty");

let searchDbcFactions = ipcMain.on("SEARCH_DBC_FACTIONS", event => {
  // let dbc = DBC.read("/Users/cals/FoxWoW/Server/Core/data/dbc/Faction.dbc");
  let dbc = DBC.read("D:\\FoxWOW\\Server\\Core\\data\\dbc\\Faction.dbc");
  event.reply("SEARCH_DBC_FACTIONS_REPLY", dbc);
});

let searchDbcFactionTemplates = ipcMain.on("SEARCH_DBC_FACTION_TEMPLATES", event => {
  // let dbc = DBC.read("/Users/cals/FoxWoW/Server/Core/data/dbc/FactionTemplate.dbc");
  let dbc = DBC.read("D:\\FoxWOW\\Server\\Core\\data\\dbc\\FactionTemplate.dbc");
  event.reply("SEARCH_DBC_FACTION_TEMPLATES_REPLY", dbc);
});

let searchDbcItemDisplayInfos = ipcMain.on("SEARCH_DBC_ITEM_DISPLAY_INFOS", event => {
  // let dbc = DBC.read("/Users/cals/FoxWoW/Server/Core/data/dbc/ItemDisplayInfo.dbc");
  let dbc = DBC.read("D:\\FoxWOW\\Server\\Core\\data\\dbc\\ItemDisplayInfo.dbc");
  event.reply("SEARCH_DBC_ITEM_DISPLAY_INFOS_REPLY", dbc);
});

export default {
  searchDbcFactions,
  searchDbcFactionTemplates,
  searchDbcItemDisplayInfos
};
