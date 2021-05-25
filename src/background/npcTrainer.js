import { ipcMain } from "electron";

import {
  SEARCH_NPC_TRAINERS,
  STORE_NPC_TRAINER,
  FIND_NPC_TRAINER,
  UPDATE_NPC_TRAINER,
  DESTROY_NPC_TRAINER,
  COPY_NPC_TRAINER,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_NPC_TRAINERS, (event, payload) => {
  let queryBuilder = knex.select().from("npc_trainer").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_NPC_TRAINERS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_NPC_TRAINERS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_NPC_TRAINER, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("npc_trainer");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_NPC_TRAINER, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_NPC_TRAINER}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_NPC_TRAINER, (event, payload) => {
  let queryBuilder = knex.select().from("npc_trainer").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_NPC_TRAINER, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_NPC_TRAINER}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_NPC_TRAINER, (event, payload) => {
  let queryBuilder = knex
    .table("npc_trainer")
    .where(payload.credential)
    .update(payload.npcTrainer);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_NPC_TRAINER, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_NPC_TRAINER}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_NPC_TRAINER, (event, payload) => {
  let queryBuilder = knex.table("npc_trainer").where(payload).delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_NPC_TRAINER, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_NPC_TRAINER}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_NPC_TRAINER, (event, payload) => {
  let spellId = undefined;
  let npcTrainer = undefined;

  let spellIdQueryBuilder = knex
    .select("SpellID")
    .from("npc_trainer")
    .where("ID", payload.ID)
    .orderBy("SpellID", "desc");
  let findNpcTrainerQueryBuilder = knex
    .select()
    .from("npc_trainer")
    .where(payload);
  Promise.all([
    spellIdQueryBuilder.then((rows) => {
      spellId = rows.length > 0 ? rows[0].SpellID : 1;
    }),
    findNpcTrainerQueryBuilder.then((rows) => {
      npcTrainer = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      npcTrainer.SpellID = spellId + 1;
      let queryBuilder = knex.insert(npcTrainer).into("npc_trainer");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_NPC_TRAINER, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_NPC_TRAINER}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_NPC_TRAINER}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
