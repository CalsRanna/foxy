import { ipcMain } from "electron";

import {
  SEARCH_SPELL_RANKS,
  STORE_SPELL_RANK,
  FIND_SPELL_RANK,
  UPDATE_SPELL_RANK,
  DESTROY_SPELL_RANK,
  COPY_SPELL_RANK,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_SPELL_RANKS, (event, payload) => {
  let queryBuilder = knex
    .select(["first_spell_id"])
    .from("spell_ranks as sr")
    .where(payload);

  queryBuilder
    .then((rows) => {
      if (rows.length > 0) {
        let firstSpellId = rows[0].first_spell_id;
        queryBuilder = knex
          .select([
            "sr.*",
            "fds.Name_Lang_zhCN as First_Spell_Name_Lang_zhCN",
            "fds.NameSubtext_Lang_zhCN as First_Spell_NameSubtext_Lang_zhCN",
            "ds.Name_Lang_zhCN as Spell_Name_Lang_zhCN",
            "ds.NameSubtext_Lang_zhCN as Spell_NameSubtext_Lang_zhCN",
          ])
          .from("spell_ranks as sr")
          .leftJoin("foxy.dbc_spell as fds", "sr.first_spell_id", "fds.ID")
          .leftJoin("foxy.dbc_spell as ds", "sr.spell_id", "ds.ID")
          .where("first_spell_id", firstSpellId);
        queryBuilder
          .then((rows) => {
            event.reply(SEARCH_SPELL_RANKS, rows);
          })
          .catch((error) => {
            event.reply(`${SEARCH_SPELL_RANKS}_REJECT`, error);
            event.reply(GLOBAL_MESSAGE_BOX, error);
          })
          .finally(() => {
            event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
          });
      }
    })
    .catch((error) => {
      event.reply(`${SEARCH_SPELL_RANKS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});

ipcMain.on(STORE_SPELL_RANK, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("spell_ranks");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_SPELL_RANK, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_SPELL_RANK}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_SPELL_RANK, (event, payload) => {
  let queryBuilder = knex.select().from("spell_ranks").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_SPELL_RANK, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_SPELL_RANK}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_SPELL_RANK, (event, payload) => {
  let queryBuilder = knex
    .table("spell_ranks")
    .where(payload.credential)
    .update(payload.spellRank);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_SPELL_RANK, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_SPELL_RANK}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_SPELL_RANK, (event, payload) => {
  let queryBuilder = knex.table("spell_ranks").where(payload).delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_SPELL_RANK, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_SPELL_RANK}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_SPELL_RANK, (event, payload) => {
  let spellId = undefined;
  let rank = undefined;
  let spellRank = undefined;

  let spellIdQueryBuilder = knex
    .select("spell_id")
    .from("spell_ranks")
    .where(payload)
    .orderBy("spell_id", "desc");
  let rankQueryBuilder = knex
    .select("rank")
    .from("spell_ranks")
    .where(payload)
    .orderBy("rank", "desc");
  let findSpellRankQueryBuilder = knex
    .select()
    .from("spell_ranks")
    .where(payload);
  Promise.all([
    spellIdQueryBuilder.then((rows) => {
      spellId = rows.length > 0 ? rows[0].spell_id : 0;
    }),
    rankQueryBuilder.then((rows) => {
      rank = rows.length > 0 ? rows[0].rank : 0;
    }),
    findSpellRankQueryBuilder.then((rows) => {
      spellRank = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      spellRank.spell_id = spellId + 1;
      spellRank.rank = rank + 1;
      let queryBuilder = knex.insert(spellRank).into("spell_ranks");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_SPELL_RANK, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_SPELL_RANK}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_SPELL_RANK}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
