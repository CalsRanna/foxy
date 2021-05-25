import { ipcMain } from "electron";

import {
  SEARCH_CREATURE_QUEST_ENDERS,
  STORE_CREATURE_QUEST_ENDER,
  FIND_CREATURE_QUEST_ENDER,
  UPDATE_CREATURE_QUEST_ENDER,
  DESTROY_CREATURE_QUEST_ENDER,
  COPY_CREATURE_QUEST_ENDER,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_CREATURE_QUEST_ENDERS, (event, payload) => {
  let queryBuilder = knex
    .select(["cqe.*", "ct.name", "ctl.Name as localeName"])
    .from("creature_questender as cqe")
    .leftJoin("creature_template as ct", function () {
      this.on("cqe.id", "=", "ct.entry");
    })
    .leftJoin("creature_template_locale as ctl", function () {
      this.on("ct.entry", "=", "ctl.entry").andOn(
        "ctl.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    })
    .where("cqe.quest", payload.quest);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_CREATURE_QUEST_ENDERS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_CREATURE_QUEST_ENDERS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_CREATURE_QUEST_ENDER, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("creature_questender");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_CREATURE_QUEST_ENDER, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_CREATURE_QUEST_ENDER}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_CREATURE_QUEST_ENDER, (event, payload) => {
  let queryBuilder = knex.select().from("creature_questender").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_CREATURE_QUEST_ENDER, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_CREATURE_QUEST_ENDER}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_CREATURE_QUEST_ENDER, (event, payload) => {
  let queryBuilder = knex
    .table("creature_questender")
    .where(payload.credential)
    .update(payload.creatureQuestEnder);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_CREATURE_QUEST_ENDER, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_CREATURE_QUEST_ENDER}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_CREATURE_QUEST_ENDER, (event, payload) => {
  let queryBuilder = knex.table("creature_questender").where(payload).delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_CREATURE_QUEST_ENDER, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_CREATURE_QUEST_ENDER}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_CREATURE_QUEST_ENDER, (event, payload) => {
  let id = undefined;
  let creatureQuestEnder = undefined;

  let idQueryBuilder = knex
    .select("id")
    .from("creature_questender")
    .where("quest", payload.quest)
    .orderBy("id", "desc");
  let findCreatureQuestEnderQueryBuilder = knex
    .select()
    .from("creature_questender")
    .where(payload);
  Promise.all([
    idQueryBuilder.then((rows) => {
      id = rows.length > 0 ? rows[0].id : 1;
    }),
    findCreatureQuestEnderQueryBuilder.then((rows) => {
      creatureQuestEnder = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      creatureQuestEnder.id = id + 1;
      let queryBuilder = knex
        .insert(creatureQuestEnder)
        .into("creature_questender");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_CREATURE_QUEST_ENDER, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_CREATURE_QUEST_ENDER}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_CREATURE_QUEST_ENDER}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
