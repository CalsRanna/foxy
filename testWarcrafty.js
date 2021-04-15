const DBC = require("warcrafty");

DBC.read("D:/FoxWoW/Server/Core/datas/dbc/SpellCastTimes.dbc").then((dbc) => {
  console.log(dbc);
});
