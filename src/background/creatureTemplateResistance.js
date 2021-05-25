import { ipcMain } from "electron";

import {
  SEARCH_CREATURE_TEMPLATE_RESISTANCES,
  STORE_CREATURE_TEMPLATE_RESISTANCE,
  FIND_CREATURE_TEMPLATE_RESISTANCE,
  UPDATE_CREATURE_TEMPLATE_RESISTANCE,
  DESTROY_CREATURE_TEMPLATE_RESISTANCE,
  CREATE_CREATURE_TEMPLATE_RESISTANCE,
  COPY_CREATURE_TEMPLATE_RESISTANCE,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_CREATURE_TEMPLATE_RESISTANCES, (event, payload) => {
  let queryBuilder = knex
    .select()
    .from("creature_template_resistance")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_CREATURE_TEMPLATE_RESISTANCES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_CREATURE_TEMPLATE_RESISTANCES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_CREATURE_TEMPLATE_RESISTANCE, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("creature_template_resistance");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_CREATURE_TEMPLATE_RESISTANCE, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_CREATURE_TEMPLATE_RESISTANCE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_CREATURE_TEMPLATE_RESISTANCE, (event, payload) => {
  let queryBuilder = knex
    .select()
    .from("creature_template_resistance")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(
        FIND_CREATURE_TEMPLATE_RESISTANCE,
        rows.length > 0 ? rows[0] : {}
      );
    })
    .catch((error) => {
      event.reply(`${FIND_CREATURE_TEMPLATE_RESISTANCE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_CREATURE_TEMPLATE_RESISTANCE, (event, payload) => {
  let queryBuilder = knex
    .table("creature_template_resistance")
    .where(payload.credential)
    .update(payload.creatureTemplateResistance);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_CREATURE_TEMPLATE_RESISTANCE, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_CREATURE_TEMPLATE_RESISTANCE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_CREATURE_TEMPLATE_RESISTANCE, (event, payload) => {
  let queryBuilder = knex
    .table("creature_template_resistance")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_CREATURE_TEMPLATE_RESISTANCE, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_CREATURE_TEMPLATE_RESISTANCE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_CREATURE_TEMPLATE_RESISTANCE, (event, payload) => {
  let queryBuilder = knex
    .select("School")
    .from("creature_template_resistance")
    .where(payload)
    .orderBy("School", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_CREATURE_TEMPLATE_RESISTANCE, {
        CreatureID: payload.CreatureID,
        School: rows.length > 0 ? rows[0].School + 1 : 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_CREATURE_TEMPLATE_RESISTANCE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_CREATURE_TEMPLATE_RESISTANCE, (event, payload) => {
  let school = undefined;
  let creatureTemplateResistance = undefined;

  let schoolQueryBuilder = knex
    .select("School")
    .from("creature_template_resistance")
    .where("CreatureID", payload.CreatureID)
    .orderBy("School", "desc");
  let findCreatureTemplateResistanceQueryBuilder = knex
    .select()
    .from("creature_template_resistance")
    .where(payload);
  Promise.all([
    schoolQueryBuilder.then((rows) => {
      school = rows.length > 0 ? rows[0].School : 1;
    }),
    findCreatureTemplateResistanceQueryBuilder.then((rows) => {
      creatureTemplateResistance = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      creatureTemplateResistance.School = school + 1;
      let queryBuilder = knex
        .insert(creatureTemplateResistance)
        .into("creature_template_resistance");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_CREATURE_TEMPLATE_RESISTANCE, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_CREATURE_TEMPLATE_RESISTANCE}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_CREATURE_TEMPLATE_RESISTANCE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
