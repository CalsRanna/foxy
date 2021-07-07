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
  let queryBuilder = null;
  if (payload.type == "properties") {
    queryBuilder = knex
      .select([
        "iet.entry",
        "iet.ench",
        "iet.chance",
        "dirp.Name_Lang_zhCN",
        "dirp.Name",
        "dsie_1.Name_Lang_zhCN as Enchantment_1",
        "dsie_2.Name_Lang_zhCN as Enchantment_2",
        "dsie_3.Name_Lang_zhCN as Enchantment_3",
        "dsie_4.Name_Lang_zhCN as Enchantment_4",
        "dsie_5.Name_Lang_zhCN as Enchantment_5",
      ])
      .from("item_enchantment_template as iet");
    queryBuilder
      .leftJoin(
        "foxy.dbc_item_random_properties as dirp",
        "iet.ench",
        "dirp.ID"
      )
      .leftJoin(
        "foxy.dbc_spell_item_enchantment as dsie_1",
        "dirp.Enchantment_1",
        "dsie_1.ID"
      )
      .leftJoin(
        "foxy.dbc_spell_item_enchantment as dsie_2",
        "dirp.Enchantment_2",
        "dsie_2.ID"
      )
      .leftJoin(
        "foxy.dbc_spell_item_enchantment as dsie_3",
        "dirp.Enchantment_3",
        "dsie_3.ID"
      )
      .leftJoin(
        "foxy.dbc_spell_item_enchantment as dsie_4",
        "dirp.Enchantment_4",
        "dsie_4.ID"
      )
      .leftJoin(
        "foxy.dbc_spell_item_enchantment as dsie_5",
        "dirp.Enchantment_5",
        "dsie_5.ID"
      );
    delete payload.type;
    queryBuilder.whereNotNull("dirp.ID").where(payload);
  } else {
    queryBuilder = knex
      .select([
        "iet.entry",
        "iet.ench",
        "iet.chance",
        "dirs.Name_Lang_zhCN",
        "dirs.InternalName",
        "dsie_1.Name_Lang_zhCN as Enchantment_1",
        "dsie_2.Name_Lang_zhCN as Enchantment_2",
        "dsie_3.Name_Lang_zhCN as Enchantment_3",
        "dsie_4.Name_Lang_zhCN as Enchantment_4",
        "dsie_5.Name_Lang_zhCN as Enchantment_5",
      ])
      .from("item_enchantment_template as iet");
    queryBuilder
      .leftJoin("foxy.dbc_item_random_suffix as dirs", "iet.ench", "dirs.ID")
      .leftJoin(
        "foxy.dbc_spell_item_enchantment as dsie_1",
        "dirs.Enchantment_1",
        "dsie_1.ID"
      )
      .leftJoin(
        "foxy.dbc_spell_item_enchantment as dsie_2",
        "dirs.Enchantment_2",
        "dsie_2.ID"
      )
      .leftJoin(
        "foxy.dbc_spell_item_enchantment as dsie_3",
        "dirs.Enchantment_3",
        "dsie_3.ID"
      )
      .leftJoin(
        "foxy.dbc_spell_item_enchantment as dsie_4",
        "dirs.Enchantment_4",
        "dsie_4.ID"
      )
      .leftJoin(
        "foxy.dbc_spell_item_enchantment as dsie_5",
        "dirs.Enchantment_5",
        "dsie_5.ID"
      );
    delete payload.type;
    queryBuilder.whereNotNull("dirs.ID").where(payload);
  }

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_ITEM_ENCHANTMENT_TEMPLATES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_ITEM_ENCHANTMENT_TEMPLATES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
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
      event.reply(GLOBAL_MESSAGE_BOX, error);
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
      event.reply(GLOBAL_MESSAGE_BOX, error);
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
      event.reply(GLOBAL_MESSAGE_BOX, error);
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
      event.reply(GLOBAL_MESSAGE_BOX, error);
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
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_ITEM_ENCHANTMENT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
