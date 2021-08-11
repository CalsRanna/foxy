import { ipcMain } from "electron";

import {
  SEARCH_PAGE_TEXTS_FOR_SELECTOR,
  COUNT_PAGE_TEXTS_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_PAGE_TEXTS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .select(["pt.ID", "pt.Text", "ptl.Text as localeText", "pt.NextPageID"])
    .from("page_text as pt")
    .leftJoin("page_text_locale as ptl", function () {
      this.on("pt.ID", "=", "ptl.ID").andOn(
        "ptl.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    });
  if (payload.ID) {
    queryBuilder = queryBuilder.where("pt.ID", payload.ID);
  }
  if (payload.Text) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("pt.Text", "like", `%${payload.Text}%`)
        .orWhere("ptl.Text", "like", `%${payload.Text}%`)
    );
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_PAGE_TEXTS_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_PAGE_TEXTS_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_PAGE_TEXTS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .count("* as total")
    .from("page_text as pt")
    .leftJoin("page_text_locale as ptl", function () {
      this.on("pt.ID", "=", "ptl.ID").andOn(
        "ptl.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    });
  if (payload.ID) {
    queryBuilder = queryBuilder.where("pt.ID", payload.ID);
  }
  if (payload.Text) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("pt.Text", "like", `%${payload.Text}%`)
        .orWhere("ptl.Text", "like", `%${payload.Text}%`)
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_PAGE_TEXTS_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_PAGE_TEXTS_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
