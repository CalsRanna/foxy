import { ipcMain } from "electron";

import {
  SEARCH_ITEM_ENCHANTMENT_TEMPLATES_FOR_SELECTOR,
  COUNT_ITEM_ENCHANTMENT_TEMPLATES_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_ITEM_ENCHANTMENT_TEMPLATES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .select([
      "entry",
      knex.raw("group_concat(Name_Lang_zhCN, '(', chance, '%)') as enchs"),
    ])
    .groupBy("entry")
    .from("item_enchantment_template");
  if (payload.type == "properties") {
    queryBuilder
      .leftJoin("foxy.dbc_item_random_properties", "ench", "ID")
      .whereNotNull("ID");
  } else {
    queryBuilder
      .leftJoin("foxy.dbc_item_random_suffix", "ench", "ID")
      .whereNotNull("ID");
  }
  if (payload.entry) {
    queryBuilder = queryBuilder.where("entry", payload.entry);
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_ITEM_ENCHANTMENT_TEMPLATES_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(
        `${SEARCH_ITEM_ENCHANTMENT_TEMPLATES_FOR_SELECTOR}_REJECT`,
        error
      );
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_ITEM_ENCHANTMENT_TEMPLATES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .count({ total: knex.raw("distinct entry") })
    .from("item_enchantment_template");
  if (payload.type == "properties") {
    queryBuilder
      .leftJoin("foxy.dbc_item_random_properties", "ench", "ID")
      .whereNotNull("ID");
  } else {
    queryBuilder
      .leftJoin("foxy.dbc_item_random_suffix", "ench", "ID")
      .whereNotNull("ID");
  }
  if (payload.entry) {
    queryBuilder = queryBuilder.where("entry", payload.entry);
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_ITEM_ENCHANTMENT_TEMPLATES_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(
        `${COUNT_ITEM_ENCHANTMENT_TEMPLATES_FOR_SELECTOR}_REJECT`,
        error
      );
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
