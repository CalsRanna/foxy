import { ipcMain } from "electron";
import { COUNT_GOSSIP_MENUS, SEARCH_GOSSIP_MENUS } from "../constants";

const { knex } = require("../libs/mysql");

// 搜索满足条件的生物模板
ipcMain.on(SEARCH_GOSSIP_MENUS, (event, payload) => {
  let queryBuilder = knex()
    .select(["gm.*", "nt.text0_0", "nt.text0_1", "ntl.Text0_0", "ntl.Text0_1"])
    .from("gossip_menu as gm")
    .leftJoin("npc_text as nt", "gm.TextID", "nt.ID")
    .leftJoin("npc_text_locale as ntl", function() {
      this.on("gm.TextID", "=", "ntl.ID").andOn("ntl.locale", "=", knex().raw("?", "zhCN"));
    });
  if (payload.menuId) {
    queryBuilder = queryBuilder.where("gm.menuId", "like", `%${payload.menuId}%`);
  }
  if (payload.text) {
    queryBuilder = queryBuilder.where("gm.text", "like", `%${payload.text}%`);
  }
  queryBuilder = queryBuilder.limit(50).offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder.then(rows => {
    event.reply(SEARCH_GOSSIP_MENUS, rows);
  });
});

// 计算满足条件的生物模板数量
ipcMain.on(COUNT_GOSSIP_MENUS, (event, payload) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("gossip_menu as gm")
    .leftJoin("npc_text as nt", "gm.TextID", "nt.ID")
    .leftJoin("npc_text_locale as ntl", function() {
      this.on("gm.TextID", "=", "ntl.ID").andOn("ntl.locale", "=", knex().raw("?", "zhCN"));
    });
  if (payload.menuId) {
    queryBuilder = queryBuilder.where("gm.menuId", "like", `%${payload.menuId}%`);
  }
  if (payload.text) {
    queryBuilder = queryBuilder.where("gm.text", "like", `%${payload.text}%`);
  }

  queryBuilder.then(rows => {
    event.reply(COUNT_GOSSIP_MENUS, rows[0].total);
  });
});
