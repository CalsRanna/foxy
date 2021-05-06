import { ipcMain } from "electron";

import {
  SEARCH_ITEM_TEMPLATES,
  COUNT_ITEM_TEMPLATES,
  STORE_ITEM_TEMPLATE,
  FIND_ITEM_TEMPLATE,
  UPDATE_ITEM_TEMPLATE,
  DESTROY_ITEM_TEMPLATE,
  CREATE_ITEM_TEMPLATE,
  COPY_ITEM_TEMPLATE,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_ITEM_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select([
      "it.entry",
      "it.name",
      "itl.Name as localeName",
      "it.Quality",
      "it.displayid",
      "it.class",
      "it.subclass",
      "it.InventoryType",
      "it.ItemLevel",
      "it.RequiredLevel",
    ])
    .from("item_template as it")
    .leftJoin("item_template_locale as itl", function () {
      this.on("it.entry", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex().raw("?", "zhCN")
      );
    });
  if (payload.entry) {
    queryBuilder = queryBuilder.where("it.entry", "like", `%${payload.entry}%`);
  }
  if (payload.name) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("it.name", "like", `%${payload.name}%`)
        .orWhere("itl.Name", "like", `%${payload.name}%`)
    );
  }
  if (payload.description) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("it.description", "like", `%${payload.description}%`)
        .orWhere("itl.Description", "like", `%${payload.description}%`)
    );
  }
  if (payload.class != undefined) {
    queryBuilder = queryBuilder.where("it.class", payload.class);
  }
  if (payload.subclass != undefined) {
    queryBuilder = queryBuilder.where("it.subclass", payload.subclass);
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_ITEM_TEMPLATES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_ITEM_TEMPLATES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_ITEM_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("item_template as it")
    .leftJoin("item_template_locale as itl", function () {
      this.on("it.entry", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex().raw("?", "zhCN")
      );
    });
  if (payload.entry) {
    queryBuilder = queryBuilder.where("it.entry", "like", `%${payload.entry}%`);
  }
  if (payload.name) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("it.name", "like", `%${payload.name}%`)
        .orWhere("itl.Name", "like", `%${payload.name}%`)
    );
  }
  if (payload.description) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("it.description", "like", `%${payload.description}%`)
        .orWhere("itl.Description", "like", `%${payload.description}%`)
    );
  }
  if (payload.class != undefined) {
    queryBuilder = queryBuilder.where("it.class", payload.class);
  }
  if (payload.subclass != undefined) {
    queryBuilder = queryBuilder.where("it.subclass", payload.subclass);
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_ITEM_TEMPLATES, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_ITEM_TEMPLATES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_ITEM_TEMPLATE, (event, payload) => {
  let queryBuilder = knex().insert(payload).into("item_template");

  queryBuilder
    .then((rows) => {
      knex()
        .insert({
          ID: payload.entry,
          ClassID: payload.class,
          SubclassID: payload.subclass,
          Sound_Override_Subclassid: payload.SoundOverrideSubclass,
          Material: payload.Material,
          DisplayInfoID: payload.displayid,
          InventoryType: payload.InventoryType,
          SheatheType: payload.sheath,
        })
        .into("foxy.dbc_item")
        .then(() => {
          event.reply(STORE_ITEM_TEMPLATE, rows);
        })
        .catch((error) => {
          event.reply(`${STORE_ITEM_TEMPLATE}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
        });
    })
    .catch((error) => {
      event.reply(`${STORE_ITEM_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_ITEM_TEMPLATE, (event, payload) => {
  let queryBuilder = knex().select().from("item_template").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_ITEM_TEMPLATE, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_ITEM_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_ITEM_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("item_template")
    .where(payload.credential)
    .update(payload.itemTemplate);

  queryBuilder
    .then((rows) => {
      knex()
        .table("foxy.dbc_item")
        .where({
          ID: payload.credential.entry,
        })
        .update({
          ID: payload.itemTemplate.entry,
          ClassID: payload.itemTemplate.class,
          SubclassID: payload.itemTemplate.subclass,
          Sound_Override_Subclassid: payload.itemTemplate.SoundOverrideSubclass,
          Material: payload.itemTemplate.Material,
          DisplayInfoID: payload.itemTemplate.displayid,
          InventoryType: payload.itemTemplate.InventoryType,
          SheatheType: payload.itemTemplate.sheath,
        })
        .then(() => {
          event.reply(UPDATE_ITEM_TEMPLATE, rows);
        })
        .catch((error) => {
          event.reply(`${UPDATE_ITEM_TEMPLATE}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
        });
    })
    .catch((error) => {
      event.reply(`${UPDATE_ITEM_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_ITEM_TEMPLATE, (event, payload) => {
  let queryBuilder = knex().table("item_template").where(payload).delete();

  queryBuilder
    .then((rows) => {
      knex()
        .table("foxy.dbc_item")
        .where({ ID: payload.entry })
        .delete()
        .then(() => {
          event.reply(DESTROY_ITEM_TEMPLATE, rows);
        })
        .catch((error) => {
          event.reply(`${DESTROY_ITEM_TEMPLATE}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
        });
    })
    .catch((error) => {
      event.reply(`${DESTROY_ITEM_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_ITEM_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .select("entry")
    .from("item_template")
    .orderBy("entry", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_ITEM_TEMPLATE, {
        entry: rows[0].entry + 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_ITEM_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_ITEM_TEMPLATE, (event, payload) => {
  let entry = undefined;
  let itemTemplate = undefined;

  let entryQueryBuilder = knex()
    .select("entry")
    .from("item_template")
    .orderBy("entry", "desc");
  let findItemTemplateQueryBuilder = knex()
    .select()
    .from("item_template")
    .where(payload);
  Promise.all([
    entryQueryBuilder.then((rows) => {
      entry = rows[0].entry;
    }),
    findItemTemplateQueryBuilder.then((rows) => {
      itemTemplate = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      itemTemplate.entry = entry + 1;
      let queryBuilder = knex().insert(itemTemplate).into("item_template");
      queryBuilder
        .then((rows) => {
          knex()
            .insert({
              ID: itemTemplate.entry,
              ClassID: itemTemplate.class,
              SubclassID: itemTemplate.subclass,
              Sound_Override_Subclassid: itemTemplate.SoundOverrideSubclass,
              Material: itemTemplate.Material,
              DisplayInfoID: itemTemplate.displayid,
              InventoryType: itemTemplate.InventoryType,
              SheatheType: itemTemplate.sheath,
            })
            .into("foxy.dbc_item")
            .then(() => {
              event.reply(COPY_ITEM_TEMPLATE, rows);
            })
            .catch((error) => {
              event.reply(`${COPY_ITEM_TEMPLATE}_REJECT`, error);
              event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
            });
        })
        .catch((error) => {
          event.reply(`${COPY_ITEM_TEMPLATE}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_ITEM_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});
