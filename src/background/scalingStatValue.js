import { ipcMain } from "electron";
import {
  SEARCH_SCALING_STAT_VALUES,
  COUNT_SCALING_STAT_VALUES,
  STORE_SCALING_STAT_VALUE,
  FIND_SCALING_STAT_VALUE,
  UPDATE_SCALING_STAT_VALUE,
  DESTROY_SCALING_STAT_VALUE,
  COPY_SCALING_STAT_VALUE,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_SCALING_STAT_VALUES, (event, payload) => {
  let queryBuilder = knex.select().from("foxy.dbc_scaling_stat_values");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.Charlevel) {
    queryBuilder = queryBuilder.where("Charlevel", payload.Charlevel);
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_SCALING_STAT_VALUES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_SCALING_STAT_VALUES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_SCALING_STAT_VALUES, (event, payload) => {
  let queryBuilder = knex
    .count("* as total")
    .from("foxy.dbc_scaling_stat_values");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.Charlevel) {
    queryBuilder = queryBuilder.where("Charlevel", payload.Charlevel);
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_SCALING_STAT_VALUES, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_SCALING_STAT_VALUES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_SCALING_STAT_VALUE, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("foxy.dbc_scaling_stat_values");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_SCALING_STAT_VALUE, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_SCALING_STAT_VALUE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_SCALING_STAT_VALUE, (event, payload) => {
  let queryBuilder = knex
    .select()
    .from("foxy.dbc_scaling_stat_values")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_SCALING_STAT_VALUE, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_SCALING_STAT_VALUE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_SCALING_STAT_VALUE, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_scaling_stat_values")
    .where(payload.credential)
    .update(payload.scalingStatValue);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_SCALING_STAT_VALUE, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_SCALING_STAT_VALUE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_SCALING_STAT_VALUE, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_scaling_stat_values")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_SCALING_STAT_VALUE, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_SCALING_STAT_VALUE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_SCALING_STAT_VALUE, (event, payload) => {
  let id = undefined;
  let scalingStatValue = undefined;

  let idQueryBuilder = knex
    .select("ID")
    .from("foxy.dbc_scaling_stat_values")
    .orderBy("ID", "desc");
  let findScalingStatValueQueryBuilder = knex
    .select()
    .from("foxy.dbc_scaling_stat_values")
    .where(payload);
  Promise.all([
    idQueryBuilder.then((rows) => {
      id = rows[0].ID;
    }),
    findScalingStatValueQueryBuilder.then((rows) => {
      scalingStatValue = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      scalingStatValue.ID = id + 1;
      let queryBuilder = knex
        .insert(scalingStatValue)
        .into("foxy.dbc_scaling_stat_values");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_SCALING_STAT_VALUE, rows);
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        })
        .catch((error) => {
          event.reply(`${COPY_SCALING_STAT_VALUE}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_SCALING_STAT_VALUE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
