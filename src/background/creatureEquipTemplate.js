import { ipcMain } from "electron";

import {
  SEARCH_CREATURE_EQUIP_TEMPLATES,
  STORE_CREATURE_EQUIP_TEMPLATE,
  FIND_CREATURE_EQUIP_TEMPLATE,
  UPDATE_CREATURE_EQUIP_TEMPLATE,
  DESTROY_CREATURE_EQUIP_TEMPLATE,
  CREATE_CREATURE_EQUIP_TEMPLATE,
  COPY_CREATURE_EQUIP_TEMPLATE,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_CREATURE_EQUIP_TEMPLATES, (event, payload) => {
  let queryBuilder = knex
    .select([
      "cet.*",
      "it1.name as name_1",
      "itl1.Name as localeName_1",
      "it1.Quality as Quality_1",
      "didi1.InventoryIcon_1 as Icon_1",
      "it2.name as name_2",
      "itl2.Name as localeName_2",
      "it2.Quality as Quality_2",
      "didi2.InventoryIcon_1 as Icon_2",
      "it3.name as name_3",
      "itl3.Name as localeName_3",
      "it3.Quality as Quality_3",
      "didi3.InventoryIcon_1 as Icon_3",
    ])
    .from("creature_equip_template as cet")
    .leftJoin("item_template as it1", "cet.ItemID1", "it1.entry")
    .leftJoin("item_template_locale as itl1", function () {
      this.on("cet.ItemID1", "=", "itl1.ID").andOn(
        "itl1.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    })
    .leftJoin(
      "foxy.dbc_item_display_info as didi1",
      "it1.displayid",
      "didi1.ID"
    )
    .leftJoin("item_template as it2", "cet.ItemID2", "it2.entry")
    .leftJoin("item_template_locale as itl2", function () {
      this.on("cet.ItemID2", "=", "itl2.ID").andOn(
        "itl2.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    })
    .leftJoin(
      "foxy.dbc_item_display_info as didi2",
      "it2.displayid",
      "didi2.ID"
    )
    .leftJoin("item_template as it3", "cet.ItemID3", "it3.entry")
    .leftJoin("item_template_locale as itl3", function () {
      this.on("cet.ItemID3", "=", "itl3.ID").andOn(
        "itl3.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    })
    .leftJoin(
      "foxy.dbc_item_display_info as didi3",
      "it3.displayid",
      "didi3.ID"
    )
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_CREATURE_EQUIP_TEMPLATES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_CREATURE_EQUIP_TEMPLATES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_CREATURE_EQUIP_TEMPLATE, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("creature_equip_template");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_CREATURE_EQUIP_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_CREATURE_EQUIP_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_CREATURE_EQUIP_TEMPLATE, (event, payload) => {
  let queryBuilder = knex
    .select()
    .from("creature_equip_template")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_CREATURE_EQUIP_TEMPLATE, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_CREATURE_EQUIP_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_CREATURE_EQUIP_TEMPLATE, (event, payload) => {
  let queryBuilder = knex
    .table("creature_equip_template")
    .where(payload.credential)
    .update(payload.creatureEquipTemplate);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_CREATURE_EQUIP_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_CREATURE_EQUIP_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_CREATURE_EQUIP_TEMPLATE, (event, payload) => {
  let queryBuilder = knex
    .table("creature_equip_template")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_CREATURE_EQUIP_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_CREATURE_EQUIP_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_CREATURE_EQUIP_TEMPLATE, (event, payload) => {
  let queryBuilder = knex
    .select("ID")
    .from("creature_equip_template")
    .where(payload)
    .orderBy("ID", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_CREATURE_EQUIP_TEMPLATE, {
        CreatureID: payload.CreatureID,
        ID: rows.length > 0 ? rows[0].ID + 1 : 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_CREATURE_EQUIP_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_CREATURE_EQUIP_TEMPLATE, (event, payload) => {
  let id = undefined;
  let creatureEquipTemplate = undefined;

  let idQueryBuilder = knex
    .select("ID")
    .from("creature_equip_template")
    .where("CreatureID", payload.CreatureID)
    .orderBy("ID", "desc");
  let findCreatureEquipTemplateQueryBuilder = knex
    .select()
    .from("creature_equip_template")
    .where(payload);
  Promise.all([
    idQueryBuilder.then((rows) => {
      id = rows.length > 0 ? rows[0].ID : 1;
    }),
    findCreatureEquipTemplateQueryBuilder.then((rows) => {
      creatureEquipTemplate = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      creatureEquipTemplate.ID = id + 1;
      let queryBuilder = knex
        .insert(creatureEquipTemplate)
        .into("creature_equip_template");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_CREATURE_EQUIP_TEMPLATE, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_CREATURE_EQUIP_TEMPLATE}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_CREATURE_EQUIP_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
