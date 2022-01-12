import { ipcMain } from "electron";

import {
  SEARCH_ACHIEVEMENT_CRITERIA_DATAS,
  STORE_ACHIEVEMENT_CRITERIA_DATA,
  FIND_ACHIEVEMENT_CRITERIA_DATA,
  UPDATE_ACHIEVEMENT_CRITERIA_DATA,
  DESTROY_ACHIEVEMENT_CRITERIA_DATA,
  CREATE_ACHIEVEMENT_CRITERIA_DATA,
  COPY_ACHIEVEMENT_CRITERIA_DATA,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_ACHIEVEMENT_CRITERIA_DATAS, (event, payload) => {
  let queryBuilder = knex
    .select()
    .from("achievement_criteria_data")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_ACHIEVEMENT_CRITERIA_DATAS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_ACHIEVEMENT_CRITERIA_DATAS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_ACHIEVEMENT_CRITERIA_DATA, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("achievement_criteria_data");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_ACHIEVEMENT_CRITERIA_DATA, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_ACHIEVEMENT_CRITERIA_DATA}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_ACHIEVEMENT_CRITERIA_DATA, (event, payload) => {
  let queryBuilder = knex
    .select()
    .from("achievement_criteria_data")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(
        FIND_ACHIEVEMENT_CRITERIA_DATA,
        rows.length > 0 ? rows[0] : {}
      );
    })
    .catch((error) => {
      event.reply(`${FIND_ACHIEVEMENT_CRITERIA_DATA}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_ACHIEVEMENT_CRITERIA_DATA, (event, payload) => {
  let queryBuilder = knex
    .table("achievement_criteria_data")
    .where(payload.credential)
    .update(payload.achievementCriteriaData);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_ACHIEVEMENT_CRITERIA_DATA, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_ACHIEVEMENT_CRITERIA_DATA}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_ACHIEVEMENT_CRITERIA_DATA, (event, payload) => {
  let queryBuilder = knex
    .table("achievement_criteria_data")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_ACHIEVEMENT_CRITERIA_DATA, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_ACHIEVEMENT_CRITERIA_DATA}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_ACHIEVEMENT_CRITERIA_DATA, (event, payload) => {
  let queryBuilder = knex
    .select("type")
    .from("achievement_criteria_data")
    .where(payload)
    .orderBy("type", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_ACHIEVEMENT_CRITERIA_DATA, {
        criteria_id: payload.criteria_id,
        type: rows.length > 0 ? rows[0].type + 1 : 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_ACHIEVEMENT_CRITERIA_DATA}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_ACHIEVEMENT_CRITERIA_DATA, (event, payload) => {
  let type = undefined;
  let achievementCriteriaData = undefined;

  let typeQueryBuilder = knex
    .select("type")
    .from("achievement_criteria_data")
    .where("criteria_id", payload.criteria_id)
    .orderBy("type", "desc");
  let findAchievementCriteriaDataQueryBuilder = knex
    .select()
    .from("achievement_criteria_data")
    .where(payload);
  Promise.all([
    typeQueryBuilder.then((rows) => {
      type = rows.length > 0 ? rows[0].type : 1;
    }),
    findAchievementCriteriaDataQueryBuilder.then((rows) => {
      achievementCriteriaData = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      achievementCriteriaData.type = type + 1;
      let queryBuilder = knex
        .insert(achievementCriteriaData)
        .into("achievement_criteria_data");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_ACHIEVEMENT_CRITERIA_DATA, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_ACHIEVEMENT_CRITERIA_DATA}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_ACHIEVEMENT_CRITERIA_DATA}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
