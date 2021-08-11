import { ipcMain } from "electron";

import {
  SEARCH_QUEST_SORTS,
  COUNT_QUEST_SORTS,
  STORE_QUEST_SORT,
  FIND_QUEST_SORT,
  UPDATE_QUEST_SORT,
  DESTROY_QUEST_SORT,
  CREATE_QUEST_SORT,
  COPY_QUEST_SORT,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_QUEST_SORTS, (event, payload) => {
  let queryBuilder = knex.select().from("foxy.dbc_quest_sort");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.SortName_Lang_zhCN) {
    queryBuilder = queryBuilder.where(
      "SortName_Lang_zhCN",
      "like",
      `%${payload.SortName_Lang_zhCN}%`
    );
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_QUEST_SORTS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_QUEST_SORTS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_QUEST_SORTS, (event, payload) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_quest_sort");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.SortName_Lang_zhCN) {
    queryBuilder = queryBuilder.where(
      "SortName_Lang_zhCN",
      "like",
      `%${payload.SortName_Lang_zhCN}%`
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_QUEST_SORTS, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_QUEST_SORTS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_QUEST_SORT, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("foxy.dbc_quest_sort");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_QUEST_SORT, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_QUEST_SORT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_QUEST_SORT, (event, payload) => {
  let queryBuilder = knex.select().from("foxy.dbc_quest_sort").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_QUEST_SORT, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_QUEST_SORT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_QUEST_SORT, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_quest_sort")
    .where(payload.credential)
    .update(payload.questSort);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_QUEST_SORT, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_QUEST_SORT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_QUEST_SORT, (event, payload) => {
  let queryBuilder = knex.table("foxy.dbc_quest_sort").where(payload).delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_QUEST_SORT, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_QUEST_SORT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_QUEST_SORT, (event, payload) => {
  let queryBuilder = knex
    .select("ID")
    .from("foxy.dbc_quest_sort")
    .orderBy("ID", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_QUEST_SORT, {
        ID: rows[0].ID + 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_QUEST_SORT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_QUEST_SORT, (event, payload) => {
  let ID = undefined;
  let questSort = undefined;

  let IDQueryBuilder = knex
    .select("ID")
    .from("foxy.dbc_quest_sort")
    .orderBy("ID", "desc");
  let findQuestSortQueryBuilder = knex
    .select()
    .from("foxy.dbc_quest_sort")
    .where(payload);
  Promise.all([
    IDQueryBuilder.then((rows) => {
      ID = rows[0].ID;
    }),
    findQuestSortQueryBuilder.then((rows) => {
      questSort = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      questSort.ID = ID + 1;
      let queryBuilder = knex.insert(questSort).into("foxy.dbc_quest_sort");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_QUEST_SORT, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_QUEST_SORT}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_QUEST_SORT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
