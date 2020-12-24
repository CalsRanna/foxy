import { ipcMain } from "electron";

const mysql = require("mysql");
const connection = require("../libs/mysql");
const { objectToSql } = require("../libs/util");

ipcMain.on("SEARCH_ITEM_TEMPLATES", (event, payload) => {
  let sql =
    "select it.entry, it.name, itl.Name as localeName, it.Quality, it.displayid, it.class, it.subclass, it.InventoryType, it.ItemLevel, it.RequiredLevel from item_template as it left join item_template_locale as itl on it.entry=itl.ID and itl.locale='zhCN'";
  let where = "where 1=1";
  if (payload.entry !== undefined) {
    where = `${where} and it.entry like '%${payload.entry}%'`;
  }
  if (payload.name !== undefined) {
    where = `${where} and (it.name like '%${payload.name}%' or itl.Name like '%${payload.name}%')`;
  }
  if (payload.class !== undefined) {
    where = `${where} and (it.class = ${payload.class})`;
  }
  if (payload.subclass !== undefined) {
    where = `${where} and (it.subclass = ${payload.subclass})`;
  }
  if (payload.InventoryType !== undefined) {
    where = `${where} and (it.InventoryType = ${payload.InventoryType})`;
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
      event.reply("SEARCH_ITEM_TEMPLATES_REPLY", results);
      event.reply("GLOBAL_NOTICE", `${sql} ${where} ${limit}`);
    })
    .catch(error => {
      event.reply("GLOBAL_NOTICE", error);
    });
});

ipcMain.on("COUNT_ITEM_TEMPLATES", (event, payload) => {
  let sql =
    "select count(*) as total from item_template as it left join item_template_locale as itl on it.entry=itl.ID and itl.locale='zhCN'";
  let where = "where 1=1";
  if (payload.entry !== undefined) {
    where = `${where} and it.entry like '%${payload.entry}%'`;
  }
  if (payload.name !== undefined) {
    where = `${where} and (it.name like '%${payload.name}%' or itl.Name like '%${payload.name}%')`;
  }
  if (payload.class !== undefined) {
    where = `${where} and (it.class = ${payload.class})`;
  }
  if (payload.subclass !== undefined) {
    where = `${where} and (it.subclass = ${payload.subclass})`;
  }
  if (payload.InventoryType !== undefined) {
    where = `${where} and (it.InventoryType = ${payload.InventoryType})`;
  }
  connection
    .query(`${sql} ${where}`)
    .then(results => {
      event.reply("COUNT_ITEM_TEMPLATES_REPLY", results[0].total);
      event.reply("GLOBAL_NOTICE", `${sql} ${where}`);
    })
    .catch(error => {
      event.reply("GLOBAL_NOTICE", error);
    });
});

ipcMain.on("FIND_ITEM_TEMPLATE", (event, payload) => {
  let sql = `select * from item_template where entry = ${payload.entry}`;
  connection
    .query(`${sql}`)
    .then(results => {
      event.reply("FIND_ITEM_TEMPLATE_REPLY", results[0]);
      event.reply("GLOBAL_NOTICE", `${sql}`);
    })
    .catch(error => {
      event.reply("GLOBAL_NOTICE", error);
    });
});

ipcMain.on("ITEM_TEMPLATE_MAX_ID", event => {
  let sql = "select entry from item_template order by 'entry' desc";
  connection
    .query(`${sql}`)
    .then(results => {
      event.reply("ITEM_TEMPLATE_MAX_ID_REPLY", results[0].entry);
      event.reply("GLOBAL_NOTICE", `${sql}`);
    })
    .catch(error => {
      event.reply("GLOBAL_NOTICE", error);
    });
});

ipcMain.on("SEARCH_ITEM_TEMPLATE_LOCALES", (event, payload) => {
  let sql = `select * from item_template_locale where ID = ${payload.ID}`;
  connection
    .query(`${sql}`)
    .then(results => {
      event.reply("SEARCH_ITEM_TEMPLATE_LOCALES_REPLY", results);
      event.reply("GLOBAL_NOTICE", `${sql}`);
    })
    .catch(error => {
      event.reply("GLOBAL_NOTICE", error);
    });
});
