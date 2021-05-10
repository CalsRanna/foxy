import { ipcMain } from "electron";

import {
  SEARCH_ITEM_TEMPLATES_FOR_SELECTOR,
  COUNT_ITEM_TEMPLATES_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_ITEM_TEMPLATES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .select([
      "it.entry",
      "it.name",
      "itl.Name as localeName",
      "it.description",
      "itl.Description as localeDescription",
      "it.Quality",
      "it.displayid",
      "it.ItemLevel",
      "it.RequiredLevel",
    ])
    .from("item_template as it")
    .leftJoin("item_template_locale as itl", function () {
      this.on("it.entry", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    });
  if (payload.entry) {
    queryBuilder = queryBuilder.where("it.entry", "like", `%${payload.entry}%`);
  }
  if (payload.name) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("it.name", "like", `%${payload.name}%`)
        .orWhere("itl.Name", "like", `%${payload.name}%`)
    );
  }
  if (payload.description) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("it.description", "like", `%${payload.description}%`)
        .orWhere("itl.Description", "like", `%${payload.description}%`)
    );
  }
  if (payload.class != undefined) {
    queryBuilder = queryBuilder.where("it.class", payload.class);
  }
  if (payload.subclass != undefined) {
    queryBuilder = queryBuilder.where("it.subclass", payload.subclass);
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_ITEM_TEMPLATES_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_ITEM_TEMPLATES_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_ITEM_TEMPLATES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .count("* as total")
    .from("item_template as it")
    .leftJoin("item_template_locale as itl", function () {
      this.on("it.entry", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    });
  if (payload.entry) {
    queryBuilder = queryBuilder.where("it.entry", "like", `%${payload.entry}%`);
  }
  if (payload.name) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("it.name", "like", `%${payload.name}%`)
        .orWhere("itl.Name", "like", `%${payload.name}%`)
    );
  }
  if (payload.description) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("it.description", "like", `%${payload.description}%`)
        .orWhere("itl.Description", "like", `%${payload.description}%`)
    );
  }
  if (payload.class != undefined) {
    queryBuilder = queryBuilder.where("it.class", payload.class);
  }
  if (payload.subclass != undefined) {
    queryBuilder = queryBuilder.where("it.subclass", payload.subclass);
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_ITEM_TEMPLATES_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_ITEM_TEMPLATES_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
