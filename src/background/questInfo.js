import { ipcMain } from "electron";

import {
  SEARCH_QUEST_INFOS,
  COUNT_QUEST_INFOS,
  STORE_QUEST_INFO,
  FIND_QUEST_INFO,
  UPDATE_QUEST_INFO,
  DESTROY_QUEST_INFO,
  CREATE_QUEST_INFO,
  COPY_QUEST_INFO,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_QUEST_INFOS, (event, payload) => {
  let queryBuilder = knex.select().from("foxy.dbc_quest_info");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.InfoName_Lang_zhCN) {
    queryBuilder = queryBuilder.where(
      "InfoName_Lang_zhCN",
      "like",
      `%${payload.InfoName_Lang_zhCN}%`
    );
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_QUEST_INFOS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_QUEST_INFOS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_QUEST_INFOS, (event, payload) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_quest_info");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.InfoName_Lang_zhCN) {
    queryBuilder = queryBuilder.where(
      "InfoName_Lang_zhCN",
      "like",
      `%${payload.InfoName_Lang_zhCN}%`
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_QUEST_INFOS, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_QUEST_INFOS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_QUEST_INFO, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("foxy.dbc_quest_info");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_QUEST_INFO, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_QUEST_INFO}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_QUEST_INFO, (event, payload) => {
  let queryBuilder = knex.select().from("foxy.dbc_quest_info").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_QUEST_INFO, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_QUEST_INFO}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_QUEST_INFO, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_quest_info")
    .where(payload.credential)
    .update(payload.questInfo);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_QUEST_INFO, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_QUEST_INFO}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_QUEST_INFO, (event, payload) => {
  let queryBuilder = knex.table("foxy.dbc_quest_info").where(payload).delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_QUEST_INFO, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_QUEST_INFO}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_QUEST_INFO, (event, payload) => {
  let queryBuilder = knex
    .select("ID")
    .from("foxy.dbc_quest_info")
    .orderBy("ID", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_QUEST_INFO, {
        ID: rows[0].ID + 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_QUEST_INFO}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_QUEST_INFO, (event, payload) => {
  let ID = undefined;
  let questInfo = undefined;

  let IDQueryBuilder = knex
    .select("ID")
    .from("foxy.dbc_quest_info")
    .orderBy("ID", "desc");
  let findQuestInfoQueryBuilder = knex
    .select()
    .from("foxy.dbc_quest_info")
    .where(payload);
  Promise.all([
    IDQueryBuilder.then((rows) => {
      ID = rows[0].ID;
    }),
    findQuestInfoQueryBuilder.then((rows) => {
      questInfo = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      questInfo.ID = ID + 1;
      let queryBuilder = knex.insert(questInfo).into("foxy.dbc_quest_info");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_QUEST_INFO, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_QUEST_INFO}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_QUEST_INFO}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
