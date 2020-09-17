import { ipcMain } from "electron";

// import { mysql } from "mysql2";
const mysql = require("mysql2");

const connection = require("./mysql");
let { objectToSql } = require("../libs/util");

let createConnection = () =>
  mysql.createConnection({
    host: "127.0.0.1",
    user: "acore",
    password: "acore",
    database: "acore_world"
  });

let find = payload => {
  return new Promise((resolve, reject) => {
    let sql = `select * from creature_template where entry = ${payload.entry}`;

    connection
      .query(`${sql}`)
      .then(results => {
        resolve(results[0], sql);
      })
      .catch(error => {
        reject(error);
      });
  });
};

let maxEntry = () => {
  return new Promise((resolve, reject) => {
    let sql = "select entry from creature_template order by entry desc";

    connection
      .query(`${sql}`)
      .then(results => {
        resolve(results[0].entry, sql);
      })
      .catch(error => {
        reject(error);
      });
  });
};

// 搜索满足条件的生物模板
ipcMain.on("SEARCH_CREATURE_TEMPLATES", (event, payload) => {
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

  connection
    .query(`${sql} ${where} ${limit}`)
    .then(results => {
      event.reply("SEARCH_CREATURE_TEMPLATES_REPLY", results);
      event.reply("UPDATE_MESSAGE_REPLY", `${sql} ${where} ${limit}`);
    })
    .catch(error => {
      event.reply("UPDATE_MESSAGE_REPLY", error);
    });
});

// 计算满足条件的生物模板数量
ipcMain.on("COUNT_CREATURE_TEMPLATES", (event, payload) => {
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

  connection
    .query(`${sql} ${where}`)
    .then(results => {
      event.reply("COUNT_CREATURE_TEMPLATES_REPLY", results[0].total);
      event.reply("UPDATE_MESSAGE_REPLY", `${sql} ${where}`);
    })
    .catch(error => {
      event.reply("UPDATE_MESSAGE_REPLY", error);
    });
});

// 保存生物模板
ipcMain.on("STORE_CREATURE_TEMPLATE", (event, payload) => {
  let sql = `insert into creature_template values (${objectToSql(payload)})`;

  connection
    .query(`${sql}`)
    .then(results => {
      event.reply("COPY_CREATURE_TEMPLATE_REPLY", results);
      event.reply("UPDATE_MESSAGE_REPLY", {
        category: "notification",
        title: "成功",
        message: `新建成功。`,
        type: "success"
      });
      event.reply("UPDATE_MESSAGE_REPLY", `${sql}`);
    })
    .catch(error => {
      event.reply("UPDATE_MESSAGE_REPLY", error);
    });
});

// 根据条件得到指定的生物模板
ipcMain.on("FIND_CREATURE_TEMPLATE", (event, payload) => {
  find(payload)
    .then((creatureTemplate, sql) => {
      event.reply("FIND_CREATURE_TEMPLATE_REPLY", creatureTemplate);
      event.reply("UPDATE_MESSAGE_REPLY", `${sql}`);
    })
    .catch(error => {
      event.reply("UPDATE_MESSAGE_REPLY", error);
    });
});

// 删除满足条件生物模板
ipcMain.on("DESTROY_CREATURE_TEMPLATE", (event, payload) => {
  let sql = `delete from creature_template where entry = ${payload.entry}`;

  connection
    .query(`${sql}`)
    .then(results => {
      event.reply("DESTROY_CREATURE_TEMPLATE_REPLY", results);
      event.reply("UPDATE_MESSAGE_REPLY", {
        category: "notification",
        title: "成功",
        message: `删除成功。`,
        type: "success"
      });
      event.reply("UPDATE_MESSAGE_REPLY", `${sql}`);
    })
    .catch(error => {
      event.reply("UPDATE_MESSAGE_REPLY", error);
    });
});

// 复制满足条件的生物模板
ipcMain.on("COPY_CREATURE_TEMPLATE", (event, payload) => {
  let entry = 1;
  let origin = {};
  Promise.all([
    maxEntry()
      .then((id, sql) => {
        entry = id + 1;
      })
      .catch(error => {}),
    find(payload)
      .then((creatureTemplate, sql) => {
        origin = creatureTemplate;
      })
      .catch(error => {})
  ]).then(() => {
    origin.entry = entry;
    let sql = `insert into creature_template values (${objectToSql(origin)})`;

    connection
      .query(`${sql}`)
      .then(results => {
        event.reply("COPY_CREATURE_TEMPLATE_REPLY", results);
        event.reply("UPDATE_MESSAGE_REPLY", {
          category: "notification",
          title: "成功",
          message: `复制成功，新的生物模板 entry 为 ${entry}`,
          type: "success"
        });
        event.reply("UPDATE_MESSAGE_REPLY", `${sql}`);
      })
      .catch(error => {
        event.reply("UPDATE_MESSAGE_REPLY", error);
      });
  });
});

