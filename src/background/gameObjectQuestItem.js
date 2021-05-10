import { ipcMain } from "electron";

import {
  SEARCH_GAME_OBJECT_QUEST_ITEMS,
  STORE_GAME_OBJECT_QUEST_ITEM,
  FIND_GAME_OBJECT_QUEST_ITEM,
  UPDATE_GAME_OBJECT_QUEST_ITEM,
  DESTROY_GAME_OBJECT_QUEST_ITEM,
  CREATE_GAME_OBJECT_QUEST_ITEM,
  COPY_GAME_OBJECT_QUEST_ITEM,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_GAME_OBJECT_QUEST_ITEMS, (event, payload) => {
  let queryBuilder = knex
    .select(["goqi.*", "it.name", "itl.Name as localeName"])
    .from("gameobject_questitem as goqi")
    .leftJoin("item_template as it", "goqi.ItemId", "it.entry")
    .leftJoin("item_template_locale as itl", function () {
      this.on("it.entry", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    })
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_GAME_OBJECT_QUEST_ITEMS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_GAME_OBJECT_QUEST_ITEMS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_GAME_OBJECT_QUEST_ITEM, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("gameobject_questitem");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_GAME_OBJECT_QUEST_ITEM, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_GAME_OBJECT_QUEST_ITEM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_GAME_OBJECT_QUEST_ITEM, (event, payload) => {
  let queryBuilder = knex.select().from("gameobject_questitem").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_GAME_OBJECT_QUEST_ITEM, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_GAME_OBJECT_QUEST_ITEM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_GAME_OBJECT_QUEST_ITEM, (event, payload) => {
  let queryBuilder = knex
    .table("gameobject_questitem")
    .where(payload.credential)
    .update(payload.gameObjectQuestItem);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_GAME_OBJECT_QUEST_ITEM, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_GAME_OBJECT_QUEST_ITEM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_GAME_OBJECT_QUEST_ITEM, (event, payload) => {
  let queryBuilder = knex.table("gameobject_questitem").where(payload).delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_GAME_OBJECT_QUEST_ITEM, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_GAME_OBJECT_QUEST_ITEM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_GAME_OBJECT_QUEST_ITEM, (event, payload) => {
  let queryBuilder = knex
    .select("Idx")
    .from("gameobject_questitem")
    .where(payload)
    .orderBy("Idx", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_GAME_OBJECT_QUEST_ITEM, {
        GameObjectEntry: payload.GameObjectEntry,
        Idx: rows.length > 0 ? rows[0].Idx + 1 : 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_GAME_OBJECT_QUEST_ITEM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_GAME_OBJECT_QUEST_ITEM, (event, payload) => {
  let idx = undefined;
  let gameObjectQuestItem = undefined;

  let idxQueryBuilder = knex
    .select("Idx")
    .from("gameobject_questitem")
    .where("GameObjectEntry", payload.GameObjectEntry)
    .orderBy("Idx", "desc");
  let findGameObjectQuestItemQueryBuilder = knex
    .select()
    .from("gameobject_questitem")
    .where(payload);
  Promise.all([
    idxQueryBuilder.then((rows) => {
      idx = rows.length > 0 ? rows[0].Idx : 1;
    }),
    findGameObjectQuestItemQueryBuilder.then((rows) => {
      gameObjectQuestItem = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      gameObjectQuestItem.Idx = idx + 1;
      let queryBuilder = knex
        .insert(gameObjectQuestItem)
        .into("gameobject_questitem");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_GAME_OBJECT_QUEST_ITEM, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_GAME_OBJECT_QUEST_ITEM}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_GAME_OBJECT_QUEST_ITEM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});
