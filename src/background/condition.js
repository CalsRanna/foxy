import { ipcMain } from "electron";

import {
  SEARCH_CONDITIONS,
  COUNT_CONDITIONS,
  STORE_CONDITION,
  FIND_CONDITION,
  UPDATE_CONDITION,
  DESTROY_CONDITION,
  CREATE_CONDITION,
  COPY_CONDITION,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_CONDITIONS, (event, payload) => {
  let queryBuilder = knex.select().from("conditions");
  if (payload.SourceTypeOrReferenceId) {
    queryBuilder = queryBuilder.where(
      "SourceTypeOrReferenceId",
      payload.SourceTypeOrReferenceId
    );
  }
  if (payload.SourceEntry) {
    queryBuilder = queryBuilder.where("SourceEntry", payload.SourceEntry);
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_CONDITIONS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_CONDITIONS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_CONDITIONS, (event, payload) => {
  let queryBuilder = knex.count("* as total").from("conditions");
  if (payload.SourceTypeOrReferenceId) {
    queryBuilder = queryBuilder.where(
      "SourceTypeOrReferenceId",
      payload.SourceTypeOrReferenceId
    );
  }
  if (payload.SourceEntry) {
    queryBuilder = queryBuilder.where("SourceEntry", payload.SourceEntry);
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_CONDITIONS, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_CONDITIONS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_CONDITION, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("conditions");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_CONDITION, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_CONDITION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_CONDITION, (event, payload) => {
  let queryBuilder = knex.select().from("conditions").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_CONDITION, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_CONDITION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_CONDITION, (event, payload) => {
  let queryBuilder = knex
    .table("conditions")
    .where(payload.credential)
    .update(payload.condition);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_CONDITION, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_CONDITION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_CONDITION, (event, payload) => {
  let queryBuilder = knex.table("conditions").where(payload).delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_CONDITION, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_CONDITION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_CONDITION, (event, payload) => {
  let queryBuilder = knex.select("ID").from("conditions").orderBy("ID", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_CONDITION, {
        ID: rows[0].ID + 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_CONDITION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_CONDITION, (event, payload) => {
  let condition = undefined;
  let findConditionQueryBuilder = knex
    .select()
    .from("conditions")
    .where(payload);
  Promise.all([
    findConditionQueryBuilder.then((rows) => {
      condition = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      condition.ConditionValue3 += 1;
      let queryBuilder = knex.insert(condition).into("conditions");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_CONDITION, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_CONDITION}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_CONDITION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
