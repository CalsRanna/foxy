import { ipcMain } from "electron";
import {
  STORE_CREATURE_TEMPLATE_ADDON,
  FIND_CREATURE_TEMPLATE_ADDON,
  UPDATE_CREATURE_TEMPLATE_ADDON,
  GLOBAL_NOTICE
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(STORE_CREATURE_TEMPLATE_ADDON, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("creature_template_addon");

  queryBuilder
    .then(rows => {
      event.reply(STORE_CREATURE_TEMPLATE_ADDON, rows);
      event.reply(GLOBAL_NOTICE, {
        category: "notification",
        title: "成功",
        message: "新建成功。",
        type: "success"
      });
    })
    .catch(error => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString()
      });
    });
});

ipcMain.on(FIND_CREATURE_TEMPLATE_ADDON, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("creature_template_addon")
    .where(payload);

  queryBuilder
    .then(rows => {
      event.reply(FIND_CREATURE_TEMPLATE_ADDON, rows.length > 0 ? rows[0] : {});
    })
    .catch(error => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString()
      });
    });
});

ipcMain.on(UPDATE_CREATURE_TEMPLATE_ADDON, (event, payload) => {
  let queryBuilder = knex()
    .table("creature_template_addon")
    .where(payload.credential)
    .update(payload.creatureTemplateAddon);

  queryBuilder
    .then(rows => {
      event.reply(UPDATE_CREATURE_TEMPLATE_ADDON, rows);
      event.reply(GLOBAL_NOTICE, {
        category: "notification",
        title: "成功",
        message: "修改成功。",
        type: "success"
      });
    })
    .catch(error => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString()
      });
    });
});
