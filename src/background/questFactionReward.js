import { ipcMain } from "electron";

import {
  SEARCH_QUEST_FACTION_REWARDS,
  COUNT_QUEST_FACTION_REWARDS,
  STORE_QUEST_FACTION_REWARD,
  FIND_QUEST_FACTION_REWARD,
  UPDATE_QUEST_FACTION_REWARD,
  DESTROY_QUEST_FACTION_REWARD,
  CREATE_QUEST_FACTION_REWARD,
  COPY_QUEST_FACTION_REWARD,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_QUEST_FACTION_REWARDS, (event, payload) => {
  let queryBuilder = knex.select().from("foxy.dbc_quest_faction_reward");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_QUEST_FACTION_REWARDS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_QUEST_FACTION_REWARDS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_QUEST_FACTION_REWARDS, (event, payload) => {
  let queryBuilder = knex
    .count("* as total")
    .from("foxy.dbc_quest_faction_reward");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_QUEST_FACTION_REWARDS, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_QUEST_FACTION_REWARDS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_QUEST_FACTION_REWARD, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("foxy.dbc_quest_faction_reward");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_QUEST_FACTION_REWARD, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_QUEST_FACTION_REWARD}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_QUEST_FACTION_REWARD, (event, payload) => {
  let queryBuilder = knex
    .select()
    .from("foxy.dbc_quest_faction_reward")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_QUEST_FACTION_REWARD, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_QUEST_FACTION_REWARD}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_QUEST_FACTION_REWARD, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_quest_faction_reward")
    .where(payload.credential)
    .update(payload.questFactionReward);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_QUEST_FACTION_REWARD, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_QUEST_FACTION_REWARD}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_QUEST_FACTION_REWARD, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_quest_faction_reward")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_QUEST_FACTION_REWARD, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_QUEST_FACTION_REWARD}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_QUEST_FACTION_REWARD, (event, payload) => {
  let queryBuilder = knex
    .select("ID")
    .from("foxy.dbc_quest_faction_reward")
    .orderBy("ID", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_QUEST_FACTION_REWARD, {
        ID: rows[0].ID + 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_QUEST_FACTION_REWARD}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_QUEST_FACTION_REWARD, (event, payload) => {
  let ID = undefined;
  let questFactionReward = undefined;

  let IDQueryBuilder = knex
    .select("ID")
    .from("foxy.dbc_quest_faction_reward")
    .orderBy("ID", "desc");
  let findQuestFactionRewardQueryBuilder = knex
    .select()
    .from("foxy.dbc_quest_faction_reward")
    .where(payload);
  Promise.all([
    IDQueryBuilder.then((rows) => {
      ID = rows[0].ID;
    }),
    findQuestFactionRewardQueryBuilder.then((rows) => {
      questFactionReward = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      questFactionReward.ID = ID + 1;
      let queryBuilder = knex
        .insert(questFactionReward)
        .into("foxy.dbc_quest_faction_reward");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_QUEST_FACTION_REWARD, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_QUEST_FACTION_REWARD}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_QUEST_FACTION_REWARD}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
