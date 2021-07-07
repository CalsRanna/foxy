import { ipcMain } from "electron";

import {
  SEARCH_SPELL_ITEM_ENCHANTMENTS,
  COUNT_SPELL_ITEM_ENCHANTMENTS,
  STORE_SPELL_ITEM_ENCHANTMENT,
  FIND_SPELL_ITEM_ENCHANTMENT,
  UPDATE_SPELL_ITEM_ENCHANTMENT,
  DESTROY_SPELL_ITEM_ENCHANTMENT,
  CREATE_SPELL_ITEM_ENCHANTMENT,
  COPY_SPELL_ITEM_ENCHANTMENT,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_SPELL_ITEM_ENCHANTMENTS, (event, payload) => {
  let queryBuilder = knex
    .select([
      "ID",
      "Name_Lang_zhCN",
      "Charges",
      "Effect_1",
      "Effect_2",
      "Effect_3",
      "EffectPointsMin_1",
      "EffectPointsMin_2",
      "EffectPointsMin_3",
      "EffectPointsMax_1",
      "EffectPointsMax_2",
      "EffectPointsMax_3",
    ])
    .from("foxy.dbc_spell_item_enchantment");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.Name) {
    queryBuilder = queryBuilder.where(
      "Name_Lang_zhCN",
      "like",
      `%${payload.Name}%`
    );
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_SPELL_ITEM_ENCHANTMENTS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_SPELL_ITEM_ENCHANTMENTS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_SPELL_ITEM_ENCHANTMENTS, (event, payload) => {
  let queryBuilder = knex
    .count("* as total")
    .from("foxy.dbc_spell_item_enchantment");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.Name) {
    queryBuilder = queryBuilder.where(
      "Name_Lang_zhCN",
      "like",
      `%${payload.Name}%`
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_SPELL_ITEM_ENCHANTMENTS, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_SPELL_ITEM_ENCHANTMENTS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_SPELL_ITEM_ENCHANTMENT, (event, payload) => {
  let queryBuilder = knex
    .insert(payload)
    .into("foxy.dbc_spell_item_enchantment");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_SPELL_ITEM_ENCHANTMENT, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_SPELL_ITEM_ENCHANTMENT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_SPELL_ITEM_ENCHANTMENT, (event, payload) => {
  let queryBuilder = knex
    .select()
    .from("foxy.dbc_spell_item_enchantment")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_SPELL_ITEM_ENCHANTMENT, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_SPELL_ITEM_ENCHANTMENT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_SPELL_ITEM_ENCHANTMENT, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_spell_item_enchantment")
    .where(payload.credential)
    .update(payload.spellItemEnchantment);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_SPELL_ITEM_ENCHANTMENT, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_SPELL_ITEM_ENCHANTMENT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_SPELL_ITEM_ENCHANTMENT, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_spell_item_enchantment")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_SPELL_ITEM_ENCHANTMENT, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_SPELL_ITEM_ENCHANTMENT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_SPELL_ITEM_ENCHANTMENT, (event, payload) => {
  let queryBuilder = knex
    .select("ID")
    .from("foxy.dbc_spell_item_enchantment")
    .orderBy("ID", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_SPELL_ITEM_ENCHANTMENT, {
        ID: rows[0].ID + 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_SPELL_ITEM_ENCHANTMENT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_SPELL_ITEM_ENCHANTMENT, (event, payload) => {
  let ID = undefined;
  let spellItemEnchantment = undefined;

  let IDQueryBuilder = knex
    .select("ID")
    .from("foxy.dbc_spell_item_enchantment")
    .orderBy("ID", "desc");
  let findAreaTableQueryBuilder = knex
    .select()
    .from("foxy.dbc_spell_item_enchantment")
    .where(payload);
  Promise.all([
    IDQueryBuilder.then((rows) => {
      ID = rows[0].ID;
    }),
    findAreaTableQueryBuilder.then((rows) => {
      spellItemEnchantment = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      spellItemEnchantment.ID = ID + 1;
      let queryBuilder = knex
        .insert(spellItemEnchantment)
        .into("foxy.dbc_spell_item_enchantment");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_SPELL_ITEM_ENCHANTMENT, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_SPELL_ITEM_ENCHANTMENT}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_SPELL_ITEM_ENCHANTMENT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
