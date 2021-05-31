const DBC = require("warcrafty");

// DBC.read("/User/cals/FoxWoW/dbc/ItemSet.dbc").then(
DBC.read("D:\\FoxWOW\\Server\\Core\\datas\\dbc\\SpellIcon.dbc").then((dbc) => {
  console.log(dbc);
});
