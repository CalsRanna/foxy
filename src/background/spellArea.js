import { ipcMain } from "electron";

import {
  SEARCH_SPELL_AREAS,
  STORE_SPELL_AREA,
  FIND_SPELL_AREA,
  UPDATE_SPELL_AREA,
  DESTROY_SPELL_AREA,
  COPY_SPELL_AREA,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_SPELL_AREAS, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("spell_area")
    .where("spell", payload.spell);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_SPELL_AREAS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_SPELL_AREAS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_SPELL_AREA, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("spell_area");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_SPELL_AREA, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_SPELL_AREA}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_SPELL_AREA, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("spell_area")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_SPELL_AREA, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_SPELL_AREA}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_SPELL_AREA, (event, payload) => {
  let queryBuilder = knex()
    .table("spell_area")
    .where(payload.credential)
    .update(payload.spellArea);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_SPELL_AREA, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_SPELL_AREA}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_SPELL_AREA, (event, payload) => {
  let queryBuilder = knex()
    .table("spell_area")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_SPELL_AREA, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_SPELL_AREA}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_SPELL_AREA, (event, payload) => {
  let spellArea = undefined;

  let findSpellAreaQueryBuilder = knex()
    .select()
    .from("spell_area")
    .where(payload);
  findSpellAreaQueryBuilder
    .then((rows) => {
      spellArea = rows.length > 0 ? rows[0] : {};
      spellArea.area = spellArea.area + 1;
      let queryBuilder = knex()
        .insert(spellArea)
        .into("spell_area");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_SPELL_AREA, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_SPELL_AREA}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_SPELL_AREA}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});
