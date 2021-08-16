import { ipcMain } from "electron";

import {
  SEARCH_ACHIEVEMENTS,
  COUNT_ACHIEVEMENTS,
  STORE_ACHIEVEMENT,
  FIND_ACHIEVEMENT,
  UPDATE_ACHIEVEMENT,
  DESTROY_ACHIEVEMENT,
  CREATE_ACHIEVEMENT,
  COPY_ACHIEVEMENT,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_ACHIEVEMENTS, (event, payload) => {
  let queryBuilder = knex
    .select([
      "ID",
      "Title_Lang_zhCN",
      "Description_Lang_zhCN",
      "Reward_Lang_zhCN",
    ])
    .from("foxy.dbc_achievement");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.Title) {
    queryBuilder = queryBuilder.where(
      "Title_Lang_zhCN",
      "like",
      `%${payload.Title}%`
    );
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_ACHIEVEMENTS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_ACHIEVEMENTS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_ACHIEVEMENTS, (event, payload) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_achievement");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.Title) {
    queryBuilder = queryBuilder.where(
      "Title_Lang_zhCN",
      "like",
      `%${payload.Title}%`
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_ACHIEVEMENTS, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_ACHIEVEMENTS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_ACHIEVEMENT, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("foxy.dbc_achievement");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_ACHIEVEMENT, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_ACHIEVEMENT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_ACHIEVEMENT, (event, payload) => {
  let queryBuilder = knex.select().from("foxy.dbc_achievement").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_ACHIEVEMENT, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_ACHIEVEMENT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_ACHIEVEMENT, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_achievement")
    .where(payload.credential)
    .update(payload.achievement);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_ACHIEVEMENT, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_ACHIEVEMENT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_ACHIEVEMENT, (event, payload) => {
  let queryBuilder = knex.table("foxy.dbc_achievement").where(payload).delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_ACHIEVEMENT, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_ACHIEVEMENT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_ACHIEVEMENT, (event, payload) => {
  let queryBuilder = knex
    .select("ID")
    .from("foxy.dbc_achievement")
    .orderBy("ID", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_ACHIEVEMENT, {
        ID: rows[0].ID + 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_ACHIEVEMENT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_ACHIEVEMENT, (event, payload) => {
  let ID = undefined;
  let achievement = undefined;

  let IDQueryBuilder = knex
    .select("ID")
    .from("foxy.dbc_achievement")
    .orderBy("ID", "desc");
  let findAchievementQueryBuilder = knex
    .select()
    .from("foxy.dbc_achievement")
    .where(payload);
  Promise.all([
    IDQueryBuilder.then((rows) => {
      ID = rows[0].ID;
    }),
    findAchievementQueryBuilder.then((rows) => {
      achievement = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      achievement.ID = ID + 1;
      let queryBuilder = knex.insert(achievement).into("foxy.dbc_achievement");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_ACHIEVEMENT, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_ACHIEVEMENT}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_ACHIEVEMENT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
