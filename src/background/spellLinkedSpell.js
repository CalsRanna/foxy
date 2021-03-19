import { ipcMain } from "electron";

import {
  SEARCH_SPELL_LINKED_SPELLS,
  STORE_SPELL_LINKED_SPELL,
  FIND_SPELL_LINKED_SPELL,
  UPDATE_SPELL_LINKED_SPELL,
  DESTROY_SPELL_LINKED_SPELL,
  COPY_SPELL_LINKED_SPELL,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_SPELL_LINKED_SPELLS, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("spell_linked_spell")
    .whereIn("spell_trigger", [
      payload.spell_trigger,
      -1 * payload.spell_trigger,
    ]);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_SPELL_LINKED_SPELLS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_SPELL_LINKED_SPELLS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_SPELL_LINKED_SPELL, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("spell_linked_spell");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_SPELL_LINKED_SPELL, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_SPELL_LINKED_SPELL}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_SPELL_LINKED_SPELL, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("spell_linked_spell")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_SPELL_LINKED_SPELL, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_SPELL_LINKED_SPELL}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_SPELL_LINKED_SPELL, (event, payload) => {
  let queryBuilder = knex()
    .table("spell_linked_spell")
    .where(payload.credential)
    .update(payload.spellLinkedSpell);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_SPELL_LINKED_SPELL, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_SPELL_LINKED_SPELL}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_SPELL_LINKED_SPELL, (event, payload) => {
  let queryBuilder = knex()
    .table("spell_linked_spell")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_SPELL_LINKED_SPELL, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_SPELL_LINKED_SPELL}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_SPELL_LINKED_SPELL, (event, payload) => {
  let spellEffect = undefined;
  let spellLinkedSpell = undefined;

  let spellEffectQueryBuilder = knex()
    .select("spell_effect")
    .from("spell_linked_spell")
    .orderBy("spell_effect", "desc");
  let findSpellLinkedSpellQueryBuilder = knex()
    .select()
    .from("spell_linked_spell")
    .where(payload);
  Promise.all([
    spellEffectQueryBuilder.then((rows) => {
      spellEffect = rows.length > 0 ? rows[0].spell_effect : 0;
    }),
    findSpellLinkedSpellQueryBuilder.then((rows) => {
      spellLinkedSpell = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      spellLinkedSpell.spell_effect = spellEffect + 1;
      let queryBuilder = knex()
        .insert(spellLinkedSpell)
        .into("spell_linked_spell");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_SPELL_LINKED_SPELL, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_SPELL_LINKED_SPELL}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_SPELL_LINKED_SPELL}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});
