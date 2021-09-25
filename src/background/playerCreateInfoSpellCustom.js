import { ipcMain } from "electron";

import {
  SEARCH_PLAYER_CREATE_INFO_SPELL_CUSTOMS,
  STORE_PLAYER_CREATE_INFO_SPELL_CUSTOM,
  FIND_PLAYER_CREATE_INFO_SPELL_CUSTOM,
  UPDATE_PLAYER_CREATE_INFO_SPELL_CUSTOM,
  DESTROY_PLAYER_CREATE_INFO_SPELL_CUSTOM,
  CREATE_PLAYER_CREATE_INFO_SPELL_CUSTOM,
  COPY_PLAYER_CREATE_INFO_SPELL_CUSTOM,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_PLAYER_CREATE_INFO_SPELL_CUSTOMS, (event, payload) => {
  let queryBuilder = knex
    .select([
      "psc.*",
      "ds.Name_Lang_zhCN",
      "ds.NameSubtext_Lang_zhCN",
      "ds.Description_Lang_zhCN",
      "ds.AuraDescription_Lang_zhCN",
      "ds.DurationIndex",
      "ds.EffectBasePoints_1",
      "ds.EffectBasePoints_2",
      "ds.EffectBasePoints_3",
      "ds.EffectDieSides_1",
      "ds.EffectDieSides_2",
      "ds.EffectDieSides_3",
      "ds.EffectAuraPeriod_1",
      "ds.EffectAuraPeriod_2",
      "ds.EffectAuraPeriod_3",
      "ds.ProcCharges",
      "dsd.Duration as Duration",
      "dsi.TextureFilename",
    ])
    .from("playercreateinfo_spell_custom as psc")
    .leftJoin("foxy.dbc_spell as ds", "psc.Spell", "ds.ID")
    .leftJoin("foxy.dbc_spell_duration as dsd", "ds.DurationIndex", "dsd.ID")
    .leftJoin("foxy.dbc_spell_icon as dsi", "ds.SpellIconID", "dsi.ID")
    .where((builder) => {
      builder
        .whereRaw("racemask & ? > 0", Math.pow(2, payload.race - 1))
        .orWhere("racemask", 0);
    })
    .where((builder) => {
      builder
        .whereRaw("classmask & ? > 0", Math.pow(2, payload.class - 1))
        .orWhere("classmask", 0);
    });

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_PLAYER_CREATE_INFO_SPELL_CUSTOMS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_PLAYER_CREATE_INFO_SPELL_CUSTOMS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_PLAYER_CREATE_INFO_SPELL_CUSTOM, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("playercreateinfo_spell_custom");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_PLAYER_CREATE_INFO_SPELL_CUSTOM, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_PLAYER_CREATE_INFO_SPELL_CUSTOM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_PLAYER_CREATE_INFO_SPELL_CUSTOM, (event, payload) => {
  let queryBuilder = knex
    .select()
    .from("playercreateinfo_spell_custom")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(
        FIND_PLAYER_CREATE_INFO_SPELL_CUSTOM,
        rows.length > 0 ? rows[0] : {}
      );
    })
    .catch((error) => {
      event.reply(`${FIND_PLAYER_CREATE_INFO_SPELL_CUSTOM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_PLAYER_CREATE_INFO_SPELL_CUSTOM, (event, payload) => {
  let queryBuilder = knex
    .table("playercreateinfo_spell_custom")
    .where(payload.credential)
    .update(payload.playerCreateInfoSpellCustom);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_PLAYER_CREATE_INFO_SPELL_CUSTOM, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_PLAYER_CREATE_INFO_SPELL_CUSTOM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_PLAYER_CREATE_INFO_SPELL_CUSTOM, (event, payload) => {
  let queryBuilder = knex
    .table("playercreateinfo_spell_custom")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_PLAYER_CREATE_INFO_SPELL_CUSTOM, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_PLAYER_CREATE_INFO_SPELL_CUSTOM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_PLAYER_CREATE_INFO_SPELL_CUSTOM, (event, payload) => {
  let queryBuilder = knex
    .select("button")
    .from("playercreateinfo_spell_custom")
    .where(payload)
    .orderBy("button", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_PLAYER_CREATE_INFO_SPELL_CUSTOM, {
        ...payload,
        button: rows.length > 0 ? rows[0].button + 1 : 0,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_PLAYER_CREATE_INFO_SPELL_CUSTOM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_PLAYER_CREATE_INFO_SPELL_CUSTOM, (event, payload) => {
  let spell = null;
  let playerCreateInfoSpellCustom = null;

  let spellQueryBuilder = knex
    .select("Spell")
    .from("playercreateinfo_spell_custom")
    .where("racemask", payload.racemask)
    .where("classmask", payload.classmask)
    .orderBy("Spell", "desc");
  let findPlayerCreateInfoSpellCustomBuilder = knex
    .select()
    .from("playercreateinfo_spell_custom")
    .where(payload);
  Promise.all([
    spellQueryBuilder.then((rows) => {
      spell = rows.length > 0 ? rows[0].Spell + 1 : 0;
    }),
    findPlayerCreateInfoSpellCustomBuilder.then((rows) => {
      playerCreateInfoSpellCustom = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      playerCreateInfoSpellCustom.Spell = spell;
      let queryBuilder = knex
        .insert(playerCreateInfoSpellCustom)
        .into("playercreateinfo_spell_custom");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_PLAYER_CREATE_INFO_SPELL_CUSTOM, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_PLAYER_CREATE_INFO_SPELL_CUSTOM}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_PLAYER_CREATE_INFO_SPELL_CUSTOM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
