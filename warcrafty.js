const DBC = require("warcrafty");

DBC.read("/Users/cals/FoxWoW/Server/dbc/Faction.dbc").then((dbc) => {
  // DBC.read("D:\\FoxWOW\\Server\\Core\\datas\\dbc\\ChrRaces.dbc").then((dbc) => {
  console.log(dbc);
});
