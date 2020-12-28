import { ipcMain } from "electron";

import {
  COUNT_QUEST_TEMPLATES,
  DESTROY_QUEST_TEMPLATE,
  FIND_QUEST_TEMPLATE,
  SEARCH_QUEST_TEMPLATES,
  STORE_QUEST_TEMPLATE,
  UPDATE_QUEST_TEMPLATE,
} from "../constants";

const { payloadToInsertSql, payloadToUpdateSql, payloadToDeleteSql } = require("../libs/util");
const connection = require("../libs/mysql");

ipcMain.on(SEARCH_QUEST_TEMPLATES, (event, payload) => {
  let sql =
    "select qt.ID, qt.LogTitle, qtl.Title, qt.LogDescription, qtl.Details, qt.QuestType, qt.QuestLevel, qt.MinLevel from quest_template as qt left join quest_template_locale as qtl on qt.ID=qtl.ID and qtl.locale='zhCN'";
  let where = "where 1=1";
  if (payload.id) {
    where = `${where} and qt.ID like '%${payload.id}%'`;
  }
  if (payload.title) {
    where = `${where} and (qt.LogTitle like '%${payload.title}%' or qtl.Title like '%${payload.title}%')`;
  }
  let page = payload.page;
  let offset = 0;
  if (page !== undefined) {
    offset = (page - 1) * 50;
  }
  let limit = `limit ${offset}, 50`;
  connection.query(`${sql} ${where} ${limit}`).then((results) => {
    event.reply(SEARCH_QUEST_TEMPLATES, results);
  });
});

ipcMain.on(COUNT_QUEST_TEMPLATES, (event, payload) => {
  let sql =
    "select count(*) as total from quest_template as qt left join quest_template_locale as qtl on qt.ID=qtl.ID and qtl.locale='zhCN'";
  let where = "where 1=1";
  if (payload.id) {
    where = `${where} and qt.ID like '%${payload.id}%'`;
  }
  if (payload.title) {
    where = `${where} and (qt.LogTitle like '%${payload.title}%' or qtl.Title like '%${payload.title}%')`;
  }
  connection.query(`${sql} ${where}`).then((results) => {
    event.reply(COUNT_QUEST_TEMPLATES, results[0].total);
  });
});

ipcMain.on(STORE_QUEST_TEMPLATE, (event, payload) => {
  let sql = payloadToInsertSql("quest_template", payload);

  connection.query(sql).then((results) => {
    event.reply(STORE_QUEST_TEMPLATE, results);
  });
});

ipcMain.on(FIND_QUEST_TEMPLATE, (event, payload) => {
  let sql = `select * from quest_template where ID=${payload.id}`;
  connection.query(sql).then((results) => {
    event.reply("FIND_QUEST_TEMPLATE", results[0]);
  });
});

ipcMain.on(UPDATE_QUEST_TEMPLATE, (event, payload) => {
  let sql = payloadToUpdateSql(payload);
  connection.query(sql).then((results) => {
    event.reply(UPDATE_QUEST_TEMPLATE, results);
  });
});

ipcMain.on(DESTROY_QUEST_TEMPLATE, (event, payload) => {
  let sql = payloadToDeleteSql(payload);
  connection.query(sql).then((results) => {
    event.reply(DESTROY_QUEST_TEMPLATE, results);
  });
});
