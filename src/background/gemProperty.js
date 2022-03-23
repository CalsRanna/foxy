import { ipcMain } from "electron";

import {
  SEARCH_GEM_PROPERTIES,
  COUNT_GEM_PROPERTIES,
  STORE_GEM_PROPERTY,
  FIND_GEM_PROPERTY,
  UPDATE_GEM_PROPERTY,
  DESTROY_GEM_PROPERTY,
  CREATE_GEM_PROPERTY,
  COPY_GEM_PROPERTY,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_GEM_PROPERTIES, (event, payload) => {
  let queryBuilder = knex
    .select(["dgp.*", "dsie.Name_Lang_zhCN"])
    .from("foxy.dbc_gem_properties as dgp")
    .leftJoin(
      "foxy.dbc_spell_item_enchantment as dsie",
      "dgp.Enchant_ID",
      "dsie.ID"
    );
  if (payload.ID) {
    queryBuilder = queryBuilder.where("dgp.ID", payload.ID);
  }
  if (payload.Name) {
    queryBuilder = queryBuilder.where(
      "dsie.Name_Lang_zhCN",
      "like",
      `%${payload.Name}%`
    );
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_GEM_PROPERTIES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_GEM_PROPERTIES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_GEM_PROPERTIES, (event, payload) => {
  let queryBuilder = knex
    .count("* as total")
    .from("foxy.dbc_gem_properties as dgp")
    .leftJoin(
      "foxy.dbc_spell_item_enchantment as dsie",
      "dgp.Enchant_ID",
      "dsie.ID"
    );
  if (payload.ID) {
    queryBuilder = queryBuilder.where("dgp.ID", payload.ID);
  }
  if (payload.Name) {
    queryBuilder = queryBuilder.where(
      "dsie.Name_Lang_zhCN",
      "like",
      `%${payload.Name}%`
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_GEM_PROPERTIES, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_GEM_PROPERTIES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_GEM_PROPERTY, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("foxy.dbc_gem_properties");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_GEM_PROPERTY, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_GEM_PROPERTY}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_GEM_PROPERTY, (event, payload) => {
  let queryBuilder = knex
    .select()
    .from("foxy.dbc_gem_properties")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_GEM_PROPERTY, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_GEM_PROPERTY}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_GEM_PROPERTY, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_gem_properties")
    .where(payload.credential)
    .update(payload.gemProperty);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_GEM_PROPERTY, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_GEM_PROPERTY}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_GEM_PROPERTY, (event, payload) => {
  let queryBuilder = knex
    .table("foxy.dbc_gem_properties")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_GEM_PROPERTY, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_GEM_PROPERTY}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_GEM_PROPERTY, (event, payload) => {
  let queryBuilder = knex
    .select("ID")
    .from("foxy.dbc_gem_properties")
    .orderBy("ID", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_GEM_PROPERTY, {
        ID: rows[0].ID + 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_GEM_PROPERTY}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_GEM_PROPERTY, (event, payload) => {
  let ID = undefined;
  let gemProperty = undefined;

  let IDQueryBuilder = knex
    .select("ID")
    .from("foxy.dbc_gem_properties")
    .orderBy("ID", "desc");
  let findGlyphPropertyQueryBuilder = knex
    .select()
    .from("foxy.dbc_gem_properties")
    .where(payload);
  Promise.all([
    IDQueryBuilder.then((rows) => {
      ID = rows[0].ID;
    }),
    findGlyphPropertyQueryBuilder.then((rows) => {
      gemProperty = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      gemProperty.ID = ID + 1;
      let queryBuilder = knex
        .insert(gemProperty)
        .into("foxy.dbc_gem_properties");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_GEM_PROPERTY, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_GEM_PROPERTY}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_GEM_PROPERTY}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
