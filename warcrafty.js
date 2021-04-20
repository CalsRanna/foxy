const DBC = require("warcrafty");

DBC.read("/Users/cals/FoxWoW/dbc/TalentTab.dbc").then((dbc) => {
  console.log(dbc);
});
