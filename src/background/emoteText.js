import { ipcMain } from "electron";

import {
  SEARCH_EMOTE_TEXTS,
  COUNT_EMOTE_TEXTS,
  STORE_EMOTE_TEXT,
  FIND_EMOTE_TEXT,
  UPDATE_EMOTE_TEXT,
  DESTROY_EMOTE_TEXT,
  CREATE_EMOTE_TEXT,
  COPY_EMOTE_TEXT,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_EMOTE_TEXTS, (event, payload) => {
  let queryBuilder = knex
    .select(["ID", "Name", "EmoteID"])
    .from("foxy.dbc_emotes_text");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.Name) {
    queryBuilder = queryBuilder.where("Name", "like", `%${payload.Name}%`);
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_EMOTE_TEXTS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_EMOTE_TEXTS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_EMOTE_TEXTS, (event, payload) => {
  let queryBuilder = knex.count("* as total").from("foxy.dbc_emotes_text");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ID", payload.ID);
  }
  if (payload.Name) {
    queryBuilder = queryBuilder.where("Name", "like", `%${payload.Name}%`);
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_EMOTE_TEXTS, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_EMOTE_TEXTS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_EMOTE_TEXT, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("foxy.dbc_emotes_text");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_EMOTE_TEXT, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_EMOTE_TEXT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_EMOTE_TEXT, (event, payload) => {
  let queryBuilder = knex.select().from("foxy.dbc_emotes_text").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_EMOTE_TEXT, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_EMOTE_TEXT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_EMOTE_TEXT, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_emotes_text")
    .where(payload.credential)
    .update(payload.emoteText);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_EMOTE_TEXT, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_EMOTE_TEXT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_EMOTE_TEXT, (event, payload) => {
  let queryBuilder = knex.table("foxy.dbc_emotes_text").where(payload).delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_EMOTE_TEXT, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_EMOTE_TEXT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_EMOTE_TEXT, (event, payload) => {
  let queryBuilder = knex
    .select("ID")
    .from("foxy.dbc_emotes_text")
    .orderBy("ID", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_EMOTE_TEXT, {
        ID: rows[0].ID + 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_EMOTE_TEXT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_EMOTE_TEXT, (event, payload) => {
  let ID = undefined;
  let emoteText = undefined;

  let IDQueryBuilder = knex
    .select("ID")
    .from("foxy.dbc_emotes_text")
    .orderBy("ID", "desc");
  let findEmoteTextQueryBuilder = knex
    .select()
    .from("foxy.dbc_emotes_text")
    .where(payload);
  Promise.all([
    IDQueryBuilder.then((rows) => {
      ID = rows[0].ID;
    }),
    findEmoteTextQueryBuilder.then((rows) => {
      emoteText = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      emoteText.ID = ID + 1;
      let queryBuilder = knex.insert(emoteText).into("foxy.dbc_emotes_text");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_EMOTE_TEXT, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_EMOTE_TEXT}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_EMOTE_TEXT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
