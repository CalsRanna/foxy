import { ipcMain } from "electron";
import {
  COPY_GOSSIP_MENU,
  COUNT_GOSSIP_MENUS,
  CREATE_GOSSIP_MENU,
  DESTROY_GOSSIP_MENU,
  FIND_GOSSIP_MENU,
  GLOBAL_NOTICE,
  SEARCH_GOSSIP_MENUS,
  STORE_GOSSIP_MENU,
  UPDATE_GOSSIP_MENU,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_GOSSIP_MENUS, (event, payload) => {
  let queryBuilder = knex()
    .select(["gm.*", "nt.text0_0", "nt.text0_1", "ntl.Text0_0", "ntl.Text0_1"])
    .from("gossip_menu as gm")
    .leftJoin("npc_text as nt", "gm.TextID", "nt.ID")
    .leftJoin("npc_text_locale as ntl", function () {
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

  queryBuilder.then((rows) => {
    event.reply(SEARCH_GOSSIP_MENUS, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString(),
    });
  });
});

ipcMain.on(COUNT_GOSSIP_MENUS, (event, payload) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("gossip_menu as gm")
    .leftJoin("npc_text as nt", "gm.TextID", "nt.ID")
    .leftJoin("npc_text_locale as ntl", function () {
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

  queryBuilder.then((rows) => {
    event.reply(COUNT_GOSSIP_MENUS, rows[0].total);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString(),
    });
  });
});

ipcMain.on(STORE_GOSSIP_MENU, (event, payload) => {
  let queryBuilder = knex().insert(payload).into("gossip_menu");

  queryBuilder.then((rows) => {
    event.reply(COUNT_GOSSIP_MENUS, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "notification",
      title: "成功",
      message: "新建成功。",
      type: "success",
    });
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString(),
    });
  });
});

ipcMain.on(FIND_GOSSIP_MENU, (event, payload) => {
  let queryBuilder = knex().select().from("gossip_menu").where(payload);

  queryBuilder.then((rows) => {
    event.reply(FIND_GOSSIP_MENU, rows.length > 0 ? rows[0] : {});
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString(),
    });
  });
});

ipcMain.on(UPDATE_GOSSIP_MENU, (event, payload) => {
  let queryBuilder = knex()
    .table("gossip_menu")
    .where("MenuID", payload.credential.MenuID)
    .update(payload.gossipMenu);

  queryBuilder.then(rows => {
    event.reply(UPDATE_GOSSIP_MENU, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "notification",
      title: "成功",
      message: "修改成功。",
      type: "success"
    });
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

ipcMain.on(DESTROY_GOSSIP_MENU, (event, payload) => {
  let queryBuilder = knex()
    .table("gossip_menu")
    .where(payload)
    .delete();

  queryBuilder.then(rows => {
    event.reply(DESTROY_GOSSIP_MENU, rows);
    event.reply("GLOBAL_NOTICE", {
      category: "notification",
      title: "成功",
      message: "删除成功。",
      type: "success"
    });
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

ipcMain.on(CREATE_GOSSIP_MENU, (event, payload) => {
  let queryBuilder = knex()
    .select("MenuID")
    .from("gossip_menu")
    .orderBy("MenuID", "desc");

  queryBuilder.then(rows => {
    event.reply(CREATE_GOSSIP_MENU, {
      MenuID: rows[0].MenuID + 1
    });
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

ipcMain.on(COPY_GOSSIP_MENU, (event, payload) => {
  let MenuID = undefined;
  let gossipMenu = undefined;

  let menuIdQueryBuilder = knex()
    .select("MenuID")
    .from("gossip_menu")
    .orderBy("MenuID", "desc");
  let findGossipMenuQueryBuilder = knex()
    .select()
    .from("gossip_menu")
    .where(payload);
  Promise.all([
    menuIdQueryBuilder.then(rows => {
      MenuID = rows[0].MenuID;
    }),
    findGossipMenuQueryBuilder.then(rows => {
      gossipMenu = rows.length > 0 ? rows[0] : {};
    })
  ]).then(() => {
    gossipMenu.MenuID = MenuID + 1;
    let queryBuilder = knex()
      .insert(gossipMenu)
      .into("gossip_menu");
    queryBuilder.then(rows => {
      event.reply(COPY_GOSSIP_MENU, rows);
      event.reply(GLOBAL_NOTICE, {
        type: "success",
        category: "notification",
        title: "成功",
        message: `复制成功，新的对话 MenuID 为 ${MenuID + 1}。`
      });
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString()
      });
    });
  });
});
