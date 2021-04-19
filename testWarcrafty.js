const DBC = require("warcrafty");

DBC.read("D:/FoxWoW/Server/Core/datas/dbc/Talent.dbc").then((dbc) => {
  console.log(dbc);
});
