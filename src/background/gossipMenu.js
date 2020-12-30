import { ipcMain } from "electron";

const mysql = require("mysql");
const connection = require("../libs/mysql");
const { objectToSql } = require("../libs/util");

// 搜索满足条件的生物模板
ipcMain.on("SEARCH_GOSSIP_MENUS", (event, payload) => {
  let sql =
    "select gm.*, nt.text0_0, nt.text0_1,ntl.Text0_0, ntl.Text0_1 from gossip_menu as gm left join npc_text as nt on gm.TextID=nt.ID left join npc_text_locale as ntl on gm.TextID=ntl.ID and ntl.locale='zhCN'";
  let where = "where 1=1";
  if (payload.menuId) {
    where = `${where} and gm.MenuID like '%${payload.menuId}%'`;
  }
  if (payload.text) {
    where = `${where} and (nt.text0_0 like '%${payload.text}%' or ntl.Text0_0 like '%${payload.text}%')`;
  }
  let page = payload.page;
  let offset = 0;
  if (page !== undefined) {
    offset = (page - 1) * 50;
  }
  let limit = `limit ${offset}, 50`;

  connection
    .query(`${sql} ${where} ${limit}`)
    .then((results) => {
      event.reply("SEARCH_GOSSIP_MENUS_REPLY", results);
      event.reply("GLOBAL_NOTICE", `${sql} ${where} ${limit}`);
    })
    .catch((error) => {
      event.reply("GLOBAL_NOTICE", error);
    });
});

// 计算满足条件的生物模板数量
ipcMain.on("COUNT_GOSSIP_MENUS", (event, payload) => {
  let sql =
    "select count(gm.MenuID) as total from gossip_menu as gm left join npc_text as nt on gm.TextID=nt.ID left join npc_text_locale as ntl on gm.TextID=ntl.ID and ntl.locale='zhCN'";
  let where = "where 1=1";
  if (payload.menuId) {
    where = `${where} and gm.MenuID like '%${payload.menuId}%'`;
  }
  if (payload.text) {
    where = `${where} and (nt.text0_0 like '%${payload.text}%' or ntl.Text0_0 like '%${payload.text}%')`;
  }

  connection
    .query(`${sql} ${where}`)
    .then((results) => {
      event.reply("COUNT_GOSSIP_MENUS_REPLY", results[0].total);
      event.reply("GLOBAL_NOTICE", `${sql} ${where}`);
    })
    .catch((error) => {
      event.reply("GLOBAL_NOTICE", error);
    });
});
