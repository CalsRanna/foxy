const DBC = require("warcrafty");

DBC.read("D:/FoxWoW/Server/Core/datas/dbc/SpellRange.dbc").then((dbc) => {
  console.log(dbc);
});
