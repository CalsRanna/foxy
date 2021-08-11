import { ipcMain } from "electron";
import {
  SEARCH_BROADCAST_TEXTS_FOR_SELECTOR,
  COUNT_BROADCAST_TEXTS_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_BROADCAST_TEXTS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .select([
      "bt.ID",
      "bt.MaleText",
      "btl.MaleText as localeMaleText",
      "bt.FemaleText",
      "btl.FemaleText as localeFemaleText",
    ])
    .from("broadcast_text as bt")
    .leftJoin("broadcast_text_locale as btl", function () {
      this.on("bt.ID", "=", "btl.ID").andOn(
        "btl.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    });
  if (payload.ID) {
    queryBuilder = queryBuilder.where("bt.ID", payload.ID);
  }
  if (payload.Text) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("bt.MaleText", "like", `%${payload.Text}%`)
        .orWhere("btl.localMaleText", "like", `%${payload.Text}%`)
        .orWhere("btl.FemaleText", "like", `%${payload.Text}%`)
        .orWhere("btl.localFemaleText", "like", `%${payload.Text}%`)
    );
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_BROADCAST_TEXTS_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_BROADCAST_TEXTS_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_BROADCAST_TEXTS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .count("* as total")
    .from("broadcast_text as bt")
    .leftJoin("broadcast_text_locale as btl", function () {
      this.on("bt.ID", "=", "btl.ID").andOn(
        "btl.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    });
  if (payload.ID) {
    queryBuilder = queryBuilder.where("bt.ID", payload.ID);
  }
  if (payload.Text) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("bt.MaleText", "like", `%${payload.Text}%`)
        .orWhere("btl.localMaleText", "like", `%${payload.Text}%`)
        .orWhere("btl.FemaleText", "like", `%${payload.Text}%`)
        .orWhere("btl.localFemaleText", "like", `%${payload.Text}%`)
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_BROADCAST_TEXTS_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_BROADCAST_TEXTS_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
