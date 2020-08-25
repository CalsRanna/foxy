import { ipcMain } from "electron";
// import { mysql } from "mysql2";
const mysql = require("mysql2");

let createConnection = () =>
  mysql.createConnection({
    host: "127.0.0.1",
    user: "acore",
    password: "acore",
    database: "acore_world",
  });

let searchCreatureTemplates = ipcMain.on(
  "SEARCH_CREATURE_TEMPLATES",
  (event, payload) => {
    let sql =
      "select ct.entry, ct.name, ctl.Name as localeName, ct.subname, ctl.Title as localeTitle, ct.minlevel, ct.maxlevel from creature_template as ct left join creature_template_locale as ctl on ct.entry=ctl.entry and ctl.locale='zhCN'";
    let where = "where 1=1";
    if (payload.entry) {
      where = `${where} and ct.entry like '%${payload.entry}%'`;
    }
    if (payload.name) {
      where = `${where} and (ct.name like '%${payload.name}%' or ctl.Name like '%${payload.name}%')`;
    }
    if (payload.subname) {
      where = `${where} and (ct.subname like '%${payload.subname}%' or ctl.Title like '%${payload.subname}%')`;
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
        console.log(error);
      } else {
        event.reply("SEARCH_CREATURE_TEMPLATES_REPLY", results);
      }
    });
    connection.end();
  }
);

let countCreatureTemplates = ipcMain.on(
  "COUNT_CREATURE_TEMPLATES",
  (event, payload) => {
    let sql =
      "select count(*) as total from creature_template as ct left join creature_template_locale as ctl on ct.entry=ctl.entry and ctl.locale='zhCN'";
    let where = "where 1=1";
    if (payload.entry) {
      where = `${where} and ct.entry like '%${payload.entry}%'`;
    }
    if (payload.name) {
      where = `${where} and (ct.name like '%${payload.name}%' or ctl.Name like '%${payload.name}%')`;
    }
    if (payload.subname) {
      where = `${where} and (ct.subname like '%${payload.subname}%' or ctl.Title like '%${payload.subname}%')`;
    }
    let connection = createConnection();
    connection.connect();
    connection.query(`${sql} ${where}`, (error, results) => {
      if (error) {
        console.log(error);
      } else {
        event.reply("COUNT_CREATURE_TEMPLATES_REPLY", results[0].total);
      }
    });
    connection.end();
  }
);

let findCreatureTemplate = ipcMain.on("FIND_CREATURE_TEMPLATE", (event, payload) => {
  let sql = `select * from creature_template where entry = ${payload.entry}`;
  let connection = createConnection();
  connection.connect();
  connection.query(sql, (error, results) => {
    if (error) {
      console.log(error);
    } else {
      event.reply("FIND_CREATURE_TEMPLATE_REPLY", results[0]);
    }
  });
  connection.end();
});

let maxIdOfCreatureTemplate = ipcMain.on("CREATURE_TEMPLATE_MAX_ID", (event, payload) => {
  let sql = "select entry from creature_template order by 'entry' desc";
  let connection = createConnection();
  connection.connect();
  connection.query(sql, (error, results) => {
    if (error) {
      console.log(error);
    } else {
      event.reply("CREATURE_TEMPLATE_MAX_ID_REPLY", results[0].entry);
    }
  });
  connection.end();
});

export default {
  searchCreatureTemplates,
  countCreatureTemplates,
  findCreatureTemplate,
  maxIdOfCreatureTemplate,
};
