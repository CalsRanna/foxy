import { ipcMain } from "electron";

import {
  COUNT_GAME_OBJECT_TEMPLATES,
  FIND_GAME_OBJECT_TEMPLATE,
  SEARCH_GAME_OBJECT_TEMPLATES,
  STORE_GAME_OBJECT_TEMPLATE,
  UPDATE_GAME_OBJECT_TEMPLATE
} from "../constants";
import { payloadToInsertSql, payloadToUpdateSql } from "../libs/util";

const connection = require("../libs/mysql");

ipcMain.on(SEARCH_GAME_OBJECT_TEMPLATES, (event, payload) => {
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
  connection.query(`${sql} ${where} ${limit}`).then(results => {
    event.reply("SEARCH_GAME_OBJECT_TEMPLATES_REPLY", results);
  });
});

ipcMain.on(COUNT_GAME_OBJECT_TEMPLATES, (event, payload) => {
  let sql =
    "select count(*) as total from gameobject_template as gt left join gameobject_template_locale as gtl on gt.entry=gtl.entry and gtl.locale='zhCN'";
  let where = "where 1=1";
  if (payload.entry) {
    where = `${where} and gt.entry like '%${payload.entry}%'`;
  }
  if (payload.name) {
    where = `${where} and (gt.name like '%${payload.name}%' or gtl.name like '%${payload.name}%')`;
  }
  connection.query(`${sql} ${where}`).then(results => {
    event.reply("COUNT_GAME_OBJECT_TEMPLATES_REPLY", results[0].total);
  });
});

ipcMain.on(FIND_GAME_OBJECT_TEMPLATE, (event, payload) => {
  let sql = `select * from gameobject_template where entry=${payload.entry}`;
  connection.query(sql).then(results => {
    event.reply("FIND_GAME_OBJECT_TEMPLATE", results[0]);
  });
});

ipcMain.on("GET_MAX_ENTRY_OF_GAME_OBJECT_TEMPLATE", (event, payload) => {
  let sql = "select entry from gameobject_template order by entry desc";
  connection.query(sql).then(results => {
    event.reply("GET_MAX_ENTRY_OF_GAME_OBJECT_TEMPLATE", results[0].entry);
    event.reply("GLOBAL_NOTICE", sql);
  });
});

ipcMain.on(STORE_GAME_OBJECT_TEMPLATE, (event, payload) => {
  let sql = payloadToInsertSql("gameobject_template", payload);

  connection.query(sql).then(results => {
    event.reply(STORE_GAME_OBJECT_TEMPLATE, results);
  });
});

ipcMain.on(UPDATE_GAME_OBJECT_TEMPLATE, (event, payload) => {
  let sql = payloadToUpdateSql("gameobject_template", payload, "entry");

  connection.query(sql).then(results => {
    event.reply(UPDATE_GAME_OBJECT_TEMPLATE, results);
  });
});
