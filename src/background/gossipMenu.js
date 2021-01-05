import { ipcMain } from "electron";
import { COUNT_GOSSIP_MENUS, GLOBAL_NOTICE, SEARCH_GOSSIP_MENUS } from "../constants";

const { knex } = require("../libs/mysql");

// 搜索满足条件的生物模板
ipcMain.on(SEARCH_GOSSIP_MENUS, (event, payload) => {
  let queryBuilder = knex()
    .select(["gm.*", "nt.text0_0", "nt.text0_1", "ntl.Text0_0", "ntl.Text0_1"])
    .from("gossip_menu as gm")
    .leftJoin("npc_text as nt", "gm.TextID", "nt.ID")
    .leftJoin("npc_text_locale as ntl", function() {
      this.on("gm.TextID", "=", "ntl.ID").andOn("ntl.Locale", "=", knex().raw("?", "zhCN"));
    });
  if (payload.MenuID) {
    queryBuilder = queryBuilder.where("gm.MenuID", "like", `%${payload.MenuID}%`);
  }
  if (payload.Text) {
    queryBuilder = queryBuilder.whereRaw(
      "concat(`nt`.`text0_0`,`nt`.`text0_1`,`ntl`.`Text0_0`,`ntl`.`Text0_1`) like ?",
      [`%${payload.Text}%`]
    );
  }
  queryBuilder = queryBuilder.limit(50).offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder.then(rows => {
    event.reply(SEARCH_GOSSIP_MENUS, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

// 计算满足条件的生物模板数量
ipcMain.on(COUNT_GOSSIP_MENUS, (event, payload) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("gossip_menu as gm")
    .leftJoin("npc_text as nt", "gm.TextID", "nt.ID")
    .leftJoin("npc_text_locale as ntl", function() {
      this.on("gm.TextID", "=", "ntl.ID").andOn("ntl.Locale", "=", knex().raw("?", "zhCN"));
    });
  if (payload.MenuID) {
    queryBuilder = queryBuilder.where("gm.MenuID", "like", `%${payload.MenuID}%`);
  }
  if (payload.Text) {
    queryBuilder = queryBuilder.whereRaw(
      "concat(`nt`.`text0_0`,`nt`.`text0_1`,`ntl`.`Text0_0`,`ntl`.`Text0_1`) like ?",
      [`%${payload.Text}%`]
    );
  }

  queryBuilder.then(rows => {
    event.reply(COUNT_GOSSIP_MENUS, rows[0].total);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});
