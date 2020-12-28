import { ipcMain } from "electron";
import {
  COUNT_SMART_SCRIPTS,
  DESTROY_SMART_SCRIPT,
  FIND_SMART_SCRIPT,
  SEARCH_SMART_SCRIPTS,
  STORE_SMART_SCRIPT,
  UPDATE_SMART_SCRIPT,
} from "../constants";
import { payloadToDeleteSql, payloadToInsertSql, payloadToUpdateSql } from "../libs/util";

const connection = require("../libs/mysql");

ipcMain.on(SEARCH_SMART_SCRIPTS, (event, payload) => {
  let sql =
    "select ss.entryorguid, ss.source_type, ss.id, ss.link, ss.event_type, ss.action_type, ss.target_type,ss.comment from smart_scripts as ss";
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
  connection.query(`${sql} ${where} ${limit}`).then((results) => {
    event.reply(SEARCH_SMART_SCRIPTS, results);
  });
});

ipcMain.on(COUNT_SMART_SCRIPTS, (event, payload) => {
  let sql = "select count(*) as total from smart_scripts as ss";
  let where = "where 1=1";
  if (payload.entryorguid) {
    where = `${where} and ss.entryorguid like '%${payload.entryorguid}%'`;
  }
  if (payload.comment) {
    where = `${where} and ss.comment like '%${payload.comment}%'`;
  }
  connection.query(`${sql} ${where}`).then((results) => {
    event.reply(COUNT_SMART_SCRIPTS, results[0].total);
  });
});

ipcMain.on(STORE_SMART_SCRIPT, (event, payload) => {
  let sql = payloadToInsertSql(payload);

  connection.query(sql).then((results) => {
    event.reply(STORE_SMART_SCRIPT, results);
  });
});

ipcMain.on(FIND_SMART_SCRIPT, (event, payload) => {
  let sql = `select * from smart_scripts where entryorguid=${payload.entryorguid} and source_type=${payload.sourceType} and id=${payload.id} and link=${payload.link}`;
  connection.query(sql).then((results) => {
    event.reply(FIND_SMART_SCRIPT, results[0]);
  });
});

ipcMain.on(UPDATE_SMART_SCRIPT, (event, payload) => {
  let sql = payloadToUpdateSql(payload);

  connection.query(sql).then((results) => {
    event.reply(UPDATE_SMART_SCRIPT, results);
  });
});

ipcMain.on(DESTROY_SMART_SCRIPT, (event, payload) => {
  let sql = payloadToDeleteSql(payload);

  connection.query(sql).then((results) => {
    event.reply(DESTROY_SMART_SCRIPT, results);
  });
});
