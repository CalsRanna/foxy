import { ipcMain } from "electron";
import {
  SEARCH_GOSSIP_MENU_OPTIONS,
  STORE_GOSSIP_MENU_OPTION,
  FIND_GOSSIP_MENU_OPTION,
  UPDATE_GOSSIP_MENU_OPTION,
  DESTROY_GOSSIP_MENU_OPTION,
  CREATE_GOSSIP_MENU_OPTION,
  COPY_GOSSIP_MENU_OPTION,
  GLOBAL_NOTICE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_GOSSIP_MENU_OPTIONS, (event, payload) => {
  let queryBuilder = knex()
    .select(["gmo.*", "gmol.OptionText as localeOptionText"])
    .from("gossip_menu_option as gmo")
    .leftJoin("gossip_menu_option_locale as gmol", function() {
      this.on("gmo.MenuID", "=", "gmol.MenuID")
        .andOn("gmo.OptionID", "=", "gmol.OptionID")
        .andOn("gmol.Locale", "=", knex().raw("?", "zhCN"));
    })
    .where("gmo.MenuID", payload.MenuID);

  queryBuilder.then((rows) => {
    event.reply(SEARCH_GOSSIP_MENU_OPTIONS, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString(),
    });
  });
});

ipcMain.on(STORE_GOSSIP_MENU_OPTION, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("gossip_menu_option");

  queryBuilder.then((rows) => {
    event.reply(STORE_GOSSIP_MENU_OPTION, rows);
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

ipcMain.on(FIND_GOSSIP_MENU_OPTION, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("gossip_menu_option")
    .where(payload);

  queryBuilder.then((rows) => {
    event.reply(FIND_GOSSIP_MENU_OPTION, rows.length > 0 ? rows[0] : {});
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString(),
    });
  });
});

ipcMain.on(UPDATE_GOSSIP_MENU_OPTION, (event, payload) => {
  let queryBuilder = knex()
    .table("gossip_menu_option")
    .where("MenuID", payload.credential.MenuID)
    .where("OptionID", payload.credential.OptionID)
    .update(payload.gossipMenuOption);

  queryBuilder.then((rows) => {
    event.reply(UPDATE_GOSSIP_MENU_OPTION, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "notification",
      title: "成功",
      message: "修改成功。",
      type: "success",
    });
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString(),
    });
  });
});

ipcMain.on(DESTROY_GOSSIP_MENU_OPTION, (event, payload) => {
  let queryBuilder = knex()
    .table("gossip_menu_option")
    .where(payload)
    .delete();

  queryBuilder.then((rows) => {
    event.reply(DESTROY_GOSSIP_MENU_OPTION, rows);
    event.reply("GLOBAL_NOTICE", {
      category: "notification",
      title: "成功",
      message: "删除成功。",
      type: "success",
    });
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString(),
    });
  });
});

ipcMain.on(CREATE_GOSSIP_MENU_OPTION, (event, payload) => {
  let queryBuilder = knex()
    .select("OptionID")
    .from("gossip_menu_option")
    .where(payload)
    .orderBy("OptionID", "desc");

  queryBuilder.then((rows) => {
    event.reply(CREATE_GOSSIP_MENU_OPTION, {
      MenuID: payload.MenuID,
      OptionID: rows.length > 0 ? rows[0].OptionID + 1 : 0,
    });
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString(),
    });
  });
});

ipcMain.on(COPY_GOSSIP_MENU_OPTION, (event, payload) => {
  let OptionID = undefined;
  let gossipMenuOption = undefined;

  let optionIdQueryBuilder = knex()
    .select("OptionID")
    .from("gossip_menu_option")
    .where("MenuID", payload.MenuID)
    .orderBy("OptionID", "desc");
  let findGossipMenuOptionQueryBuilder = knex()
    .select()
    .from("gossip_menu_option")
    .where(payload);
  Promise.all([
    optionIdQueryBuilder.then((rows) => {
      OptionID = rows[0].OptionID;
    }),
    findGossipMenuOptionQueryBuilder.then((rows) => {
      gossipMenuOption = rows.length > 0 ? rows[0] : {};
    }),
  ]).then(() => {
    gossipMenuOption.OptionID = OptionID + 1;
    let queryBuilder = knex()
      .insert(gossipMenuOption)
      .into("gossip_menu_option");
    queryBuilder.then((rows) => {
      event.reply(COPY_GOSSIP_MENU_OPTION, rows);
      event.reply(GLOBAL_NOTICE, {
        type: "success",
        category: "notification",
        title: "成功",
        message: `复制成功，新的对话选项 OptionID 为 ${OptionID + 1}。`,
      });
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
  });
});
