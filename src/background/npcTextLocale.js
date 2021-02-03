import { ipcMain } from "electron";
import {
  SEARCH_NPC_TEXT_LOCALES,
  STORE_NPC_TEXT_LOCALES,
  GLOBAL_NOTICE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_NPC_TEXT_LOCALES, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("npc_text_locale")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_NPC_TEXT_LOCALES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_NPC_TEXT_LOCALES}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(STORE_NPC_TEXT_LOCALES, (event, payload) => {
  let deleteQueryBuilder = knex()
    .table("npc_text_locale")
    .where("ID", payload[0].ID)
    .delete();
  let insertQueryBuilder = knex()
    .insert(payload)
    .into("npc_text_locale");

  deleteQueryBuilder
    .then(() => {
      insertQueryBuilder
        .then((rows) => {
          event.reply(STORE_NPC_TEXT_LOCALES, rows);
          event.reply(GLOBAL_NOTICE, {
            type: "success",
            category: "notification",
            title: "成功",
            message: `保存成功。`,
          });
        })
        .catch((error) => {
          event.reply(`${STORE_NPC_TEXT_LOCALES}_REJECT`, error);
        })
        .finally(() => {
          event.reply(GLOBAL_NOTICE, {
            category: "message",
            message: queryBuilder.toString(),
          });
        });
    })
    .catch((error) => {
      event.reply(`${STORE_NPC_TEXT_LOCALES}_REJECT`, error);
    });
});
