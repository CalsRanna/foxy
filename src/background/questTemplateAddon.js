import { ipcMain } from "electron";

import {
  STORE_QUEST_TEMPLATE_ADDON,
  FIND_QUEST_TEMPLATE_ADDON,
  UPDATE_QUEST_TEMPLATE_ADDON,
  GLOBAL_NOTICE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(STORE_QUEST_TEMPLATE_ADDON, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("quest_template_addon");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_QUEST_TEMPLATE_ADDON, rows);
      event.reply(GLOBAL_NOTICE, {
        category: "notification",
        title: "成功",
        message: "新建成功。",
        type: "success",
      });
    })
    .catch((error) => {
      event.reply(`${STORE_QUEST_TEMPLATE_ADDON}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(FIND_QUEST_TEMPLATE_ADDON, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("quest_template_addon")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_QUEST_TEMPLATE_ADDON, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_QUEST_TEMPLATE_ADDON}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(UPDATE_QUEST_TEMPLATE_ADDON, (event, payload) => {
  let queryBuilder = knex()
    .table("quest_template_addon")
    .where(payload.credential)
    .update(payload.questTemplateAddon);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_QUEST_TEMPLATE_ADDON, rows);
      event.reply(GLOBAL_NOTICE, {
        category: "notification",
        title: "成功",
        message: "修改成功。",
        type: "success",
      });
    })
    .catch((error) => {
      event.reply(`${UPDATE_QUEST_TEMPLATE_ADDON}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});
