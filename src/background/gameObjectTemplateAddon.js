import { ipcMain } from "electron";
import {
  STORE_GAME_OBJECT_TEMPLATE_ADDON,
  FIND_GAME_OBJECT_TEMPLATE_ADDON,
  UPDATE_GAME_OBJECT_TEMPLATE_ADDON,
  GLOBAL_NOTICE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(STORE_GAME_OBJECT_TEMPLATE_ADDON, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("gameobject_template_addon");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_GAME_OBJECT_TEMPLATE_ADDON, rows);
      event.reply(GLOBAL_NOTICE, {
        category: "notification",
        title: "成功",
        message: "新建成功。",
        type: "success",
      });
    })
    .catch((error) => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(FIND_GAME_OBJECT_TEMPLATE_ADDON, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("gameobject_template_addon")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(
        FIND_GAME_OBJECT_TEMPLATE_ADDON,
        rows.length > 0 ? rows[0] : {}
      );
    })
    .catch((error) => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(UPDATE_GAME_OBJECT_TEMPLATE_ADDON, (event, payload) => {
  let queryBuilder = knex()
    .table("gameobject_template_addon")
    .where(payload.credential)
    .update(payload.gameObjectTemplateAddon);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_GAME_OBJECT_TEMPLATE_ADDON, rows);
      event.reply(GLOBAL_NOTICE, {
        category: "notification",
        title: "成功",
        message: "修改成功。",
        type: "success",
      });
    })
    .catch((error) => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});
