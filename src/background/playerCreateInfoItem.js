import { ipcMain } from "electron";

import {
  SEARCH_PLAYER_CREATE_INFO_ITEMS,
  STORE_PLAYER_CREATE_INFO_ITEM,
  FIND_PLAYER_CREATE_INFO_ITEM,
  UPDATE_PLAYER_CREATE_INFO_ITEM,
  DESTROY_PLAYER_CREATE_INFO_ITEM,
  CREATE_PLAYER_CREATE_INFO_ITEM,
  COPY_PLAYER_CREATE_INFO_ITEM,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_PLAYER_CREATE_INFO_ITEMS, (event, payload) => {
  let queryBuilder = knex
    .select([
      "pi.*",
      "it.name",
      "itl.Name as localeName",
      "it.Quality",
      "didi.InventoryIcon_1",
    ])
    .from("playercreateinfo_item as pi")
    .leftJoin("item_template as it", "pi.itemid", "it.entry")
    .leftJoin("item_template_locale as itl", function () {
      this.on("pi.itemid", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    })
    .leftJoin("foxy.dbc_item_display_info as didi", "it.displayid", "didi.ID")
    .where("pi.race", payload.race)
    .where("pi.class", payload.class);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_PLAYER_CREATE_INFO_ITEMS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_PLAYER_CREATE_INFO_ITEMS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_PLAYER_CREATE_INFO_ITEM, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("playercreateinfo_item");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_PLAYER_CREATE_INFO_ITEM, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_PLAYER_CREATE_INFO_ITEM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_PLAYER_CREATE_INFO_ITEM, (event, payload) => {
  let queryBuilder = knex.select().from("playercreateinfo_item").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_PLAYER_CREATE_INFO_ITEM, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_PLAYER_CREATE_INFO_ITEM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_PLAYER_CREATE_INFO_ITEM, (event, payload) => {
  let queryBuilder = knex
    .table("playercreateinfo_item")
    .where(payload.credential)
    .update(payload.playerCreateInfoItem);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_PLAYER_CREATE_INFO_ITEM, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_PLAYER_CREATE_INFO_ITEM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_PLAYER_CREATE_INFO_ITEM, (event, payload) => {
  let queryBuilder = knex
    .table("playercreateinfo_item")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_PLAYER_CREATE_INFO_ITEM, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_PLAYER_CREATE_INFO_ITEM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_PLAYER_CREATE_INFO_ITEM, (event, payload) => {
  let queryBuilder = knex
    .select("button")
    .from("playercreateinfo_item")
    .where(payload)
    .orderBy("button", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_PLAYER_CREATE_INFO_ITEM, {
        ...payload,
        button: rows.length > 0 ? rows[0].button + 1 : 0,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_PLAYER_CREATE_INFO_ITEM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_PLAYER_CREATE_INFO_ITEM, (event, payload) => {
  let itemid = null;
  let playerCreateInfoItem = null;

  let itemidQueryBuilder = knex
    .select("itemid")
    .from("playercreateinfo_item")
    .where("race", payload.race)
    .where("class", payload.class)
    .orderBy("itemid", "desc");
  let findPlayerCreateInfoItemBuilder = knex
    .select()
    .from("playercreateinfo_item")
    .where(payload);
  Promise.all([
    itemidQueryBuilder.then((rows) => {
      itemid = rows.length > 0 ? rows[0].itemid + 1 : 0;
    }),
    findPlayerCreateInfoItemBuilder.then((rows) => {
      playerCreateInfoItem = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      playerCreateInfoItem.itemid = itemid;
      let queryBuilder = knex
        .insert(playerCreateInfoItem)
        .into("playercreateinfo_item");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_PLAYER_CREATE_INFO_ITEM, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_PLAYER_CREATE_INFO_ITEM}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_PLAYER_CREATE_INFO_ITEM}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
