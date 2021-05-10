import { ipcMain } from "electron";

import { FIND_VERSION, GLOBAL_MESSAGE_BOX, GLOBAL_MESSAGE } from "../constants";

ipcMain.on(FIND_VERSION, (event) => {
  let queryBuilder = knex.select().from("version");

  queryBuilder
    .then((rows) => {
      event.reply(FIND_VERSION, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_VERSION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
