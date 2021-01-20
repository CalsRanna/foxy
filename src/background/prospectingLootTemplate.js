import { ipcMain } from "electron";

import {
  SEARCH_PROSPECTING_LOOT_TEMPLATES,
  STORE_PROSPECTING_LOOT_TEMPLATE,
  FIND_PROSPECTING_LOOT_TEMPLATE,
  UPDATE_PROSPECTING_LOOT_TEMPLATE,
  DESTROY_PROSPECTING_LOOT_TEMPLATE,
  COPY_PROSPECTING_LOOT_TEMPLATE,
  GLOBAL_NOTICE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_PROSPECTING_LOOT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select(["plt.*", "it.name", "itl.Name as localeName"])
    .from("prospecting_loot_template as plt")
    .leftJoin("item_template as it", "plt.Item", "it.entry")
    .leftJoin("item_template_locale as itl", function () {
      this.on("it.entry", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex().raw("?", "zhCN")
      );
    })
    .where("plt.Entry", payload.Entry);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_PROSPECTING_LOOT_TEMPLATES, rows);
    })
    .catch((error) => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(STORE_PROSPECTING_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex().insert(payload).into("prospecting_loot_template");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_PROSPECTING_LOOT_TEMPLATE, rows);
      event.reply(GLOBAL_NOTICE, {
        category: "notification",
        title: "成功",
        message: "新建成功。",
        type: "success",
      });
    })
    .catch((error) => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(FIND_PROSPECTING_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("prospecting_loot_template")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(
        FIND_PROSPECTING_LOOT_TEMPLATE,
        rows.length > 0 ? rows[0] : {}
      );
    })
    .catch((error) => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(UPDATE_PROSPECTING_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("prospecting_loot_template")
    .where(payload.credential)
    .update(payload.prospectingLootTemplate);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_PROSPECTING_LOOT_TEMPLATE, rows);
      event.reply(GLOBAL_NOTICE, {
        category: "notification",
        title: "成功",
        message: "修改成功。",
        type: "success",
      });
    })
    .catch((error) => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(DESTROY_PROSPECTING_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("prospecting_loot_template")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_PROSPECTING_LOOT_TEMPLATE, rows);
      event.reply("GLOBAL_NOTICE", {
        category: "notification",
        title: "成功",
        message: "删除成功。",
        type: "success",
      });
    })
    .catch((error) => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(COPY_PROSPECTING_LOOT_TEMPLATE, (event, payload) => {
  let item = undefined;
  let prospectingLootTemplate = undefined;

  let itemQueryBuilder = knex()
    .select("Item")
    .from("prospecting_loot_template")
    .where("Entry", payload.Entry)
    .orderBy("Item", "desc");
  let findProspectingLootTempalteQueryBuilder = knex()
    .select()
    .from("prospecting_loot_template")
    .where(payload);
  Promise.all([
    itemQueryBuilder.then((rows) => {
      item = rows.length > 0 ? rows[0].Item : 0;
    }),
    findProspectingLootTempalteQueryBuilder.then((rows) => {
      prospectingLootTemplate = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      prospectingLootTemplate.Item = item + 1;
      if (prospectingLootTemplate.Reference != 0) {
        prospectingLootTemplate.Reference = item + 1;
      }
      let queryBuilder = knex()
        .insert(prospectingLootTemplate)
        .into("prospecting_loot_template");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_PROSPECTING_LOOT_TEMPLATE, rows);
          event.reply(GLOBAL_NOTICE, {
            type: "success",
            category: "notification",
            title: "成功",
            message: `复制成功，新的装备模板Item为${item + 1}。`,
          });
        })
        .catch((error) => {
          throw error;
        })
        .finally(() => {
          event.reply(GLOBAL_NOTICE, {
            category: "message",
            message: queryBuilder.toString(),
          });
        });
    })
    .catch((error) => {
      throw error;
    });
});
