import { ipcMain } from "electron";

import {
  SEARCH_TALENTS,
  COUNT_TALENTS,
  STORE_TALENT,
  FIND_TALENT,
  UPDATE_TALENT,
  DESTROY_TALENT,
  CREATE_TALENT,
  COPY_TALENT,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_TALENTS, (event, payload) => {
  let queryBuilder = knex
    .select([
      "fdt.ID",
      "fdt.TierID",
      "fdt.ColumnIndex",
      "fdtt.Name_Lang_zhCN as TabName",
      "fds.Name_Lang_zhCN",
      "fdsi.TextureFilename",
    ])
    .from("foxy.dbc_talent as fdt")
    .leftJoin("foxy.dbc_talent_tab as fdtt", "fdt.TabID", "fdtt.ID")
    .leftJoin("foxy.dbc_spell as fds", "fdt.SpellRank_1", "fds.ID")
    .leftJoin("foxy.dbc_spell_icon as fdsi", "fds.SpellIconID", "fdsi.ID");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("fdt.ID", "like", `%${payload.ID}%`);
  }
  if (payload.Spell) {
    queryBuilder = queryBuilder.where(
      "fds.Name_Lang_zhCN",
      "like",
      `%${payload.Spell}%`
    );
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_TALENTS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_TALENTS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_TALENTS, (event, payload) => {
  let queryBuilder = knex
    .count("* as total")
    .from("foxy.dbc_talent as fdt")
    .leftJoin("foxy.dbc_spell as fds", "fdt.SpellRank_1", "fds.ID");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("fdt.ID", "like", `%${payload.ID}%`);
  }
  if (payload.Spell) {
    queryBuilder = queryBuilder.where(
      "fds.Name_Lang_zhCN",
      "like",
      `%${payload.Name}%`
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_TALENTS, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_TALENTS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_TALENT, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("foxy.dbc_talent");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_TALENT, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_TALENT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_TALENT, (event, payload) => {
  let queryBuilder = knex
    .select(["fdt.*", "fds.Name_Lang_zhCN"])
    .from("foxy.dbc_talent as fdt")
    .leftJoin("foxy.dbc_spell as fds", "fdt.SpellRank_1", "fds.ID")
    .where("fdt.ID", payload.ID);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_TALENT, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_TALENT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_TALENT, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_talent")
    .where(payload.credential)
    .update(payload.talent);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_TALENT, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_TALENT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_TALENT, (event, payload) => {
  let queryBuilder = knex.table("foxy.dbc_talent").where(payload).delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_TALENT, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_TALENT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_TALENT, (event, payload) => {
  let queryBuilder = knex
    .select("ID")
    .from("foxy.dbc_talent")
    .orderBy("ID", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_TALENT, {
        ID: rows[0].ID + 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_TALENT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_TALENT, (event, payload) => {
  let ID = undefined;
  let talent = undefined;

  let IDQueryBuilder = knex
    .select("ID")
    .from("foxy.dbc_talent")
    .orderBy("ID", "desc");
  let findTalentQueryBuilder = knex
    .select()
    .from("foxy.dbc_talent")
    .where(payload);
  Promise.all([
    IDQueryBuilder.then((rows) => {
      ID = rows[0].ID;
    }),
    findTalentQueryBuilder.then((rows) => {
      talent = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      talent.ID = ID + 1;
      let queryBuilder = knex.insert(talent).into("foxy.dbc_talent");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_TALENT, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_TALENT}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_TALENT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
