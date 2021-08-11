import { ipcMain } from "electron";

import {
  SEARCH_PAGE_TEXTS,
  COUNT_PAGE_TEXTS,
  STORE_PAGE_TEXT,
  FIND_PAGE_TEXT,
  UPDATE_PAGE_TEXT,
  DESTROY_PAGE_TEXT,
  CREATE_PAGE_TEXT,
  COPY_PAGE_TEXT,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
} from "../constants";

ipcMain.on(SEARCH_PAGE_TEXTS, (event, payload) => {
  let queryBuilder = knex
    .select(["pt.ID", "pt.Text", "ptl.Text as localeText", "pt.NextPageID"])
    .from("page_text as pt")
    .leftJoin("page_text_locale as ptl", function () {
      this.on("pt.ID", "=", "ptl.ID").andOn(
        "ptl.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    });
  if (payload.ID) {
    queryBuilder = queryBuilder.where("pt.ID", payload.ID);
  }
  if (payload.Text) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("pt.Text", "like", `%${payload.Text}%`)
        .orWhere("ptl.Text", "like", `%${payload.Text}%`)
    );
  }
  queryBuilder = queryBuilder
    .limit(payload.size)
    .offset(payload.page != undefined ? (payload.page - 1) * payload.size : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_PAGE_TEXTS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_PAGE_TEXTS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COUNT_PAGE_TEXTS, (event, payload) => {
  let queryBuilder = knex
    .count("* as total")
    .from("page_text as pt")
    .leftJoin("page_text_locale as ptl", function () {
      this.on("pt.ID", "=", "ptl.ID").andOn(
        "ptl.locale",
        "=",
        knex.raw("?", "zhCN")
      );
    });
  if (payload.ID) {
    queryBuilder = queryBuilder.where("pt.ID", payload.ID);
  }
  if (payload.Text) {
    queryBuilder = queryBuilder.where((builder) =>
      builder
        .where("pt.Text", "like", `%${payload.Text}%`)
        .orWhere("ptl.Text", "like", `%${payload.Text}%`)
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_PAGE_TEXTS, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_PAGE_TEXTS}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(STORE_PAGE_TEXT, (event, payload) => {
  let queryBuilder = knex.insert(payload).into("page_text");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_PAGE_TEXT, rows);
    })
    .catch((error) => {
      event.reply(`${STORE_PAGE_TEXT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(FIND_PAGE_TEXT, (event, payload) => {
  let queryBuilder = knex.select().from("page_text").where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_PAGE_TEXT, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_PAGE_TEXT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(UPDATE_PAGE_TEXT, (event, payload) => {
  let queryBuilder = knex
    .table("page_text")
    .where(payload.credential)
    .update(payload.pageText);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_PAGE_TEXT, rows);
    })
    .catch((error) => {
      event.reply(`${UPDATE_PAGE_TEXT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(DESTROY_PAGE_TEXT, (event, payload) => {
  let queryBuilder = knex.table("page_text").where(payload).delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_PAGE_TEXT, rows);
    })
    .catch((error) => {
      event.reply(`${DESTROY_PAGE_TEXT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(CREATE_PAGE_TEXT, (event, payload) => {
  let queryBuilder = knex.select("ID").from("page_text").orderBy("ID", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_PAGE_TEXT, {
        ID: rows[0].ID + 1,
      });
    })
    .catch((error) => {
      event.reply(`${CREATE_PAGE_TEXT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    })
    .finally(() => {
      event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
    });
});

ipcMain.on(COPY_PAGE_TEXT, (event, payload) => {
  let ID = undefined;
  let pageText = undefined;

  let IDQueryBuilder = knex
    .select("ID")
    .from("page_text")
    .orderBy("ID", "desc");
  let findPageTextQueryBuilder = knex.select().from("page_text").where(payload);
  Promise.all([
    IDQueryBuilder.then((rows) => {
      ID = rows[0].ID;
    }),
    findPageTextQueryBuilder.then((rows) => {
      pageText = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      pageText.ID = ID + 1;
      let queryBuilder = knex.insert(pageText).into("page_text");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_PAGE_TEXT, rows);
        })
        .catch((error) => {
          event.reply(`${COPY_PAGE_TEXT}_REJECT`, error);
          event.reply(GLOBAL_MESSAGE_BOX, error);
        })
        .finally(() => {
          event.reply(GLOBAL_MESSAGE, queryBuilder.toString());
        });
    })
    .catch((error) => {
      event.reply(`${COPY_PAGE_TEXT}_REJECT`, error);
      event.reply(GLOBAL_MESSAGE_BOX, error);
    });
});
