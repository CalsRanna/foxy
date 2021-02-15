import { ipcMain } from "electron";

import {
  SEARCH_CREATURE_QUEST_ITEMS,
  STORE_CREATURE_QUEST_ITEM,
  FIND_CREATURE_QUEST_ITEM,
  UPDATE_CREATURE_QUEST_ITEM,
  DESTROY_CREATURE_QUEST_ITEM,
  CREATE_CREATURE_QUEST_ITEM,
  COPY_CREATURE_QUEST_ITEM,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_CREATURE_QUEST_ITEMS, (event, payload) => {
  let queryBuilder = knex()
    .select(["cq.*", "it.name", "itl.Name as localeName"])
    .from("creature_questitem as cq")
    .leftJoin("item_template as it", "cq.ItemId", "it.entry")
    .leftJoin("item_template_locale as itl", function() {
      this.on("it.entry", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex().raw("?", "zhCN")
      );
    })
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_CREATURE_QUEST_ITEMS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_CREATURE_QUEST_ITEMS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_CREATURE_QUEST_ITEM, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("creature_questitem");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_CREATURE_QUEST_ITEM, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_CREATURE_QUEST_ITEM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_CREATURE_QUEST_ITEM, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("creature_questitem")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_CREATURE_QUEST_ITEM, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_CREATURE_QUEST_ITEM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_CREATURE_QUEST_ITEM, (event, payload) => {
  let queryBuilder = knex()
    .table("creature_questitem")
    .where(payload.credential)
    .update(payload.creatureQuestItem);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_CREATURE_QUEST_ITEM, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_CREATURE_QUEST_ITEM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_CREATURE_QUEST_ITEM, (event, payload) => {
  let queryBuilder = knex()
    .table("creature_questitem")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_CREATURE_QUEST_ITEM, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_CREATURE_QUEST_ITEM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_CREATURE_QUEST_ITEM, (event, payload) => {
  let queryBuilder = knex()
    .select("Idx")
    .from("creature_questitem")
    .where(payload)
    .orderBy("Idx", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_CREATURE_QUEST_ITEM, {
        CreatureEntry: payload.CreatureEntry,
        Idx: rows.length > 0 ? rows[0].Idx + 1 : 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_CREATURE_QUEST_ITEM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_CREATURE_QUEST_ITEM, (event, payload) => {
  let idx = undefined;
  let creatureQuestItem = undefined;

  let idxQueryBuilder = knex()
    .select("Idx")
    .from("creature_questitem")
    .where("CreatureEntry", payload.CreatureEntry)
    .orderBy("Idx", "desc");
  let findCreatureQuestItemQueryBuilder = knex()
    .select()
    .from("creature_questitem")
    .where(payload);
  Promise.all([
    idxQueryBuilder.then((rows) => {
      idx = rows.length > 0 ? rows[0].Idx : 1;
    }),
    findCreatureQuestItemQueryBuilder.then((rows) => {
      creatureQuestItem = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      creatureQuestItem.Idx = idx + 1;
      let queryBuilder = knex()
        .insert(creatureQuestItem)
        .into("creature_questitem");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_CREATURE_QUEST_ITEM, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_CREATURE_QUEST_ITEM}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_CREATURE_QUEST_ITEM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
