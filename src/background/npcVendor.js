import { ipcMain } from "electron";

import {
  SEARCH_NPC_VENDORS,
  STORE_NPC_VENDOR,
  FIND_NPC_VENDOR,
  UPDATE_NPC_VENDOR,
  DESTROY_NPC_VENDOR,
  CREATE_NPC_VENDOR,
  COPY_NPC_VENDOR,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_NPC_VENDORS, (event, payload) => {
  let queryBuilder = knex()
    .select(["nv.*", "it.displayid", "it.name", "itl.Name"])
    .from("npc_vendor as nv")
    .leftJoin("item_template as it", "nv.item", "it.entry")
    .leftJoin("item_template_locale as itl", function() {
      this.on("nv.item", "=", "itl.ID").andOn(
        "itl.locale",
        "=",
        knex().raw("?", "zhCN")
      );
    })
    .where("nv.entry", payload.entry);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_NPC_VENDORS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_NPC_VENDORS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_NPC_VENDOR, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("npc_vendor");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_NPC_VENDOR, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_NPC_VENDOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_NPC_VENDOR, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("npc_vendor")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_NPC_VENDOR, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_NPC_VENDOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_NPC_VENDOR, (event, payload) => {
  let queryBuilder = knex()
    .table("npc_vendor")
    .where(payload.credential)
    .update(payload.npcVendor);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_NPC_VENDOR, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_NPC_VENDOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_NPC_VENDOR, (event, payload) => {
  let queryBuilder = knex()
    .table("npc_vendor")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_NPC_VENDOR, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_NPC_VENDOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_NPC_VENDOR, (event, payload) => {
  let queryBuilder = knex()
    .select("slot")
    .from("npc_vendor")
    .where(payload)
    .orderBy("slot", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_CREATURE_EQUIP_TEMPLATE, {
        entry: payload.entry,
        slot: rows.length > 0 ? rows[0].slot + 1 : 0,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_NPC_VENDOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_NPC_VENDOR, (event, payload) => {
  let slot = undefined;
  let extendedCost = undefined;
  let npcVendor = undefined;

  let slotQueryBuilder = knex()
    .select("slot")
    .from("npc_vendor")
    .where("entry", payload.entry)
    .orderBy("slot", "desc");
  let extendedCostQueryBuilder = knex()
    .select("ExtendedCost")
    .from("npc_vendor")
    .where("entry", payload.entry)
    .orderBy("ExtendedCost", "desc");
  let findNpcVendorQueryBuilder = knex()
    .select()
    .from("npc_vendor")
    .where(payload);
  Promise.all([
    slotQueryBuilder.then((rows) => {
      slot = rows.length > 0 ? rows[0].slot : 0;
    }),
    extendedCostQueryBuilder.then((rows) => {
      extendedCost = rows.length > 0 ? rows[0].ExtendedCost : 0;
    }),
    findNpcVendorQueryBuilder.then((rows) => {
      npcVendor = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      npcVendor.slot = slot + 1;
      npcVendor.ExtendedCost = extendedCost + 1;
      let queryBuilder = knex()
        .insert(npcVendor)
        .into("npc_vendor");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_NPC_VENDOR, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_NPC_VENDOR}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_NPC_VENDOR}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
