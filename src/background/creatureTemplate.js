import { ipcMain } from "electron";

import {
  SEARCH_CREATURE_TEMPLATES,
  COUNT_CREATURE_TEMPLATES,
  STORE_CREATURE_TEMPLATE,
  FIND_CREATURE_TEMPLATE,
  UPDATE_CREATURE_TEMPLATE,
  DESTROY_CREATURE_TEMPLATE,
  CREATE_CREATURE_TEMPLATE,
  COPY_CREATURE_TEMPLATE,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_CREATURE_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select([
      "ct.entry",
      "ct.name",
      "ctl.Name as localeName",
      "ct.subname",
      "ctl.Title as localeTitle",
      "ct.minlevel",
      "ct.maxlevel",
    ])
    .from("creature_template as ct")
    .leftJoin("creature_template_locale as ctl", function () {
      this.on("ct.entry", "=", "ctl.entry").andOn(
        "ctl.locale",
        "=",
        knex().raw("?", "zhCN")
      );
    });
  if (payload.entry) {
    queryBuilder = queryBuilder.where("ct.entry", "like", `%${payload.entry}%`);
  }
  if (payload.name) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("ct.name", "like", `%${payload.name}%`)
        .orWhere("ctl.Name", "like", `%${payload.name}%`)
    );
  }
  if (payload.subname) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("ct.subname", "like", `%${payload.subname}%`)
        .orWhere("ctl.Title", "like", `%${payload.subname}%`)
    );
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_CREATURE_TEMPLATES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_CREATURE_TEMPLATES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_CREATURE_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("creature_template as ct")
    .leftJoin("creature_template_locale as ctl", function () {
      this.on("ct.entry", "=", "ctl.entry").andOn(
        "ctl.locale",
        "=",
        knex().raw("?", "zhCN")
      );
    });
  if (payload.entry) {
    queryBuilder = queryBuilder.where("ct.entry", "like", `%${payload.entry}%`);
  }
  if (payload.name) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("ct.name", "like", `%${payload.name}%`)
        .orWhere("ctl.Name", "like", `%${payload.name}%`)
    );
  }
  if (payload.subname) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("ct.subname", "like", `%${payload.subname}%`)
        .orWhere("ctl.Title", "like", `%${payload.subname}%`)
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_CREATURE_TEMPLATES, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_CREATURE_TEMPLATES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_CREATURE_TEMPLATE, (event, payload) => {
  let queryBuilder = knex().insert(payload).into("creature_template");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_CREATURE_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_CREATURE_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_CREATURE_TEMPLATE, (event, payload) => {
  let queryBuilder = knex().select().from("creature_template").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_CREATURE_TEMPLATE, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_CREATURE_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_CREATURE_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("creature_template")
    .where(payload.credential)
    .update(payload.creatureTemplate);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_CREATURE_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_CREATURE_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_CREATURE_TEMPLATE, (event, payload) => {
  let queryBuilder = knex().table("creature_template").where(payload).delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_CREATURE_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_CREATURE_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_CREATURE_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .select("entry")
    .from("creature_template")
    .orderBy("entry", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_CREATURE_TEMPLATE, {
        entry: rows[0].entry + 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_CREATURE_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_CREATURE_TEMPLATE, (event, payload) => {
  let entry = undefined;
  let creatureTemplate = undefined;

  let entryQueryBuilder = knex()
    .select("entry")
    .from("creature_template")
    .orderBy("entry", "desc");
  let findCreatureTemplateQueryBuilder = knex()
    .select()
    .from("creature_template")
    .where(payload);
  Promise.all([
    entryQueryBuilder.then((rows) => {
      entry = rows[0].entry;
    }),
    findCreatureTemplateQueryBuilder.then((rows) => {
      creatureTemplate = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      creatureTemplate.entry = entry + 1;
      let queryBuilder = knex()
        .insert(creatureTemplate)
        .into("creature_template");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_CREATURE_TEMPLATE, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_CREATURE_TEMPLATE}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_CREATURE_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});