// 搜索满足条件的本地化生物模板
ipcMain.on("SEARCH_CREATURE_TEMPLATE_LOCALES", (event, payload) => {
  let sql = `select * from creature_template_locale where entry = ${payload.entry}`;

  connection
    .query(`${sql}`)
    .then(results => {
      event.reply("SEARCH_CREATURE_TEMPLATE_LOCALES_REPLY", results);
      event.reply("UPDATE_MESSAGE_REPLY", `${sql}`);
    })
    .catch(error => {
      event.reply("UPDATE_MESSAGE_REPLY", error);
    });
});

// 根据条件得到指定的生物模板补充信息
ipcMain.on("FIND_CREATURE_TEMPLATE_ADDON", (event, payload) => {
  let sql = `select * from creature_template_addon where entry = ${payload.entry}`;

  connection
    .query(`${sql}`)
    .then(results => {
      event.reply("FIND_CREATURE_TEMPLATE_ADDON_REPLY", results[0]);
      event.reply("UPDATE_MESSAGE_REPLY", `${sql}`);
    })
    .catch(error => {
      event.reply("UPDATE_MESSAGE_REPLY", error);
    });
});

// 根据条件得到指定的生物击杀声望奖励
ipcMain.on("FIND_CREATURE_ONKILL_REPUTATION", (event, payload) => {
  let sql = `select * from creature_onkill_reputation where creature_id = ${payload.creatureId}`;

  connection
    .query(`${sql}`)
    .then(results => {
      event.reply("FIND_CREATURE_ONKILL_REPUTATION_REPLY", results[0]);
      event.reply("UPDATE_MESSAGE_REPLY", `${sql}`);
    })
    .catch(error => {
      event.reply("UPDATE_MESSAGE_REPLY", error);
    });
});

// 搜索满足条件的生物装备模板
ipcMain.on("SEARCH_CREATURE_EQUIP_TEMPLATES", (event, payload) => {
  let sql = `select cet.*, it1.displayid as displayid1, it1.name as name1, itl1.Name as Name1, it2.displayid as displayid2, it2.name as name2, itl2.Name as Name2, it3.displayid as displayid3, it3.name as name3, itl3.Name as Name3 from creature_equip_template as cet left join item_template as it1 on cet.ItemID1 = it1.entry left join item_template_locale as itl1 on cet.ItemID1 = itl1.ID and itl1.locale = 'zhCN' left join item_template as it2 on cet.ItemID2 = it2.entry left join item_template_locale as itl2 on cet.ItemID2 = itl2.ID and itl2.locale = 'zhCN' left join item_template as it3 on cet.ItemID3 = it3.entry left join item_template_locale as itl3 on cet.ItemID3 = itl3.ID and itl3.locale = 'zhCN' where cet.CreatureID = ${payload.creatureId}`;

  connection
    .query(`${sql}`)
    .then(results => {
      event.reply("SEARCH_CREATURE_EQUIP_TEMPLATES_REPLY", results);
      event.reply("UPDATE_MESSAGE_REPLY", `${sql}`);
    })
    .catch(error => {
      event.reply("UPDATE_MESSAGE_REPLY", error);
    });
});

// 搜索满足条件的商人信息
ipcMain.on("SEARCH_NPC_VENDORS", (event, payload) => {
  let sql = `select nv.*, it.displayid, it.name, itl.Name from npc_vendor as nv left join item_template as it on nv.item = it.entry left join item_template_locale as itl on nv.item = itl.ID and itl.locale='zhCN' where nv.entry = ${payload.entry}`;

  connection
    .query(`${sql}`)
    .then(results => {
      event.reply("SEARCH_NPC_VENDORS_REPLY", results);
      event.reply("UPDATE_MESSAGE_REPLY", `${sql}`);
    })
    .catch(error => {
      event.reply("UPDATE_MESSAGE_REPLY", error);
    });
});

// 搜索满足条件的训练师信息
ipcMain.on("SEARCH_NPC_TRAINERS", (event, payload) => {
  let sql = `select * from npc_trainer where ID = ${payload.id}`;

  connection
    .query(`${sql}`)
    .then(results => {
      event.reply("SEARCH_NPC_TRAINERS_REPLY", results);
      event.reply("UPDATE_MESSAGE_REPLY", `${sql}`);
    })
    .catch(error => {
      event.reply("UPDATE_MESSAGE_REPLY", error);
    });
});

// 获得当前生物模板中最大的ID
ipcMain.on("CREATURE_TEMPLATE_MAX_ID", (event, payload) => {
  maxEntry()
    .then(id => {
      event.reply("CREATURE_TEMPLATE_MAX_ID_REPLY", id);
    })
    .catch(error => {
      event.reply("UPDATE_MESSAGE_REPLY", error);
    });
});
