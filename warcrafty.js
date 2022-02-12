const { DBC } = require("warcrafty");

// DBC.read("/Users/cals/FoxWoW/Server/dbc/Achievement.dbc").then((dbc) => {
DBC.read("D:\\FoxWOW\\Server\\Core\\dbc\\Achievement_Category.dbc").then(
  (dbc) => {
    console.log(dbc);
  }
);
