import { ipcMain } from "electron";

import {
  SEARCH_ITEM_ENCHANTMENT_TEMPLATES,
  STORE_ITEM_ENCHANTMENT_TEMPLATE,
  FIND_ITEM_ENCHANTMENT_TEMPLATE,
  UPDATE_ITEM_ENCHANTMENT_TEMPLATE,
  DESTROY_ITEM_ENCHANTMENT_TEMPLATE,
  COPY_ITEM_ENCHANTMENT_TEMPLATE,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_ITEM_ENCHANTMENT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex
    .select(["iet.*", "re.*"])
    .from("item_enchantment_template as iet");
  if (payload.type == "properties") {
    queryBuilder.leftJoin(
      "foxy.dbc_item_random_properties as re",
      "ench",
      "ID"
    );
  } else {
    queryBuilder.leftJoin("foxy.dbc_item_random_suffix as re", "ench", "ID");
  }
  delete payload.type;
  queryBuilder.whereNotNull("ID").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_ITEM_ENCHANTMENT_TEMPLATES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_ITEM_ENCHANTMENT_TEMPLATES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_ITEM_ENCHANTMENT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("item_enchantment_template");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_ITEM_ENCHANTMENT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_ITEM_ENCHANTMENT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_ITEM_ENCHANTMENT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex
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
      event.reply(`${FIND_ITEM_ENCHANTMENT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_ITEM_ENCHANTMENT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex
    .table("item_enchantment_template")
    .where(payload.credential)
    .update(payload.itemEnchantmentTemplate);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_ITEM_ENCHANTMENT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_ITEM_ENCHANTMENT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_ITEM_ENCHANTMENT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex
    .table("item_enchantment_template")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_ITEM_ENCHANTMENT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_ITEM_ENCHANTMENT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_ITEM_ENCHANTMENT_TEMPLATE, (event, payload) => {
  let ench = undefined;
  let itemEnchantmentTemplate = undefined;

  let enchQueryBuilder = knex
    .select("ench")
    .from("item_enchantment_template")
    .where("entry", payload.entry)
    .orderBy("ench", "desc");
  let findItemEnchantmentTemplateQueryBuilder = knex
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
      let queryBuilder = knex
        .insert(itemEnchantmentTemplate)
        .into("item_enchantment_template");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_ITEM_ENCHANTMENT_TEMPLATE, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_ITEM_ENCHANTMENT_TEMPLATE}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_ITEM_ENCHANTMENT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});
