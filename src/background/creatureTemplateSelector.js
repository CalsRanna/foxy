import { ipcMain } from "electron";
import {
  SEARCH_CREATURE_TEMPLATES_FOR_SELECTOR,
  COUNT_CREATURE_TEMPLATES_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_CREATURE_TEMPLATES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex()
    .select([
      "ct.entry",
      "ct.name",
      "ctl.Name as localeName",
      "ct.subname",
      "ctl.Title as localeTitle",
      "ct.minlevel",
      "ct.maxlevel",
    ])
    .from("creature_template as ct")
    .leftJoin("creature_template_locale as ctl", function() {
      this.on("ct.entry", "=", "ctl.entry").andOn(
        "ctl.locale",
        "=",
        knex().raw("?", "zhCN")
      );
    });
  if (payload.entry) {
    queryBuilder = queryBuilder.where("ct.entry", "like", `%${payload.entry}%`);
  }
  if (payload.name) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("ct.name", "like", `%${payload.name}%`)
        .orWhere("ctl.Name", "like", `%${payload.name}%`)
    );
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_CREATURE_TEMPLATES_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_CREATURE_TEMPLATES_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_CREATURE_TEMPLATES_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("creature_template as ct")
    .leftJoin("creature_template_locale as ctl", function() {
      this.on("ct.entry", "=", "ctl.entry").andOn(
        "ctl.locale",
        "=",
        knex().raw("?", "zhCN")
      );
    });
  if (payload.entry) {
    queryBuilder = queryBuilder.where("ct.entry", "like", `%${payload.entry}%`);
  }
  if (payload.name) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("ct.name", "like", `%${payload.name}%`)
        .orWhere("ctl.Name", "like", `%${payload.name}%`)
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_CREATURE_TEMPLATES_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_CREATURE_TEMPLATES_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
