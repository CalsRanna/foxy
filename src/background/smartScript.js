import { ipcMain } from "electron";

const mysql = require("mysql");
const connection = require("./mysql");
const { objectToSql } = require("../libs/util");

ipcMain.on("SEARCH_SMART_SCRIPTS", (event, payload) => {
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
  connection
    .query(`${sql} ${where} ${limit}`)
    .then(results => {
      event.reply("SEARCH_SMART_SCRIPTS_REPLY", results);
      event.reply("GLOBAL_MESSAGE", `${sql} ${where} ${limit}`);
    })
    .catch(error => {
      event.reply("GLOBAL_MESSAGE", error);
    });
});

ipcMain.on("COUNT_SMART_SCRIPTS", (event, payload) => {
  let sql = "select count(*) as total from smart_scripts as ss";
  let where = "where 1=1";
  if (payload.entryorguid) {
    where = `${where} and ss.entryorguid like '%${payload.entryorguid}%'`;
  }
  if (payload.comment) {
    where = `${where} and ss.comment like '%${payload.comment}%'`;
  }
  connection
    .query(`${sql} ${where}`)
    .then(results => {
      event.reply("COUNT_SMART_SCRIPTS_REPLY", results[0].total);
      event.reply("GLOBAL_MESSAGE", `${sql} ${where}`);
    })
    .catch(error => {
      event.reply("GLOBAL_MESSAGE", error);
    });
});
