import { ipcMain } from "electron";
import {
  SEARCH_SCALING_STAT_DISTRIBUTIONS,
  COUNT_SCALING_STAT_DISTRIBUTIONS,
  STORE_SCALING_STAT_DISTRIBUTION,
  FIND_SCALING_STAT_DISTRIBUTION,
  UPDATE_SCALING_STAT_DISTRIBUTION,
  DESTROY_SCALING_STAT_DISTRIBUTION,
  COPY_SCALING_STAT_DISTRIBUTION,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_SCALING_STAT_DISTRIBUTIONS, (event, payload) => {
  let queryBuilder = knex().select().from("foxy.dbc_scaling_stat_distribution");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.Stat) {
    queryBuilder = queryBuilder
      .where("StatID_1", payload.Stat)
      .orWhere("StatID_2", payload.Stat)
      .orWhere("StatID_3", payload.Stat)
      .orWhere("StatID_4", payload.Stat)
      .orWhere("StatID_5", payload.Stat)
      .orWhere("StatID_6", payload.Stat)
      .orWhere("StatID_7", payload.Stat)
      .orWhere("StatID_8", payload.Stat)
      .orWhere("StatID_9", payload.Stat)
      .orWhere("StatID_10", payload.Stat);
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_SCALING_STAT_DISTRIBUTIONS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_SCALING_STAT_DISTRIBUTIONS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_SCALING_STAT_DISTRIBUTIONS, (event, payload) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("foxy.dbc_scaling_stat_distribution");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.Stat) {
    queryBuilder = queryBuilder
      .where("StatID_1", payload.Stat)
      .orWhere("StatID_2", payload.Stat)
      .orWhere("StatID_3", payload.Stat)
      .orWhere("StatID_4", payload.Stat)
      .orWhere("StatID_5", payload.Stat)
      .orWhere("StatID_6", payload.Stat)
      .orWhere("StatID_7", payload.Stat)
      .orWhere("StatID_8", payload.Stat)
      .orWhere("StatID_9", payload.Stat)
      .orWhere("StatID_10", payload.Stat);
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_SCALING_STAT_DISTRIBUTIONS, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_SCALING_STAT_DISTRIBUTIONS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_SCALING_STAT_DISTRIBUTION, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("foxy.dbc_scaling_stat_distribution");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_SCALING_STAT_DISTRIBUTION, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_SCALING_STAT_DISTRIBUTION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_SCALING_STAT_DISTRIBUTION, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("foxy.dbc_scaling_stat_distribution")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(
        FIND_SCALING_STAT_DISTRIBUTION,
        rows.length > 0 ? rows[0] : {}
      );
    })
    .catch((error) => {
      event.reply(`${FIND_SCALING_STAT_DISTRIBUTION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_SCALING_STAT_DISTRIBUTION, (event, payload) => {
  let queryBuilder = knex()
    .table("foxy.dbc_scaling_stat_distribution")
    .where(payload.credential)
    .update(payload.scalingStatDistribution);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_SCALING_STAT_DISTRIBUTION, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_SCALING_STAT_DISTRIBUTION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_SCALING_STAT_DISTRIBUTION, (event, payload) => {
  let queryBuilder = knex()
    .table("foxy.dbc_scaling_stat_distribution")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_SCALING_STAT_DISTRIBUTION, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_SCALING_STAT_DISTRIBUTION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_SCALING_STAT_DISTRIBUTION, (event, payload) => {
  let id = undefined;
  let scalingStatDistribution = undefined;

  let idQueryBuilder = knex()
    .select("ID")
    .from("foxy.dbc_scaling_stat_distribution")
    .orderBy("ID", "desc");
  let findScalingStatDistributionQueryBuilder = knex()
    .select()
    .from("foxy.dbc_scaling_stat_distribution")
    .where(payload);
  Promise.all([
    idQueryBuilder.then((rows) => {
      id = rows[0].ID;
    }),
    findScalingStatDistributionQueryBuilder.then((rows) => {
      scalingStatDistribution = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      scalingStatDistribution.ID = id + 1;
      let queryBuilder = knex()
        .insert(scalingStatDistribution)
        .into("foxy.dbc_scaling_stat_distribution");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_SCALING_STAT_DISTRIBUTION, rows);
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        })
        .catch((error) => {
          event.reply(`${COPY_SCALING_STAT_DISTRIBUTION}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_SCALING_STAT_DISTRIBUTION}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});
