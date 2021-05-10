import { ipcMain } from "electron";

import {
  STORE_CREATURE_ONKILL_REPUTATION,
  FIND_CREATURE_ONKILL_REPUTATION,
  UPDATE_CREATURE_ONKILL_REPUTATION,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(STORE_CREATURE_ONKILL_REPUTATION, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("creature_onkill_reputation");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_CREATURE_ONKILL_REPUTATION, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_CREATURE_ONKILL_REPUTATION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_CREATURE_ONKILL_REPUTATION, (event, payload) => {
  let queryBuilder = knex
    .select()
    .from("creature_onkill_reputation")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(
        FIND_CREATURE_ONKILL_REPUTATION,
        rows.length > 0 ? rows[0] : {}
      );
    })
    .catch((error) => {
      event.reply(`${FIND_CREATURE_ONKILL_REPUTATION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_CREATURE_ONKILL_REPUTATION, (event, payload) => {
  let queryBuilder = knex
    .table("creature_onkill_reputation")
    .where(payload.credential)
    .update(payload.creatureOnKillReputation);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_CREATURE_ONKILL_REPUTATION, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_CREATURE_ONKILL_REPUTATION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});
