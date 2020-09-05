import { ipcMain } from "electron";
// import { mysql } from "mysql2";
const mysql = require("mysql2");

let createConnection = () =>
  mysql.createConnection({
    host: "127.0.0.1",
    user: "acore",
    password: "acore",
    database: "acore_world"
  });

let searchItemTemplates = ipcMain.on("SEARCH_ITEM_TEMPLATES", (event, payload) => {
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
  let connection = createConnection();
  connection.connect();
  console.log(`${sql} ${where} ${limit}`);
  connection.query(`${sql} ${where} ${limit}`, (error, results) => {
    if (error) {
      console.log(error);
    } else {
      event.reply("SEARCH_ITEM_TEMPLATES_REPLY", results);
    }
  });
  connection.end();
});

let countItemTemplates = ipcMain.on("COUNT_ITEM_TEMPLATES", (event, payload) => {
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
  let connection = createConnection();
  connection.connect();
  connection.query(`${sql} ${where}`, (error, results) => {
    if (error) {
      console.log(error);
    } else {
      event.reply("COUNT_ITEM_TEMPLATES_REPLY", results[0].total);
    }
  });
  connection.end();
});

let findItemTemplate = ipcMain.on("FIND_ITEM_TEMPLATE", (event, payload) => {
  let sql = `select * from item_template where entry = ${payload.entry}`;
  let connection = createConnection();
  connection.connect();
  connection.query(sql, (error, results) => {
    if (error) {
      console.log(error);
    } else {
      event.reply("FIND_ITEM_TEMPLATE_REPLY", results[0]);
    }
  });
  connection.end();
});

let maxIdOfItemTemplate = ipcMain.on("ITEM_TEMPLATE_MAX_ID", event => {
  let sql = "select entry from item_template order by 'entry' desc";
  let connection = createConnection();
  connection.connect();
  connection.query(sql, (error, results) => {
    if (error) {
      console.log(error);
    } else {
      event.reply("ITEM_TEMPLATE_MAX_ID_REPLY", results[0].entry);
    }
  });
  connection.end();
});

let searchItemTemplateLocales = ipcMain.on("SEARCH_ITEM_TEMPLATE_LOCALES", (event, payload) => {
  let sql = `select * from item_template_locale where ID = ${payload.ID}`;
  let connection = createConnection();
  connection.connect();
  connection.query(sql, (error, results) => {
    if (error) {
      console.log(error);
    } else {
      event.reply("SEARCH_ITEM_TEMPLATE_LOCALES_REPLY", results);
    }
  });
  connection.end();
});

export default {
  searchItemTemplates,
  countItemTemplates,
  findItemTemplate,
  maxIdOfItemTemplate,
  searchItemTemplateLocales
};
