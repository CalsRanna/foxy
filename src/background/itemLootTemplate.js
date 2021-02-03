import { ipcMain } from "electron";

import {
  SEARCH_ITEM_LOOT_TEMPLATES,
  STORE_ITEM_LOOT_TEMPLATE,
  FIND_ITEM_LOOT_TEMPLATE,
  UPDATE_ITEM_LOOT_TEMPLATE,
  DESTROY_ITEM_LOOT_TEMPLATE,
  COPY_ITEM_LOOT_TEMPLATE,
  GLOBAL_NOTICE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_ITEM_LOOT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select(["ilt.*", "it.name", "itl.Name as localeName"])
    .from("item_loot_template as ilt")
    .leftJoin("item_template as it", "ilt.Item", "it.entry")
    .leftJoin("item_template_locale as itl", function() {
      this.on("it.entry", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex().raw("?", "zhCN")
      );
    })
    .where("ilt.Entry", payload.Entry);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_ITEM_LOOT_TEMPLATES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_ITEM_LOOT_TEMPLATES}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(STORE_ITEM_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("item_loot_template");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_ITEM_LOOT_TEMPLATE, rows);
      event.reply(GLOBAL_NOTICE, {
        category: "notification",
        title: "成功",
        message: "新建成功。",
        type: "success",
      });
    })
    .catch((error) => {
      event.reply(`${STORE_ITEM_LOOT_TEMPLATE}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(FIND_ITEM_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("item_loot_template")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_ITEM_LOOT_TEMPLATE, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_ITEM_LOOT_TEMPLATE}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(UPDATE_ITEM_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("item_loot_template")
    .where(payload.credential)
    .update(payload.itemLootTemplate);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_ITEM_LOOT_TEMPLATE, rows);
      event.reply(GLOBAL_NOTICE, {
        category: "notification",
        title: "成功",
        message: "修改成功。",
        type: "success",
      });
    })
    .catch((error) => {
      event.reply(`${UPDATE_ITEM_LOOT_TEMPLATE}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(DESTROY_ITEM_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("item_loot_template")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_ITEM_LOOT_TEMPLATE, rows);
      event.reply("GLOBAL_NOTICE", {
        category: "notification",
        title: "成功",
        message: "删除成功。",
        type: "success",
      });
    })
    .catch((error) => {
      event.reply(`${DESTROY_ITEM_LOOT_TEMPLATE}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(COPY_ITEM_LOOT_TEMPLATE, (event, payload) => {
  let item = undefined;
  let itemLootTemplate = undefined;

  let itemQueryBuilder = knex()
    .select("Item")
    .from("item_loot_template")
    .where("Entry", payload.Entry)
    .orderBy("Item", "desc");
  let findItemLootTempalteQueryBuilder = knex()
    .select()
    .from("item_loot_template")
    .where(payload);
  Promise.all([
    itemQueryBuilder.then((rows) => {
      item = rows.length > 0 ? rows[0].Item : 0;
    }),
    findItemLootTempalteQueryBuilder.then((rows) => {
      itemLootTemplate = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      itemLootTemplate.Item = item + 1;
      if (itemLootTemplate.Reference != 0) {
        itemLootTemplate.Reference = item + 1;
      }
      let queryBuilder = knex()
        .insert(itemLootTemplate)
        .into("item_loot_template");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_ITEM_LOOT_TEMPLATE, rows);
          event.reply(GLOBAL_NOTICE, {
            type: "success",
            category: "notification",
            title: "成功",
            message: `复制成功，新的装备模板Item为${item + 1}。`,
          });
        })
        .catch((error) => {
          event.reply(`${COPY_ITEM_LOOT_TEMPLATE}_REJECT`, error);
        })
        .finally(() => {
          event.reply(GLOBAL_NOTICE, {
            category: "message",
            message: queryBuilder.toString(),
          });
        });
    })
    .catch((error) => {
      event.reply(`${COPY_ITEM_LOOT_TEMPLATE}_REJECT`, error);
    });
});
