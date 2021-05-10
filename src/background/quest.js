import { ipcMain } from "electron";

import {
  SEARCH_QUEST_TEMPLATES,
  COUNT_QUEST_TEMPLATES,
  STORE_QUEST_TEMPLATE,
  FIND_QUEST_TEMPLATE,
  UPDATE_QUEST_TEMPLATE,
  DESTROY_QUEST_TEMPLATE,
  CREATE_QUEST_TEMPLATE,
  COPY_QUEST_TEMPLATE,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_QUEST_TEMPLATES, (event, payload) => {
  let queryBuilder = knex
    .select([
      "qt.ID",
      "qt.LogTitle",
      "qtl.Title",
      "qt.LogDescription",
      "qtl.Details",
      "qt.QuestType",
      "qt.QuestLevel",
      "qt.MinLevel",
    ])
    .from("quest_template as qt")
    .leftJoin("quest_template_locale as qtl", function () {
      this.on("qt.ID", "=", "qtl.ID").andOn(
        "qtl.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    });
  if (payload.id) {
    queryBuilder = queryBuilder.where("qt.ID", "like", `%${payload.id}%`);
  }
  if (payload.title) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("qt.LogTitle", "like", `%${payload.title}%`)
        .orWhere("qtl.Title", "like", `%${payload.title}%`)
    );
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_QUEST_TEMPLATES, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_QUEST_TEMPLATES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_QUEST_TEMPLATES, (event, payload) => {
  let queryBuilder = knex
    .count("* as total")
    .from("quest_template as qt")
    .leftJoin("quest_template_locale as qtl", function () {
      this.on("qt.ID", "=", "qtl.ID").andOn(
        "qtl.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    });
  if (payload.id) {
    queryBuilder = queryBuilder.where("qt.ID", "like", `%${payload.id}%`);
  }
  if (payload.title) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("qt.LogTitle", "like", `%${payload.title}%`)
        .orWhere("qtl.Title", "like", `%${payload.title}%`)
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_QUEST_TEMPLATES, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_QUEST_TEMPLATES}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_QUEST_TEMPLATE, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("quest_template");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_QUEST_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_QUEST_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_QUEST_TEMPLATE, (event, payload) => {
  let queryBuilder = knex.select().from("quest_template").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_QUEST_TEMPLATE, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_QUEST_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_QUEST_TEMPLATE, (event, payload) => {
  let queryBuilder = knex
    .table("quest_template")
    .where("ID", payload.ID)
    .update(payload);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_QUEST_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_QUEST_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_QUEST_TEMPLATE, (event, payload) => {
  let queryBuilder = knex.table("quest_template").where(payload).delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_QUEST_TEMPLATE, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_QUEST_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_QUEST_TEMPLATE, (event, payload) => {
  let queryBuilder = knex
    .select("ID")
    .from("quest_template")
    .orderBy("ID", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_QUEST_TEMPLATE, {
        ID: rows[0].ID + 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_QUEST_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_QUEST_TEMPLATE, (event, payload) => {
  let ID = undefined;
  let questTemplate = undefined;

  let idQueryBuilder = knex
    .select("ID")
    .from("quest_template")
    .orderBy("ID", "desc");
  let findQuestTemplateQueryBuilder = knex
    .select()
    .from("quest_template")
    .where(payload);
  Promise.all([
    idQueryBuilder.then((rows) => {
      ID = rows[0].ID;
    }),
    findQuestTemplateQueryBuilder.then((rows) => {
      questTemplate = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      questTemplate.ID = ID + 1;
      let queryBuilder = knex.insert(questTemplate).into("quest_template");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_QUEST_TEMPLATE, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_QUEST_TEMPLATE}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_QUEST_TEMPLATE}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    });
});

ipcMain.on(SEARCH_QUEST_TEMPLATE_LOCALES, (event, payload) => {
  let queryBuilder = knex
    .select()
    .from("quest_template_locale")
    .where("ID", payload.id);

  queryBuilder.then((rows) => {
    event.reply(SEARCH_QUEST_TEMPLATE_LOCALES, rows);
    event.reply(GLOBAL_MESSAGE, {
      category: "message",
      message: queryBuilder.toString(),
    });
  });
});
