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

let searchCreatureTemplates = ipcMain.on("SEARCH_CREATURE_TEMPLATES", (event, payload) => {
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
      event.reply("UPDATE_MESSAGE_REPLY", error);
    } else {
      event.reply("SEARCH_CREATURE_TEMPLATES_REPLY", results);
      event.reply("UPDATE_MESSAGE_REPLY", `${sql} ${where} ${limit}`);
    }
  });
  connection.end();
});

let countCreatureTemplates = ipcMain.on("COUNT_CREATURE_TEMPLATES", (event, payload) => {
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
      event.reply("UPDATE_MESSAGE_REPLY", error);
    } else {
      event.reply("COUNT_CREATURE_TEMPLATES_REPLY", results[0].total);
      event.reply("UPDATE_MESSAGE_REPLY", `${sql} ${where}`);
    }
  });
  connection.end();
});

let findCreatureTemplate = ipcMain.on("FIND_CREATURE_TEMPLATE", (event, payload) => {
  let sql = `select * from creature_template where entry = ${payload.entry}`;
  let connection = createConnection();
  connection.connect();
  connection.query(sql, (error, results) => {
    if (error) {
      event.reply("UPDATE_MESSAGE_REPLY", error);
    } else {
      if (results.length > 0) {
        event.reply("FIND_CREATURE_TEMPLATE_REPLY", results[0]);
      } else {
        event.reply("FIND_CREATURE_TEMPLATE_REPLY", {});
      }
      event.reply("UPDATE_MESSAGE_REPLY", `${sql}`);
    }
  });
  connection.end();
});

let searchCreatureTemplateLocales = ipcMain.on("SEARCH_CREATURE_TEMPLATE_LOCALES", (event, payload) => {
  let sql = `select * from creature_template_locale where entry = ${payload.entry}`;
  let connection = createConnection();
  connection.connect();
  connection.query(sql, (error, results) => {
    if (error) {
      event.reply("UPDATE_MESSAGE_REPLY", error);
    } else {
      event.reply("SEARCH_CREATURE_TEMPLATE_LOCALES_REPLY", results);
      event.reply("UPDATE_MESSAGE_REPLY", `${sql}`);
    }
  });
  connection.end();
});

let findCreatureTemplateAddon = ipcMain.on("FIND_CREATURE_TEMPLATE_ADDON", (event, payload) => {
  let sql = `select * from creature_template_addon where entry = ${payload.entry}`;
  let connection = createConnection();
  connection.connect();
  connection.query(sql, (error, results) => {
    if (error) {
      event.reply("UPDATE_MESSAGE_REPLY", error);
    } else {
      if (results.length > 0) {
        event.reply("FIND_CREATURE_TEMPLATE_ADDON_REPLY", results[0]);
      } else {
        event.reply("FIND_CREATURE_TEMPLATE_ADDON_REPLY", {});
      }
      event.reply("UPDATE_MESSAGE_REPLY", `${sql}`);
    }
  });
  connection.end();
});

let findCreatureOnKillReputation = ipcMain.on("FIND_CREATURE_ONKILL_REPUTATION", (event, payload) => {
  let sql = `select * from creature_onkill_reputation where creature_id = ${payload.creatureId}`;
  let connection = createConnection();
  connection.connect();
  connection.query(sql, (error, results) => {
    if (error) {
      event.reply("UPDATE_MESSAGE_REPLY", error);
    } else {
      if (results.length > 0) {
        event.reply("FIND_CREATURE_ONKILL_REPUTATION_REPLY", results[0]);
      } else {
        event.reply("FIND_CREATURE_ONKILL_REPUTATION_REPLY", {});
      }
      event.reply("UPDATE_MESSAGE_REPLY", `${sql}`);
    }
  });
  connection.end();
});

let searchCreatureEquipTemplates = ipcMain.on("SEARCH_CREATURE_EQUIP_TEMPLATES", (event, payload) => {
  let sql = `select cet.*, it1.displayid as displayid1, it1.name as name1, itl1.Name as Name1, it2.displayid as displayid2, it2.name as name2, itl2.Name as Name2, it3.displayid as displayid3, it3.name as name3, itl3.Name as Name3 from creature_equip_template as cet left join item_template as it1 on cet.ItemID1 = it1.entry left join item_template_locale as itl1 on cet.ItemID1 = itl1.ID and itl1.locale = 'zhCN' left join item_template as it2 on cet.ItemID2 = it2.entry left join item_template_locale as itl2 on cet.ItemID2 = itl2.ID and itl2.locale = 'zhCN' left join item_template as it3 on cet.ItemID3 = it3.entry left join item_template_locale as itl3 on cet.ItemID3 = itl3.ID and itl3.locale = 'zhCN' where cet.CreatureID = ${payload.creatureId}`;
  let connection = createConnection();
  connection.connect();
  connection.query(sql, (error, results) => {
    if (error) {
      event.reply("UPDATE_MESSAGE_REPLY", error);
    } else {
      event.reply("SEARCH_CREATURE_EQUIP_TEMPLATES_REPLY", results);
      event.reply("UPDATE_MESSAGE_REPLY", `${sql}`);
    }
  });
  connection.end();
});

let searchNpcVendors = ipcMain.on("SEARCH_NPC_VENDORS", (event, payload) => {
  let sql = `select nv.*, it.displayid, it.name, itl.Name from npc_vendor as nv left join item_template as it on nv.item = it.entry left join item_template_locale as itl on nv.item = itl.ID and itl.locale='zhCN' where nv.entry = ${payload.entry}`;
  let connection = createConnection();
  connection.connect();
  connection.query(sql, (error, results) => {
    if (error) {
      event.reply("UPDATE_MESSAGE_REPLY", error);
    } else {
      event.reply("SEARCH_NPC_VENDORS_REPLY", results);
      event.reply("UPDATE_MESSAGE_REPLY", `${sql}`);
    }
  });
  connection.end();
});

let searchNpcTrainers = ipcMain.on("SEARCH_NPC_TRAINERS", (event, payload) => {
  let sql = `select * from npc_trainer where ID = ${payload.id}`;
  let connection = createConnection();
  connection.connect();
  connection.query(sql, (error, results) => {
    if (error) {
      event.reply("UPDATE_MESSAGE_REPLY", error);
    } else {
      event.reply("SEARCH_NPC_TRAINERS_REPLY", results);
      event.reply("UPDATE_MESSAGE_REPLY", `${sql}`);
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
      event.reply("UPDATE_MESSAGE_REPLY", error);
    } else {
      event.reply("CREATURE_TEMPLATE_MAX_ID_REPLY", results[0].entry);
      event.reply("UPDATE_MESSAGE_REPLY", `${sql}`);
    }
  });
  connection.end();
});

export default {
  searchCreatureTemplates,
  countCreatureTemplates,
  findCreatureTemplate,
  maxIdOfCreatureTemplate
};
