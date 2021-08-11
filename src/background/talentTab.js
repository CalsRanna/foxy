import { ipcMain } from "electron";

import {
  SEARCH_TALENT_TABS,
  COUNT_TALENT_TABS,
  STORE_TALENT_TAB,
  FIND_TALENT_TAB,
  UPDATE_TALENT_TAB,
  DESTROY_TALENT_TAB,
  CREATE_TALENT_TAB,
  COPY_TALENT_TAB,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_TALENT_TABS, (event, payload) => {
  let queryBuilder = knex.select().from("foxy.dbc_talent_tab");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.Name_Lang_zhCN) {
    queryBuilder = queryBuilder.where(
      "Name_Lang_zhCN",
      "like",
      `%${payload.Name_Lang_zhCN}%`
    );
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_TALENT_TABS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_TALENT_TABS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_TALENT_TABS, (event, payload) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_talent_tab");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.Name_Lang_zhCN) {
    queryBuilder = queryBuilder.where(
      "Name_Lang_zhCN",
      "like",
      `%${payload.Name_Lang_zhCN}%`
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_TALENT_TABS, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_TALENT_TABS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_TALENT_TAB, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("foxy.dbc_talent_tab");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_TALENT_TAB, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_TALENT_TAB}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_TALENT_TAB, (event, payload) => {
  let queryBuilder = knex.select().from("foxy.dbc_talent_tab").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_TALENT_TAB, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_TALENT_TAB}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_TALENT_TAB, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_talent_tab")
    .where(payload.credential)
    .update(payload.talentTab);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_TALENT_TAB, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_TALENT_TAB}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_TALENT_TAB, (event, payload) => {
  let queryBuilder = knex.table("foxy.dbc_talent_tab").where(payload).delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_TALENT_TAB, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_TALENT_TAB}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_TALENT_TAB, (event, payload) => {
  let queryBuilder = knex
    .select("ID")
    .from("foxy.dbc_talent_tab")
    .orderBy("ID", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_TALENT_TAB, {
        ID: rows[0].ID + 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_TALENT_TAB}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_TALENT_TAB, (event, payload) => {
  let ID = undefined;
  let talentTab = undefined;

  let IDQueryBuilder = knex
    .select("ID")
    .from("foxy.dbc_talent_tab")
    .orderBy("ID", "desc");
  let findTalentTabQueryBuilder = knex
    .select()
    .from("foxy.dbc_talent_tab")
    .where(payload);
  Promise.all([
    IDQueryBuilder.then((rows) => {
      ID = rows[0].ID;
    }),
    findTalentTabQueryBuilder.then((rows) => {
      talentTab = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      talentTab.ID = ID + 1;
      let queryBuilder = knex.insert(talentTab).into("foxy.dbc_talent_tab");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_TALENT_TAB, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_TALENT_TAB}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_TALENT_TAB}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
