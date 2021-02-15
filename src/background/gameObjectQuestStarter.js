import { ipcMain } from "electron";

import {
  SEARCH_GAME_OBJECT_QUEST_STARTERS,
  STORE_GAME_OBJECT_QUEST_STARTER,
  FIND_GAME_OBJECT_QUEST_STARTER,
  UPDATE_GAME_OBJECT_QUEST_STARTER,
  DESTROY_GAME_OBJECT_QUEST_STARTER,
  COPY_GAME_OBJECT_QUEST_STARTER,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_GAME_OBJECT_QUEST_STARTERS, (event, payload) => {
  let queryBuilder = knex()
    .select(["gqs.*", "gt.name", "gtl.Name as localeName"])
    .from("gameobject_queststarter as gqs")
    .leftJoin("gameobject_template as gt", function() {
      this.on("gqs.id", "=", "gt.entry");
    })
    .leftJoin("gameobject_template_locale as gtl", function() {
      this.on("gt.entry", "=", "gtl.entry").andOn(
        "gtl.locale",
        "=",
        knex().raw("?", "zhCN")
      );
    })
    .where("gqs.quest", payload.quest);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_GAME_OBJECT_QUEST_STARTERS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_GAME_OBJECT_QUEST_STARTERS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_GAME_OBJECT_QUEST_STARTER, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("gameobject_queststarter");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_GAME_OBJECT_QUEST_STARTER, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_GAME_OBJECT_QUEST_STARTER}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_GAME_OBJECT_QUEST_STARTER, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("gameobject_queststarter")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(
        FIND_GAME_OBJECT_QUEST_STARTER,
        rows.length > 0 ? rows[0] : {}
      );
    })
    .catch((error) => {
      event.reply(`${FIND_GAME_OBJECT_QUEST_STARTER}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_GAME_OBJECT_QUEST_STARTER, (event, payload) => {
  let queryBuilder = knex()
    .table("gameobject_queststarter")
    .where(payload.credential)
    .update(payload.gameObjectQuestStarter);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_GAME_OBJECT_QUEST_STARTER, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_GAME_OBJECT_QUEST_STARTER}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_GAME_OBJECT_QUEST_STARTER, (event, payload) => {
  let queryBuilder = knex()
    .table("gameobject_queststarter")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_GAME_OBJECT_QUEST_STARTER, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_GAME_OBJECT_QUEST_STARTER}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_GAME_OBJECT_QUEST_STARTER, (event, payload) => {
  let id = undefined;
  let gameObjectQuestStarter = undefined;

  let idQueryBuilder = knex()
    .select("id")
    .from("gameobject_queststarter")
    .where("quest", payload.quest)
    .orderBy("id", "desc");
  let findGameObjectQuestStarterQueryBuilder = knex()
    .select()
    .from("gameobject_queststarter")
    .where(payload);
  Promise.all([
    idQueryBuilder.then((rows) => {
      id = rows.length > 0 ? rows[0].id : 1;
    }),
    findGameObjectQuestStarterQueryBuilder.then((rows) => {
      gameObjectQuestStarter = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      gameObjectQuestStarter.id = id + 1;
      let queryBuilder = knex()
        .insert(gameObjectQuestStarter)
        .into("gameobject_queststarter");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_GAME_OBJECT_QUEST_STARTER, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_GAME_OBJECT_QUEST_STARTER}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_GAME_OBJECT_QUEST_STARTER}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
