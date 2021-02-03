import { ipcMain } from "electron";

import {
  SEARCH_MILLING_LOOT_TEMPLATES,
  STORE_MILLING_LOOT_TEMPLATE,
  FIND_MILLING_LOOT_TEMPLATE,
  UPDATE_MILLING_LOOT_TEMPLATE,
  DESTROY_MILLING_LOOT_TEMPLATE,
  COPY_MILLING_LOOT_TEMPLATE,
  GLOBAL_NOTICE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_MILLING_LOOT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select(["mlt.*", "it.name", "itl.Name as localeName"])
    .from("milling_loot_template as mlt")
    .leftJoin("item_template as it", "mlt.Item", "it.entry")
    .leftJoin("item_template_locale as itl", function() {
      this.on("it.entry", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex().raw("?", "zhCN")
      );
    })
    .where("mlt.Entry", payload.Entry);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_MILLING_LOOT_TEMPLATES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_MILLING_LOOT_TEMPLATES}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(STORE_MILLING_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("milling_loot_template");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_MILLING_LOOT_TEMPLATE, rows);
      event.reply(GLOBAL_NOTICE, {
        category: "notification",
        title: "成功",
        message: "新建成功。",
        type: "success",
      });
    })
    .catch((error) => {
      event.reply(`${STORE_MILLING_LOOT_TEMPLATE}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(FIND_MILLING_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("milling_loot_template")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_MILLING_LOOT_TEMPLATE, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_MILLING_LOOT_TEMPLATE}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(UPDATE_MILLING_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("milling_loot_template")
    .where(payload.credential)
    .update(payload.millingLootTemplate);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_MILLING_LOOT_TEMPLATE, rows);
      event.reply(GLOBAL_NOTICE, {
        category: "notification",
        title: "成功",
        message: "修改成功。",
        type: "success",
      });
    })
    .catch((error) => {
      event.reply(`${UPDATE_MILLING_LOOT_TEMPLATE}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(DESTROY_MILLING_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("milling_loot_template")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_MILLING_LOOT_TEMPLATE, rows);
      event.reply("GLOBAL_NOTICE", {
        category: "notification",
        title: "成功",
        message: "删除成功。",
        type: "success",
      });
    })
    .catch((error) => {
      event.reply(`${DESTROY_MILLING_LOOT_TEMPLATE}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(COPY_MILLING_LOOT_TEMPLATE, (event, payload) => {
  let item = undefined;
  let millingLootTemplate = undefined;

  let itemQueryBuilder = knex()
    .select("Item")
    .from("milling_loot_template")
    .where("Entry", payload.Entry)
    .orderBy("Item", "desc");
  let findmillingLootTempalteQueryBuilder = knex()
    .select()
    .from("milling_loot_template")
    .where(payload);
  Promise.all([
    itemQueryBuilder.then((rows) => {
      item = rows.length > 0 ? rows[0].Item : 0;
    }),
    findmillingLootTempalteQueryBuilder.then((rows) => {
      millingLootTemplate = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      millingLootTemplate.Item = item + 1;
      if (millingLootTemplate.Reference != 0) {
        millingLootTemplate.Reference = item + 1;
      }
      let queryBuilder = knex()
        .insert(millingLootTemplate)
        .into("milling_loot_template");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_MILLING_LOOT_TEMPLATE, rows);
          event.reply(GLOBAL_NOTICE, {
            type: "success",
            category: "notification",
            title: "成功",
            message: `复制成功，新的装备模板Item为${item + 1}。`,
          });
        })
        .catch((error) => {
          event.reply(`${COPY_MILLING_LOOT_TEMPLATE}_REJECT`, error);
        })
        .finally(() => {
          event.reply(GLOBAL_NOTICE, {
            category: "message",
            message: queryBuilder.toString(),
          });
        });
    })
    .catch((error) => {
      event.reply(`${COPY_MILLING_LOOT_TEMPLATE}_REJECT`, error);
    });
});
