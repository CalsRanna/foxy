import { ipcMain } from "electron";

import {
  SEARCH_REFERENCE_LOOT_TEMPLATES,
  COUNT_REFERENCE_LOOT_TEMPLATES,
  STORE_REFERENCE_LOOT_TEMPLATE,
  FIND_REFERENCE_LOOT_TEMPLATE,
  UPDATE_REFERENCE_LOOT_TEMPLATE,
  DESTROY_REFERENCE_LOOT_TEMPLATE,
  COPY_REFERENCE_LOOT_TEMPLATE,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_REFERENCE_LOOT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex
    .select([
      "rlt.*",
      "it.name",
      "itl.Name as localeName",
      "it.Quality",
      "didi.InventoryIcon_1",
    ])
    .from("reference_loot_template as rlt")
    .leftJoin("item_template as it", "rlt.Item", "it.entry")
    .leftJoin("item_template_locale as itl", function () {
      this.on("it.entry", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    })
    .leftJoin("foxy.dbc_item_display_info as didi", "it.displayid", "didi.ID");
  if (payload.Entry) {
    queryBuilder = queryBuilder.where("rlt.Entry", payload.Entry);
  }
  if (payload.name) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("it.name", "like", `%${payload.name}%`)
        .orWhere("itl.Name", "like", `%${payload.name}%`)
    );
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_REFERENCE_LOOT_TEMPLATES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_REFERENCE_LOOT_TEMPLATES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_REFERENCE_LOOT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex
    .count("* as total")
    .from("reference_loot_template as rlt")
    .leftJoin("item_template as it", "rlt.Item", "it.entry")
    .leftJoin("item_template_locale as itl", function () {
      this.on("it.entry", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    });
  if (payload.Entry) {
    queryBuilder = queryBuilder.where("rlt.Entry", payload.Entry);
  }
  if (payload.name) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("it.name", "like", `%${payload.name}%`)
        .orWhere("itl.Name", "like", `%${payload.name}%`)
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_REFERENCE_LOOT_TEMPLATES, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_REFERENCE_LOOT_TEMPLATES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_REFERENCE_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("reference_loot_template");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_REFERENCE_LOOT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_REFERENCE_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_REFERENCE_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex
    .select()
    .from("reference_loot_template")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_REFERENCE_LOOT_TEMPLATE, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_REFERENCE_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_REFERENCE_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex
    .table("reference_loot_template")
    .where(payload.credential)
    .update(payload.referenceLootTemplate);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_REFERENCE_LOOT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_REFERENCE_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_REFERENCE_LOOT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex
    .table("reference_loot_template")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_REFERENCE_LOOT_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_REFERENCE_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_REFERENCE_LOOT_TEMPLATE, (event, payload) => {
  let item = undefined;
  let referenceLootTemplate = undefined;

  let itemQueryBuilder = knex
    .select("Item")
    .from("reference_loot_template")
    .where("Entry", payload.Entry)
    .orderBy("Item", "desc");
  let findCreatureLootTempalteQueryBuilder = knex
    .select()
    .from("reference_loot_template")
    .where(payload);
  Promise.all([
    itemQueryBuilder.then((rows) => {
      item = rows.length > 0 ? rows[0].Item : 0;
    }),
    findCreatureLootTempalteQueryBuilder.then((rows) => {
      referenceLootTemplate = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      referenceLootTemplate.Item = item + 1;
      if (referenceLootTemplate.Reference != 0) {
        referenceLootTemplate.Reference = item + 1;
      }
      let queryBuilder = knex
        .insert(referenceLootTemplate)
        .into("reference_loot_template");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_REFERENCE_LOOT_TEMPLATE, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_REFERENCE_LOOT_TEMPLATE}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_REFERENCE_LOOT_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
