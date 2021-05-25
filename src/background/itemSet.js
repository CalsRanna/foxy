import { ipcMain } from "electron";

import {
  SEARCH_ITEM_SETS,
  COUNT_ITEM_SETS,
  STORE_ITEM_SET,
  FIND_ITEM_SET,
  UPDATE_ITEM_SET,
  DESTROY_ITEM_SET,
  CREATE_ITEM_SET,
  COPY_ITEM_SET,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_ITEM_SETS, (event, payload) => {
  let queryBuilder = knex
    .select(["ID", "Name_Lang_zhCN", "RequiredSkill", "RequiredSkillRank"])
    .from("foxy.dbc_item_set");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", "like", `%${payload.ID}%`);
  }
  if (payload.Name) {
    queryBuilder = queryBuilder.where(
      "Name_Lang_zhCN",
      "like",
      `%${payload.Name}%`
    );
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_ITEM_SETS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_ITEM_SETS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_ITEM_SETS, (event, payload) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_item_set");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", "like", `%${payload.ID}%`);
  }
  if (payload.Name) {
    queryBuilder = queryBuilder.where(
      "Name_Lang_zhCN",
      "like",
      `%${payload.Name}%`
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_ITEM_SETS, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_ITEM_SETS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_ITEM_SET, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("foxy.dbc_item_set");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_ITEM_SET, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_ITEM_SET}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_ITEM_SET, (event, payload) => {
  let queryBuilder = knex.select().from("foxy.dbc_item_set").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_ITEM_SET, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_ITEM_SET}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_ITEM_SET, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_item_set")
    .where(payload.credential)
    .update(payload.itemSet);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_ITEM_SET, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_ITEM_SET}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_ITEM_SET, (event, payload) => {
  let queryBuilder = knex.table("foxy.dbc_item_set").where(payload).delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_ITEM_SET, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_ITEM_SET}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_ITEM_SET, (event, payload) => {
  let queryBuilder = knex
    .select("ID")
    .from("foxy.dbc_item_set")
    .orderBy("ID", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_ITEM_SET, {
        ID: rows[0].ID + 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_ITEM_SET}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_ITEM_SET, (event, payload) => {
  let ID = undefined;
  let itemSet = undefined;

  let IDQueryBuilder = knex
    .select("ID")
    .from("foxy.dbc_item_set")
    .orderBy("ID", "desc");
  let findItemSetQueryBuilder = knex
    .select()
    .from("foxy.dbc_item_set")
    .where(payload);
  Promise.all([
    IDQueryBuilder.then((rows) => {
      ID = rows[0].ID;
    }),
    findItemSetQueryBuilder.then((rows) => {
      itemSet = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      itemSet.ID = ID + 1;
      let queryBuilder = knex.insert(itemSet).into("foxy.dbc_item_set");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_ITEM_SET, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_ITEM_SET}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_ITEM_SET}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
