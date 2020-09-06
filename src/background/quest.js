import { ipcMain } from "electron";

const mysql = require("mysql2");

let createConnection = () =>
  mysql.createConnection({
    host: "127.0.0.1",
    user: "acore",
    password: "acore",
    database: "acore_world"
  });

let searchQuestTemplates = ipcMain.on("SEARCH_QUEST_TEMPLATES", (event, payload) => {
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
  let connection = createConnection();
  connection.connect();
  connection.query(`${sql} ${where} ${limit}`, (error, results) => {
    if (error) {
      event.reply("UPDATE_MESSAGE_REPLY", error);
    } else {
      event.reply("SEARCH_QUEST_TEMPLATES_REPLY", results);
      event.reply("UPDATE_MESSAGE_REPLY", `${sql} ${where} ${limit}`);
    }
  });
  connection.end();
});

let countQuestTemplates = ipcMain.on("COUNT_QUEST_TEMPLATES", (event, payload) => {
  let sql =
    "select count(*) as total from quest_template as qt left join quest_template_locale as qtl on qt.ID=qtl.ID and qtl.locale='zhCN'";
  let where = "where 1=1";
  if (payload.id) {
    where = `${where} and qt.ID like '%${payload.id}%'`;
  }
  if (payload.title) {
    where = `${where} and (qt.LogTitle like '%${payload.title}%' or qtl.Title like '%${payload.title}%')`;
  }
  let connection = createConnection();
  connection.connect();
  connection.query(`${sql} ${where}`, (error, results) => {
    if (error) {
      event.reply("UPDATE_MESSAGE_REPLY", error);
    } else {
      event.reply("COUNT_QUEST_TEMPLATES_REPLY", results[0].total);
      event.reply("UPDATE_MESSAGE_REPLY", `${sql} ${where}`);
    }
  });
  connection.end();
});
