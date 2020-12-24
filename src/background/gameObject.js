import { ipcMain } from "electron";

const mysql = require("mysql");
const connection = require("./mysql");
const { objectToSql } = require("../libs/util");

ipcMain.on("SEARCH_GAME_OBJECT_TEMPLATES", (event, payload) => {
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
  connection
    .query(`${sql} ${where} ${limit}`)
    .then(results => {
      event.reply("SEARCH_GAME_OBJECT_TEMPLATES_REPLY", results);
      event.reply("GLOBAL_MESSAGE", `${sql} ${where} ${limit}`);
    })
    .catch(error => {
      event.reply("GLOBAL_MESSAGE", error);
    });
});

ipcMain.on("COUNT_GAME_OBJECT_TEMPLATES", (event, payload) => {
  let sql =
    "select count(*) as total from gameobject_template as gt left join gameobject_template_locale as gtl on gt.entry=gtl.entry and gtl.locale='zhCN'";
  let where = "where 1=1";
  if (payload.entry) {
    where = `${where} and gt.entry like '%${payload.entry}%'`;
  }
  if (payload.name) {
    where = `${where} and (gt.name like '%${payload.name}%' or gtl.name like '%${payload.name}%')`;
  }
  connection
    .query(`${sql} ${where}`)
    .then(results => {
      event.reply("COUNT_GAME_OBJECT_TEMPLATES_REPLY", results[0].total);
      event.reply("GLOBAL_MESSAGE", `${sql} ${where}`);
    })
    .catch(error => {
      event.reply("GLOBAL_MESSAGE", error);
    });
});

ipcMain.on("FIND_GAME_OBJECT_TEMPLATE", (event, payload) => {
  let sql = `select * from gameobject_template where entry=${payload.entry}`;
  connection.query(sql).then((results) => {
    event.reply('FIND_GAME_OBJECT_TEMPLATE', results[0]);
    event.reply("GLOBAL_MESSAGE", sql);
  })
})

ipcMain.on('GET_MAX_ENTRY_OF_GAME_OBJECT_TEMPLATE', (event, payload) => {
  let sql = 'select entry from gameobject_template order by entry desc';
  connection.query(sql).then((results) => {
    event.reply('GET_MAX_ENTRY_OF_GAME_OBJECT_TEMPLATE', results[0].entry);
    event.reply("GLOBAL_MESSAGE", sql);
  })
})
