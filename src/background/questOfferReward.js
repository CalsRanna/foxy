import { ipcMain } from "electron";

import {
  STORE_QUEST_OFFER_REWARD,
  FIND_QUEST_OFFER_REWARD,
  UPDATE_QUEST_OFFER_REWARD,
  GLOBAL_NOTICE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(STORE_QUEST_OFFER_REWARD, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("quest_offer_reward");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_QUEST_OFFER_REWARD, rows);
      event.reply(GLOBAL_NOTICE, {
        category: "notification",
        title: "成功",
        message: "新建成功。",
        type: "success",
      });
    })
    .catch((error) => {
      event.reply(`${STORE_QUEST_OFFER_REWARD}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(FIND_QUEST_OFFER_REWARD, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("quest_offer_reward")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_QUEST_OFFER_REWARD, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_QUEST_OFFER_REWARD}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(UPDATE_QUEST_OFFER_REWARD, (event, payload) => {
  let queryBuilder = knex()
    .table("quest_offer_reward")
    .where(payload.credential)
    .update(payload.questOfferReward);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_QUEST_OFFER_REWARD, rows);
      event.reply(GLOBAL_NOTICE, {
        category: "notification",
        title: "成功",
        message: "修改成功。",
        type: "success",
      });
    })
    .catch((error) => {
      event.reply(`${UPDATE_QUEST_OFFER_REWARD}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});
