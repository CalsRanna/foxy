import { ipcMain } from "electron";

import {
  SEARCH_GAME_OBJECT_QUEST_ENDERS,
  STORE_GAME_OBJECT_QUEST_ENDER,
  FIND_GAME_OBJECT_QUEST_ENDER,
  UPDATE_GAME_OBJECT_QUEST_ENDER,
  DESTROY_GAME_OBJECT_QUEST_ENDER,
  COPY_GAME_OBJECT_QUEST_ENDER,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_GAME_OBJECT_QUEST_ENDERS, (event, payload) => {
  let queryBuilder = knex()
    .select(["gqe.*", "gt.name", "gtl.Name as localeName"])
    .from("gameobject_questender as gqe")
    .leftJoin("gameobject_template as gt", function() {
      this.on("gqe.id", "=", "gt.entry");
    })
    .leftJoin("gameobject_template_locale as gtl", function() {
      this.on("gt.entry", "=", "gtl.entry").andOn(
        "gtl.locale",
        "=",
        knex().raw("?", "zhCN")
      );
    })
    .where("gqe.quest", payload.quest);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_GAME_OBJECT_QUEST_ENDERS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_GAME_OBJECT_QUEST_ENDERS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_GAME_OBJECT_QUEST_ENDER, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("gameobject_questender");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_GAME_OBJECT_QUEST_ENDER, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_GAME_OBJECT_QUEST_ENDER}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_GAME_OBJECT_QUEST_ENDER, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("gameobject_questender")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_GAME_OBJECT_QUEST_ENDER, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_GAME_OBJECT_QUEST_ENDER}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_GAME_OBJECT_QUEST_ENDER, (event, payload) => {
  let queryBuilder = knex()
    .table("gameobject_questender")
    .where(payload.credential)
    .update(payload.gameObjectQuestEnder);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_GAME_OBJECT_QUEST_ENDER, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_GAME_OBJECT_QUEST_ENDER}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_GAME_OBJECT_QUEST_ENDER, (event, payload) => {
  let queryBuilder = knex()
    .table("gameobject_questender")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_GAME_OBJECT_QUEST_ENDER, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_GAME_OBJECT_QUEST_ENDER}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_GAME_OBJECT_QUEST_ENDER, (event, payload) => {
  let id = undefined;
  let gameObjectQuestEnder = undefined;

  let idQueryBuilder = knex()
    .select("id")
    .from("gameobject_questender")
    .where("quest", payload.quest)
    .orderBy("id", "desc");
  let findGameObjectQuestEnderQueryBuilder = knex()
    .select()
    .from("gameobject_questender")
    .where(payload);
  Promise.all([
    idQueryBuilder.then((rows) => {
      id = rows.length > 0 ? rows[0].id : 1;
    }),
    findGameObjectQuestEnderQueryBuilder.then((rows) => {
      gameObjectQuestEnder = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      gameObjectQuestEnder.id = id + 1;
      let queryBuilder = knex()
        .insert(gameObjectQuestEnder)
        .into("gameobject_questender");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_GAME_OBJECT_QUEST_ENDER, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_GAME_OBJECT_QUEST_ENDER}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_GAME_OBJECT_QUEST_ENDER}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
