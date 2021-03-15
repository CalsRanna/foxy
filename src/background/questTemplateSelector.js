import { ipcMain } from "electron";

import {
  SEARCH_QUEST_TEMPLATES_FOR_SELECTOR,
  COUNT_QUEST_TEMPLATES_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_QUEST_TEMPLATES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex()
    .select([
      "qt.ID",
      "qt.LogTitle",
      "qtl.Title",
      "qt.LogDescription",
      "qtl.Details",
      "qt.QuestLevel",
      "qt.MinLevel",
    ])
    .from("quest_template as qt")
    .leftJoin("quest_template_locale as qtl", function() {
      this.on("qt.ID", "=", "qtl.ID")
    });
  queryBuilder = queryBuilder.where('qtl.locale', 'zhCN');
  if (payload.id) {
    queryBuilder = queryBuilder.where("qt.ID", "like", `%${payload.id}%`);
  }
  if (payload.title) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("qt.LogTitle", "like", `%${payload.title}%`)
        .orWhere("qtl.Title", "like", `%${payload.title}%`)
    );
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_QUEST_TEMPLATES_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_QUEST_TEMPLATES_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_QUEST_TEMPLATES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("quest_template as qt")
    .leftJoin("quest_template_locale as qtl", function() {
      this.on("qt.ID", "=", "qtl.ID")
    });
  queryBuilder = queryBuilder.where('qtl.locale', 'zhCN');
  if (payload.id) {
    queryBuilder = queryBuilder.where("qt.ID", "like", `%${payload.id}%`);
  }
  if (payload.title) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("qt.LogTitle", "like", `%${payload.title}%`)
        .orWhere("qtl.Title", "like", `%${payload.title}%`)
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_QUEST_TEMPLATES_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_QUEST_TEMPLATES_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
