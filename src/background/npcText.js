import { ipcMain } from "electron";
import {
  STORE_NPC_TEXT,
  FIND_NPC_TEXT,
  UPDATE_NPC_TEXT,
  GLOBAL_NOTICE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(STORE_NPC_TEXT, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("npc_text");

  queryBuilder.then((rows) => {
    event.reply(STORE_NPC_TEXT, rows);
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

ipcMain.on(FIND_NPC_TEXT, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("npc_text")
    .where(payload);

  queryBuilder.then((rows) => {
    event.reply(FIND_NPC_TEXT, rows.length > 0 ? rows[0] : {});
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString(),
    });
  });
});

ipcMain.on(UPDATE_NPC_TEXT, (event, payload) => {
  let queryBuilder = knex()
    .table("npc_text")
    .where("ID", payload.credential.ID)
    .update(payload.npcText);

  queryBuilder.then((rows) => {
    event.reply(UPDATE_NPC_TEXT, rows);
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
