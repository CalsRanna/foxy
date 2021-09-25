import { ipcMain } from "electron";

import {
  SEARCH_PLAYER_CREATE_INFO_ACTIONS,
  STORE_PLAYER_CREATE_INFO_ACTION,
  FIND_PLAYER_CREATE_INFO_ACTION,
  UPDATE_PLAYER_CREATE_INFO_ACTION,
  DESTROY_PLAYER_CREATE_INFO_ACTION,
  CREATE_PLAYER_CREATE_INFO_ACTION,
  COPY_PLAYER_CREATE_INFO_ACTION,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_PLAYER_CREATE_INFO_ACTIONS, (event, payload) => {
  let queryBuilder = knex
    .select([
      "pa.button",
      "pa.action",
      "pa.type",
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
    .from("playercreateinfo_action as pa")
    .leftJoin("foxy.dbc_spell as ds", "pa.action", "ds.ID")
    .leftJoin("foxy.dbc_spell_duration as dsd", "ds.DurationIndex", "dsd.ID")
    .leftJoin("foxy.dbc_spell_icon as dsi", "ds.SpellIconID", "dsi.ID")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_PLAYER_CREATE_INFO_ACTIONS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_PLAYER_CREATE_INFO_ACTIONS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_PLAYER_CREATE_INFO_ACTION, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("playercreateinfo_action");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_PLAYER_CREATE_INFO_ACTION, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_PLAYER_CREATE_INFO_ACTION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_PLAYER_CREATE_INFO_ACTION, (event, payload) => {
  let queryBuilder = knex
    .select()
    .from("playercreateinfo_action")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(
        FIND_PLAYER_CREATE_INFO_ACTION,
        rows.length > 0 ? rows[0] : {}
      );
    })
    .catch((error) => {
      event.reply(`${FIND_PLAYER_CREATE_INFO_ACTION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_PLAYER_CREATE_INFO_ACTION, (event, payload) => {
  let queryBuilder = knex
    .table("playercreateinfo_action")
    .where(payload.credential)
    .update(payload.playerCreateInfoAction);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_PLAYER_CREATE_INFO_ACTION, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_PLAYER_CREATE_INFO_ACTION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_PLAYER_CREATE_INFO_ACTION, (event, payload) => {
  let queryBuilder = knex
    .table("playercreateinfo_action")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_PLAYER_CREATE_INFO_ACTION, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_PLAYER_CREATE_INFO_ACTION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_PLAYER_CREATE_INFO_ACTION, (event, payload) => {
  let queryBuilder = knex
    .select("button")
    .from("playercreateinfo_action")
    .where(payload)
    .orderBy("button", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_PLAYER_CREATE_INFO_ACTION, {
        ...payload,
        button: rows.length > 0 ? rows[0].button + 1 : 0,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_PLAYER_CREATE_INFO_ACTION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_PLAYER_CREATE_INFO_ACTION, (event, payload) => {
  let button = null;
  let playerCreateInfoAction = null;

  let buttonQueryBuilder = knex
    .select("button")
    .from("playercreateinfo_action")
    .where("race", payload.race)
    .where("class", payload.class)
    .orderBy("button", "desc");
  let findPlayerCreateInfoActionBuilder = knex
    .select()
    .from("playercreateinfo_action")
    .where(payload);
  Promise.all([
    buttonQueryBuilder.then((rows) => {
      button = rows.length > 0 ? rows[0].button + 1 : 0;
    }),
    findPlayerCreateInfoActionBuilder.then((rows) => {
      playerCreateInfoAction = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      playerCreateInfoAction.button = button;
      let queryBuilder = knex
        .insert(playerCreateInfoAction)
        .into("playercreateinfo_action");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_PLAYER_CREATE_INFO_ACTION, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_PLAYER_CREATE_INFO_ACTION}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_PLAYER_CREATE_INFO_ACTION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
