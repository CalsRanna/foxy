const DBC = require("warcrafty");

DBC.read("/Users/cals/FoxWoW/dbc/ItemSet.dbc").then((dbc) => {
  console.log(dbc);
});
