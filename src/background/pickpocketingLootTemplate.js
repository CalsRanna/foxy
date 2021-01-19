import { ipcMain } from "electron";

import {
  SEARCH_PICKPOCKETING_LOOT_TEMPLATES,
  STORE_PICKPOCKETING_LOOT_TEMPLATE,
  FIND_PICKPOCKETING_LOOT_TEMPLATE,
  UPDATE_PICKPOCKETING_LOOT_TEMPLATE,
  DESTROY_PICKPOCKETING_LOOT_TEMPLATE,
  COPY_PICKPOCKETING_LOOT_TEMPLATE,
  GLOBAL_NOTICE
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_PICKPOCKETING_LOOT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select(["plt.*", "it.name", "itl.Name as localeName"])
    .from("pickpocketing_loot_template as plt")
    .leftJoin("item_template as it", "plt.Item", "it.entry")
    .leftJoin("item_template_locale as itl", function() {
      this.on("it.entry", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex().raw("?", "zhCN")
      );
    })
    .where("plt.Entry", payload.Entry);

  queryBuilder
    .then(rows => {
      event.reply(SEARCH_PICKPOCKETING_LOOT_TEMPLATES, rows);
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

ipcMain.on(STORE_PICKPOCKETING_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("pickpocketing_loot_template");

  queryBuilder
    .then(rows => {
      event.reply(STORE_PICKPOCKETING_LOOT_TEMPLATE, rows);
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

ipcMain.on(FIND_PICKPOCKETING_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("pickpocketing_loot_template")
    .where(payload);

  queryBuilder
    .then(rows => {
      event.reply(
        FIND_PICKPOCKETING_LOOT_TEMPLATE,
        rows.length > 0 ? rows[0] : {}
      );
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

ipcMain.on(UPDATE_PICKPOCKETING_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("pickpocketing_loot_template")
    .where(payload.credential)
    .update(payload.pickpocketingLootTemplate);

  queryBuilder
    .then(rows => {
      event.reply(UPDATE_PICKPOCKETING_LOOT_TEMPLATE, rows);
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

ipcMain.on(DESTROY_PICKPOCKETING_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("pickpocketing_loot_template")
    .where(payload)
    .delete();

  queryBuilder
    .then(rows => {
      event.reply(DESTROY_PICKPOCKETING_LOOT_TEMPLATE, rows);
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

ipcMain.on(COPY_PICKPOCKETING_LOOT_TEMPLATE, (event, payload) => {
  let item = undefined;
  let pickpocketingLootTemplate = undefined;

  let itemQueryBuilder = knex()
    .select("Item")
    .from("pickpocketing_loot_template")
    .where("Entry", payload.Entry)
    .orderBy("Item", "desc");
  let findPickpocketingLootTemplateQueryBuilder = knex()
    .select()
    .from("pickpocketing_loot_template")
    .where(payload);
  Promise.all([
    itemQueryBuilder.then(rows => {
      item = rows.length > 0 ? rows[0].Item : 0;
    }),
    findPickpocketingLootTemplateQueryBuilder.then(rows => {
      pickpocketingLootTemplate = rows.length > 0 ? rows[0] : {};
    })
  ])
    .then(() => {
      pickpocketingLootTemplate.Item = item + 1;
      if (pickpocketingLootTemplate.Reference != 0) {
        pickpocketingLootTemplate.Reference = item + 1;
      }
      let queryBuilder = knex()
        .insert(pickpocketingLootTemplate)
        .into("pickpocketing_loot_template");
      queryBuilder
        .then(rows => {
          event.reply(COPY_PICKPOCKETING_LOOT_TEMPLATE, rows);
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
