import {ipcMain} from 'electron';

const mysql = require("mysql2");

let createConnection = () =>
  mysql.createConnection({
    host: "127.0.0.1",
    user: "acore",
    password: "acore",
    database: "acore_world"
  });

let searchGameObjectTemplates = ipcMain.on("SEARCH_GAME_OBJECT_TEMPLATES", (event, payload) => {
  let sql =
    "select gt.entry, gt.displayId, gt.name, gtl.name as localeName, gt.type, gt.size from gameobject_template as gt left join gameobject_template_locale as gtl on gt.entry=gtl.entry and gtl.locale='zhCN'";
  let where = "where 1=1";
  if (payload.entry) {
    where = `${where} and gt.entry like '%${payload.entry}%'`;
  }
  if (payload.name) {
    where = `${where} and (gt.name like '%${payload.name}%' or gtl.name like '%${payload.name}%')`;
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
      event.reply("SEARCH_GAME_OBJECT_TEMPLATES_REPLY", results);
      event.reply("UPDATE_MESSAGE_REPLY", `${sql} ${where} ${limit}`);
    }
  });
  connection.end();
});