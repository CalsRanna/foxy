import { ipcMain } from "electron";

import {
  SEARCH_NPC_TEXTS_FOR_SELECTOR,
  COUNT_NPC_TEXTS_FOR_SELECTOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_NPC_TEXTS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .select(["nt.ID", "nt.text0_0", "nt.text0_1", "ntl.Text0_0", "ntl.Text0_1"])
    .from("npc_text as nt")
    .leftJoin("npc_text_locale as ntl", function () {
      this.on("nt.ID", "=", "ntl.ID").andOn(
        "ntl.Locale",
        "=",
        knex.raw("?", "zhCN")
      );
    });
  if (payload.ID) {
    queryBuilder = queryBuilder.where("nt.ID", payload.ID);
  }
  if (payload.Text) {
    queryBuilder = queryBuilder.whereRaw(
      "concat(`nt`.`text0_0`,`nt`.`text0_1`,`ntl`.`Text0_0`,`ntl`.`Text0_1`) like ?",
      [`%${payload.Text}%`]
    );
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_NPC_TEXTS_FOR_SELECTOR, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_NPC_TEXTS_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_NPC_TEXTS_FOR_SELECTOR, (event, payload) => {
  let queryBuilder = knex
    .count("* as total")
    .from("npc_text as nt")
    .leftJoin("npc_text_locale as ntl", function () {
      this.on("nt.ID", "=", "ntl.ID").andOn(
        "ntl.Locale",
        "=",
        knex.raw("?", "zhCN")
      );
    });
  if (payload.ID) {
    queryBuilder = queryBuilder.where("nt.ID", payload.ID);
  }
  if (payload.Text) {
    queryBuilder = queryBuilder.whereRaw(
      "concat(`nt`.`text0_0`,`nt`.`text0_1`,`ntl`.`Text0_0`,`ntl`.`Text0_1`) like ?",
      [`%${payload.Text}%`]
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_NPC_TEXTS_FOR_SELECTOR, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_NPC_TEXTS_FOR_SELECTOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
