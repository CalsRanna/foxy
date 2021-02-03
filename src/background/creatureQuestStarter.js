import { ipcMain } from "electron";

import {
  SEARCH_CREATURE_QUEST_STARTERS,
  STORE_CREATURE_QUEST_STARTER,
  FIND_CREATURE_QUEST_STARTER,
  UPDATE_CREATURE_QUEST_STARTER,
  DESTROY_CREATURE_QUEST_STARTER,
  COPY_CREATURE_QUEST_STARTER,
  GLOBAL_NOTICE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_CREATURE_QUEST_STARTERS, (event, payload) => {
  let queryBuilder = knex()
    .select(["cqs.*", "ct.name", "ctl.Name as localeName"])
    .from("creature_queststarter as cqs")
    .leftJoin("creature_template as ct", function() {
      this.on("cqs.id", "=", "ct.entry");
    })
    .leftJoin("creature_template_locale as ctl", function() {
      this.on("ct.entry", "=", "ctl.entry").andOn(
        "ctl.locale",
        "=",
        knex().raw("?", "zhCN")
      );
    })
    .where("cqs.quest", payload.quest);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_CREATURE_QUEST_STARTERS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_CREATURE_QUEST_STARTERS}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(STORE_CREATURE_QUEST_STARTER, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("creature_queststarter");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_CREATURE_QUEST_STARTER, rows);
      event.reply(GLOBAL_NOTICE, {
        category: "notification",
        title: "成功",
        message: "新建成功。",
        type: "success",
      });
    })
    .catch((error) => {
      event.reply(`${STORE_CREATURE_QUEST_STARTER}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(FIND_CREATURE_QUEST_STARTER, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("creature_queststarter")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_CREATURE_QUEST_STARTER, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_CREATURE_QUEST_STARTER}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(UPDATE_CREATURE_QUEST_STARTER, (event, payload) => {
  let queryBuilder = knex()
    .table("creature_queststarter")
    .where(payload.credential)
    .update(payload.creatureQuestStarter);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_CREATURE_QUEST_STARTER, rows);
      event.reply(GLOBAL_NOTICE, {
        category: "notification",
        title: "成功",
        message: "修改成功。",
        type: "success",
      });
    })
    .catch((error) => {
      event.reply(`${UPDATE_CREATURE_QUEST_STARTER}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(DESTROY_CREATURE_QUEST_STARTER, (event, payload) => {
  let queryBuilder = knex()
    .table("creature_queststarter")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_CREATURE_QUEST_STARTER, rows);
      event.reply("GLOBAL_NOTICE", {
        category: "notification",
        title: "成功",
        message: "删除成功。",
        type: "success",
      });
    })
    .catch((error) => {
      event.reply(`${DESTROY_CREATURE_QUEST_STARTER}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(COPY_CREATURE_QUEST_STARTER, (event, payload) => {
  let id = undefined;
  let creatureQuestStarter = undefined;

  let idQueryBuilder = knex()
    .select("id")
    .from("creature_queststarter")
    .where("quest", payload.quest)
    .orderBy("id", "desc");
  let findCreatureQuestStarterQueryBuilder = knex()
    .select()
    .from("creature_queststarter")
    .where(payload);
  Promise.all([
    idQueryBuilder.then((rows) => {
      id = rows.length > 0 ? rows[0].id : 1;
    }),
    findCreatureQuestStarterQueryBuilder.then((rows) => {
      creatureQuestStarter = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      creatureQuestStarter.id = id + 1;
      let queryBuilder = knex()
        .insert(creatureQuestStarter)
        .into("creature_queststarter");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_CREATURE_QUEST_STARTER, rows);
          event.reply(GLOBAL_NOTICE, {
            type: "success",
            category: "notification",
            title: "成功",
            message: `复制成功，新的装备模板id为${id + 1}。`,
          });
        })
        .catch((error) => {
          event.reply(`${COPY_CREATURE_QUEST_STARTER}_REJECT`, error);
        })
        .finally(() => {
          event.reply(GLOBAL_NOTICE, {
            category: "message",
            message: queryBuilder.toString(),
          });
        });
    })
    .catch((error) => {
      event.reply(`${COPY_CREATURE_QUEST_STARTER}_REJECT`, error);
    });
});
