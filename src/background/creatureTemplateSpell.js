import { ipcMain } from "electron";

import {
  SEARCH_CREATURE_TEMPLATE_SPELLS,
  STORE_CREATURE_TEMPLATE_SPELL,
  FIND_CREATURE_TEMPLATE_SPELL,
  UPDATE_CREATURE_TEMPLATE_SPELL,
  DESTROY_CREATURE_TEMPLATE_SPELL,
  CREATE_CREATURE_TEMPLATE_SPELL,
  COPY_CREATURE_TEMPLATE_SPELL,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_CREATURE_TEMPLATE_SPELLS, (event, payload) => {
  let queryBuilder = knex
    .select(["cts.*", "ds.Name_Lang_zhCN", "ds.NameSubtext_Lang_zhCN"])
    .from("creature_template_spell as cts")
    .leftJoin("foxy.dbc_spell as ds", "cts.Spell", "ds.ID")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_CREATURE_TEMPLATE_SPELLS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_CREATURE_TEMPLATE_SPELLS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_CREATURE_TEMPLATE_SPELL, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("creature_template_spell");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_CREATURE_TEMPLATE_SPELL, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_CREATURE_TEMPLATE_SPELL}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_CREATURE_TEMPLATE_SPELL, (event, payload) => {
  let queryBuilder = knex
    .select()
    .from("creature_template_spell")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_CREATURE_TEMPLATE_SPELL, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_CREATURE_TEMPLATE_SPELL}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_CREATURE_TEMPLATE_SPELL, (event, payload) => {
  let queryBuilder = knex
    .table("creature_template_spell")
    .where(payload.credential)
    .update(payload.creatureTemplateSpell);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_CREATURE_TEMPLATE_SPELL, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_CREATURE_TEMPLATE_SPELL}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_CREATURE_TEMPLATE_SPELL, (event, payload) => {
  let queryBuilder = knex
    .table("creature_template_spell")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_CREATURE_TEMPLATE_SPELL, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_CREATURE_TEMPLATE_SPELL}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_CREATURE_TEMPLATE_SPELL, (event, payload) => {
  let queryBuilder = knex
    .select("Index")
    .from("creature_template_spell")
    .where(payload)
    .orderBy("Index", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_CREATURE_TEMPLATE_SPELL, {
        CreatureID: payload.CreatureID,
        Index: rows.length > 0 ? rows[0].Index + 1 : 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_CREATURE_TEMPLATE_SPELL}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_CREATURE_TEMPLATE_SPELL, (event, payload) => {
  let index = undefined;
  let creatureTemplateSpell = undefined;

  let indexQueryBuilder = knex
    .select("Index")
    .from("creature_template_spell")
    .where("CreatureID", payload.CreatureID)
    .orderBy("Index", "desc");
  let findCreatureTemplateSpellQueryBuilder = knex
    .select()
    .from("creature_template_spell")
    .where(payload);
  Promise.all([
    indexQueryBuilder.then((rows) => {
      index = rows.length > 0 ? rows[0].Index : 1;
    }),
    findCreatureTemplateSpellQueryBuilder.then((rows) => {
      creatureTemplateSpell = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      creatureTemplateSpell.Index = index + 1;
      let queryBuilder = knex
        .insert(creatureTemplateSpell)
        .into("creature_template_spell");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_CREATURE_TEMPLATE_SPELL, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_CREATURE_TEMPLATE_SPELL}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_CREATURE_TEMPLATE_SPELL}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
