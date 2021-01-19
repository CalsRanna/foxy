import { ipcMain } from "electron";

import {
  SEARCH_CREATURE_LOOT_TEMPLATES,
  STORE_CREATURE_LOOT_TEMPLATE,
  FIND_CREATURE_LOOT_TEMPLATE,
  UPDATE_CREATURE_LOOT_TEMPLATE,
  DESTROY_CREATURE_LOOT_TEMPLATE,
  COPY_CREATURE_LOOT_TEMPLATE,
  GLOBAL_NOTICE
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_CREATURE_LOOT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select(["clt.*", "it.name", "itl.Name as localeName"])
    .from("creature_loot_template as clt")
    .leftJoin("item_template as it", "clt.Item", "it.entry")
    .leftJoin("item_template_locale as itl", function() {
      this.on("it.entry", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex().raw("?", "zhCN")
      );
    })
    .where("clt.Entry", payload.Entry);

  queryBuilder
    .then(rows => {
      event.reply(SEARCH_CREATURE_LOOT_TEMPLATES, rows);
    })
    .catch(error => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString()
      });
    });
});

ipcMain.on(STORE_CREATURE_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("creature_loot_template");

  queryBuilder
    .then(rows => {
      event.reply(STORE_CREATURE_LOOT_TEMPLATE, rows);
      event.reply(GLOBAL_NOTICE, {
        category: "notification",
        title: "成功",
        message: "新建成功。",
        type: "success"
      });
    })
    .catch(error => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString()
      });
    });
});

ipcMain.on(FIND_CREATURE_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("creature_loot_template")
    .where(payload);

  queryBuilder
    .then(rows => {
      event.reply(FIND_CREATURE_LOOT_TEMPLATE, rows.length > 0 ? rows[0] : {});
    })
    .catch(error => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString()
      });
    });
});

ipcMain.on(UPDATE_CREATURE_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("creature_loot_template")
    .where(payload.credential)
    .update(payload.creatureLootTemplate);

  queryBuilder
    .then(rows => {
      event.reply(UPDATE_CREATURE_LOOT_TEMPLATE, rows);
      event.reply(GLOBAL_NOTICE, {
        category: "notification",
        title: "成功",
        message: "修改成功。",
        type: "success"
      });
    })
    .catch(error => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString()
      });
    });
});

ipcMain.on(DESTROY_CREATURE_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("creature_loot_template")
    .where(payload)
    .delete();

  queryBuilder
    .then(rows => {
      event.reply(DESTROY_CREATURE_LOOT_TEMPLATE, rows);
      event.reply("GLOBAL_NOTICE", {
        category: "notification",
        title: "成功",
        message: "删除成功。",
        type: "success"
      });
    })
    .catch(error => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString()
      });
    });
});

ipcMain.on(COPY_CREATURE_LOOT_TEMPLATE, (event, payload) => {
  let item = undefined;
  let creatureLootTemplate = undefined;

  let itemQueryBuilder = knex()
    .select("Item")
    .from("creature_loot_template")
    .where("Entry", payload.Entry)
    .orderBy("Item", "desc");
  let findCreatureLootTempalteQueryBuilder = knex()
    .select()
    .from("creature_loot_template")
    .where(payload);
  Promise.all([
    itemQueryBuilder.then(rows => {
      item = rows.length > 0 ? rows[0].Item : 0;
    }),
    findCreatureLootTempalteQueryBuilder.then(rows => {
      creatureLootTemplate = rows.length > 0 ? rows[0] : {};
    })
  ])
    .then(() => {
      creatureLootTemplate.Item = item + 1;
      if (creatureLootTemplate.Reference != 0) {
        creatureLootTemplate.Reference = item + 1;
      }
      let queryBuilder = knex()
        .insert(creatureLootTemplate)
        .into("creature_loot_template");
      queryBuilder
        .then(rows => {
          event.reply(COPY_CREATURE_LOOT_TEMPLATE, rows);
          event.reply(GLOBAL_NOTICE, {
            type: "success",
            category: "notification",
            title: "成功",
            message: `复制成功，新的装备模板Item为${item + 1}。`
          });
        })
        .catch(error => {
          throw error;
        })
        .finally(() => {
          event.reply(GLOBAL_NOTICE, {
            category: "message",
            message: queryBuilder.toString()
          });
        });
    })
    .catch(error => {
      throw error;
    });
});
