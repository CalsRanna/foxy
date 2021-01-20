import { ipcMain } from "electron";

import {
  SEARCH_ITEM_ENCHANTMENT_TEMPLATES,
  STORE_ITEM_ENCHANTMENT_TEMPLATE,
  FIND_ITEM_ENCHANTMENT_TEMPLATE,
  UPDATE_ITEM_ENCHANTMENT_TEMPLATE,
  DESTROY_ITEM_ENCHANTMENT_TEMPLATE,
  COPY_ITEM_ENCHANTMENT_TEMPLATE,
  GLOBAL_NOTICE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_ITEM_ENCHANTMENT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("item_enchantment_template")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_ITEM_ENCHANTMENT_TEMPLATES, rows);
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

ipcMain.on(STORE_ITEM_ENCHANTMENT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex().insert(payload).into("item_enchantment_template");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_ITEM_ENCHANTMENT_TEMPLATE, rows);
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

ipcMain.on(FIND_ITEM_ENCHANTMENT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("item_enchantment_template")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(
        FIND_ITEM_ENCHANTMENT_TEMPLATE,
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

ipcMain.on(UPDATE_ITEM_ENCHANTMENT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("item_enchantment_template")
    .where(payload.credential)
    .update(payload.itemEnchantmentTemplate);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_ITEM_ENCHANTMENT_TEMPLATE, rows);
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

ipcMain.on(DESTROY_ITEM_ENCHANTMENT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("item_enchantment_template")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_ITEM_ENCHANTMENT_TEMPLATE, rows);
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

ipcMain.on(COPY_ITEM_ENCHANTMENT_TEMPLATE, (event, payload) => {
  let ench = undefined;
  let itemEnchantmentTemplate = undefined;

  let enchQueryBuilder = knex()
    .select("ench")
    .from("item_enchantment_template")
    .where("entry", payload.entry)
    .orderBy("ench", "desc");
  let findItemEnchantmentTemplateQueryBuilder = knex()
    .select()
    .from("item_enchantment_template")
    .where(payload);
  Promise.all([
    enchQueryBuilder.then((rows) => {
      ench = rows.length > 0 ? rows[0].ench : 1;
    }),
    findItemEnchantmentTemplateQueryBuilder.then((rows) => {
      itemEnchantmentTemplate = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      itemEnchantmentTemplate.ench = ench + 1;
      let queryBuilder = knex()
        .insert(itemEnchantmentTemplate)
        .into("item_enchantment_template");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_ITEM_ENCHANTMENT_TEMPLATE, rows);
          event.reply(GLOBAL_NOTICE, {
            type: "success",
            category: "notification",
            title: "成功",
            message: `复制成功，新的装备模板ench为${ench + 1}。`,
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
