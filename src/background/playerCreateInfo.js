import { ipcMain } from "electron";

import {
  SEARCH_PLAYER_CREATE_INFOS,
  COUNT_PLAYER_CREATE_INFOS,
  STORE_PLAYER_CREATE_INFO,
  FIND_PLAYER_CREATE_INFO,
  UPDATE_PLAYER_CREATE_INFO,
  DESTROY_PLAYER_CREATE_INFO,
  CREATE_PLAYER_CREATE_INFO,
  COPY_PLAYER_CREATE_INFO,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_PLAYER_CREATE_INFOS, (event, payload) => {
  let queryBuilder = knex.select().from("playercreateinfo");
  if (payload.race) {
    queryBuilder = queryBuilder.where("race", payload.race);
  }
  if (payload.class) {
    queryBuilder = queryBuilder.where("class", payload.class);
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_PLAYER_CREATE_INFOS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_PLAYER_CREATE_INFOS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_PLAYER_CREATE_INFOS, (event, payload) => {
  let queryBuilder = knex.count("* as total").from("playercreateinfo");
  if (payload.race) {
    queryBuilder = queryBuilder.where("race", payload.race);
  }
  if (payload.class) {
    queryBuilder = queryBuilder.where("class", payload.class);
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_PLAYER_CREATE_INFOS, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_PLAYER_CREATE_INFOS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_PLAYER_CREATE_INFO, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("playercreateinfo");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_PLAYER_CREATE_INFO, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_PLAYER_CREATE_INFO}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_PLAYER_CREATE_INFO, (event, payload) => {
  let queryBuilder = knex.select().from("playercreateinfo").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_PLAYER_CREATE_INFO, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_PLAYER_CREATE_INFO}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_PLAYER_CREATE_INFO, (event, payload) => {
  let queryBuilder = knex
    .table("playercreateinfo")
    .where(payload.credential)
    .update(payload.playerCreateInfo);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_PLAYER_CREATE_INFO, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_PLAYER_CREATE_INFO}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_PLAYER_CREATE_INFO, (event, payload) => {
  let queryBuilder = knex.table("playercreateinfo").where(payload).delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_PLAYER_CREATE_INFO, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_PLAYER_CREATE_INFO}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_PLAYER_CREATE_INFO, (event, payload) => {
  let builder = knex.select().from("playercreateinfo").where(payload);
  builder
    .then((rows) => {
      let playerCreateInfo = rows.length > 0 ? rows[0] : {};
      playerCreateInfo.class += 1;
      let queryBuilder = knex.insert(playerCreateInfo).into("playercreateinfo");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_PLAYER_CREATE_INFO, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_PLAYER_CREATE_INFO}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_PLAYER_CREATE_INFO}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
