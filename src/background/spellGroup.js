import { ipcMain } from "electron";

import {
  SEARCH_SPELL_GROUPS,
  STORE_SPELL_GROUP,
  FIND_SPELL_GROUP,
  UPDATE_SPELL_GROUP,
  DESTROY_SPELL_GROUP,
  COPY_SPELL_GROUP,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_SPELL_GROUPS, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("spell_group")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_SPELL_GROUPS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_SPELL_GROUPS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_SPELL_GROUP, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("spell_group");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_SPELL_GROUP, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_SPELL_GROUP}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_SPELL_GROUP, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("spell_group")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_SPELL_GROUP, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_SPELL_GROUP}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_SPELL_GROUP, (event, payload) => {
  let queryBuilder = knex()
    .table("spell_group")
    .where(payload.credential)
    .update(payload.spellGroup);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_SPELL_GROUP, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_SPELL_GROUP}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_SPELL_GROUP, (event, payload) => {
  let queryBuilder = knex()
    .table("spell_group")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_SPELL_GROUP, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_SPELL_GROUP}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_SPELL_GROUP, (event, payload) => {
  let id = undefined;
  let spellGroup = undefined;

  let idQueryBuilder = knex()
    .select("id")
    .from("spell_group")
    .orderBy("id", "desc");
  let findSpellGroupQueryBuilder = knex()
    .select()
    .from("spell_group")
    .where(payload);
  Promise.all([
    idQueryBuilder.then((rows) => {
      id = rows.length > 0 ? rows[0].id : 0;
    }),
    findSpellGroupQueryBuilder.then((rows) => {
      spellGroup = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      spellGroup.id = id + 1;
      let queryBuilder = knex()
        .insert(spellGroup)
        .into("spell_group");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_SPELL_GROUP, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_SPELL_GROUP}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_SPELL_GROUP}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});
