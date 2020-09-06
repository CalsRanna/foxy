import {ipcMain} from 'electron';

const mysql = require("mysql2");

let createConnection = () =>
  mysql.createConnection({
    host: "127.0.0.1",
    user: "acore",
    password: "acore",
    database: "acore_world"
  });

let searchSmartScripts = ipcMain.on("SEARCH_SMART_SCRIPTS", (event, payload) => {
  let sql =
    "select ss.entryorguid, ss.source_type, ss.id, ss.event_type, ss.action_type, ss.target_type,ss.comment from smart_scripts as ss";
  let where = "where 1=1";
  if (payload.entryorguid) {
    where = `${where} and ss.entryorguid like '%${payload.entryorguid}%'`;
  }
  if (payload.comment) {
    where = `${where} and ss.comment like '%${payload.comment}%'`;
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
      event.reply("SEARCH_SMART_SCRIPTS_REPLY", results);
      event.reply("UPDATE_MESSAGE_REPLY", `${sql} ${where} ${limit}`);
    }
  });
  connection.end();
});

let countSmartScripts = ipcMain.on("COUNT_SMART_SCRIPTS", (event, payload) => {
  let sql =
    "select count(*) as total from smart_scripts as ss";
  let where = "where 1=1";
  if (payload.entryorguid) {
    where = `${where} and ss.entryorguid like '%${payload.entryorguid}%'`;
  }
  if (payload.comment) {
    where = `${where} and ss.comment like '%${payload.comment}%'`;
  }
  let connection = createConnection();
  connection.connect();
  connection.query(`${sql} ${where}`, (error, results) => {
    if (error) {
      event.reply("UPDATE_MESSAGE_REPLY", error);
    } else {
      event.reply("COUNT_SMART_SCRIPTS_REPLY", results[0].total);
      event.reply("UPDATE_MESSAGE_REPLY", `${sql} ${where}`);
    }
  });
  connection.end();
});