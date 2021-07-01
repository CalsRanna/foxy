import { ipcMain } from "electron";

import {
  SEARCH_ITEM_RANDOM_PROPERTIES_FOR_SELECTOR,
  COUNT_ITEM_RANDOM_PROPERTIES_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_ITEM_RANDOM_PROPERTIES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .select([
      "dirp.ID",
      "dirp.Name_Lang_zhCN",
      "dsie_1.Name_Lang_zhCN as Enchantment_1",
      "dsie_2.Name_Lang_zhCN as Enchantment_2",
      "dsie_3.Name_Lang_zhCN as Enchantment_3",
      "dsie_4.Name_Lang_zhCN as Enchantment_4",
      "dsie_5.Name_Lang_zhCN as Enchantment_5",
    ])
    .from("foxy.dbc_item_random_properties as dirp")
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
  if (payload.ID) {
    queryBuilder = queryBuilder.where("dirp.ID", payload.ID);
  }
  if (payload.Name) {
    queryBuilder = queryBuilder.where(
      "dirp.Name_Lang_zhCN",
      "like",
      `%${payload.Name}%`
    );
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_ITEM_RANDOM_PROPERTIES_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(
        `${SEARCH_ITEM_RANDOM_PROPERTIES_FOR_SELECTOR}_REJECT`,
        error
      );
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_ITEM_RANDOM_PROPERTIES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .count("* as total")
    .from("foxy.dbc_item_random_properties as dirp")
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
  if (payload.ID) {
    queryBuilder = queryBuilder.where("dirp.ID", payload.ID);
  }
  if (payload.Name) {
    queryBuilder = queryBuilder.where(
      "dirp.Name_Lang_zhCN",
      "like",
      `%${payload.Name}%`
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_ITEM_RANDOM_PROPERTIES_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_ITEM_RANDOM_PROPERTIES_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
