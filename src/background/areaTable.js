import { ipcMain } from "electron";

import {
  SEARCH_AREA_TABLES,
  COUNT_AREA_TABLES,
  STORE_AREA_TABLE,
  FIND_AREA_TABLE,
  UPDATE_AREA_TABLE,
  DESTROY_AREA_TABLE,
  CREATE_AREA_TABLE,
  COPY_AREA_TABLE,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_AREA_TABLES, (event, payload) => {
  let queryBuilder = knex
    .select([
      "ID",
      "AreaName_Lang_zhCN",
      "ContinentID",
      "MinElevation",
      "ZoneMusic",
      "ExplorationLevel",
    ])
    .from("foxy.dbc_area_table");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.Name) {
    queryBuilder = queryBuilder.where(
      "AreaName_Lang_zhCN",
      "like",
      `%${payload.Name}%`
    );
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_AREA_TABLES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_AREA_TABLES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_AREA_TABLES, (event, payload) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_area_table");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.Name) {
    queryBuilder = queryBuilder.where(
      "AreaName_Lang_zhCN",
      "like",
      `%${payload.Name}%`
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_AREA_TABLES, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_AREA_TABLES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_AREA_TABLE, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("foxy.dbc_area_table");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_AREA_TABLE, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_AREA_TABLE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_AREA_TABLE, (event, payload) => {
  let queryBuilder = knex.select().from("foxy.dbc_area_table").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_AREA_TABLE, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_AREA_TABLE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_AREA_TABLE, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_area_table")
    .where(payload.credential)
    .update(payload.areaTable);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_AREA_TABLE, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_AREA_TABLE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_AREA_TABLE, (event, payload) => {
  let queryBuilder = knex.table("foxy.dbc_area_table").where(payload).delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_AREA_TABLE, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_AREA_TABLE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_AREA_TABLE, (event, payload) => {
  let queryBuilder = knex
    .select("ID")
    .from("foxy.dbc_area_table")
    .orderBy("ID", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_AREA_TABLE, {
        ID: rows[0].ID + 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_AREA_TABLE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_AREA_TABLE, (event, payload) => {
  let ID = undefined;
  let areaTable = undefined;

  let IDQueryBuilder = knex
    .select("ID")
    .from("foxy.dbc_area_table")
    .orderBy("ID", "desc");
  let findAreaTableQueryBuilder = knex
    .select()
    .from("foxy.dbc_area_table")
    .where(payload);
  Promise.all([
    IDQueryBuilder.then((rows) => {
      ID = rows[0].ID;
    }),
    findAreaTableQueryBuilder.then((rows) => {
      areaTable = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      areaTable.ID = ID + 1;
      let queryBuilder = knex.insert(areaTable).into("foxy.dbc_area_table");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_AREA_TABLE, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_AREA_TABLE}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_AREA_TABLE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
