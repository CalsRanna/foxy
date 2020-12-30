import { ipcMain } from "electron";
import {
  COPY_ITEM_TEMPLATE,
  COUNT_ITEM_TEMPLATES,
  CREATE_ITEM_TEMPLATE,
  DESTROY_ITEM_TEMPLATE,
  FIND_ITEM_TEMPLATE,
  GLOBAL_NOTICE,
  SEARCH_ITEM_TEMPLATES,
  SEARCH_ITEM_TEMPLATE_LOCALES,
  STORE_ITEM_TEMPLATE,
  UPDATE_ITEM_TEMPLATE,
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
      this.on("it.entry", "=", "itl.ID").andOn("itl.locale", "=", knex().raw("?", "zhCN"));
    });
  if (payload.entry) {
    queryBuilder = queryBuilder.where("it.entry", "like", `%${payload.entry}%`);
  }
  if (payload.name) {
    queryBuilder = queryBuilder.where((builder) =>
      builder.where("it.name", "like", `%${payload.name}%`).orWhere("itl.Name", "like", `%${payload.name}%`)
    );
  }
  if (payload.class) {
    queryBuilder = queryBuilder.where("it.class", "like", `%${payload.class}%`);
  }
  if (payload.subclass) {
    queryBuilder = queryBuilder.where("it.subclass", "like", `%${payload.subclass}%`);
  }
  if (payload.InventoryType) {
    queryBuilder = queryBuilder.where("it.InventoryType", "like", `%${payload.InventoryType}%`);
  }
  queryBuilder = queryBuilder.limit(50).offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder.then((rows) => {
    event.reply(SEARCH_ITEM_TEMPLATES, rows);
  });
});

ipcMain.on(COUNT_ITEM_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("item_template as it")
    .leftJoin("item_template_locale as itl", function () {
      this.on("it.entry", "=", "itl.ID").andOn("itl.locale", "=", knex().raw("?", "zhCN"));
    });
  if (payload.entry) {
    queryBuilder = queryBuilder.where("it.entry", "like", `%${payload.entry}%`);
  }
  if (payload.name) {
    queryBuilder = queryBuilder.where((builder) =>
      builder.where("it.name", "like", `%${payload.name}%`).orWhere("itl.Name", "like", `%${payload.name}%`)
    );
  }
  if (payload.class) {
    queryBuilder = queryBuilder.where("it.class", "like", `%${payload.class}%`);
  }
  if (payload.subclass) {
    queryBuilder = queryBuilder.where("it.subclass", "like", `%${payload.subclass}%`);
  }
  if (payload.InventoryType) {
    queryBuilder = queryBuilder.where("it.InventoryType", "like", `%${payload.InventoryType}%`);
  }

  queryBuilder.then((rows) => {
    event.reply(COUNT_ITEM_TEMPLATES, rows[0].total);
  });
});

ipcMain.on(STORE_ITEM_TEMPLATE, (event, payload) => {
  let queryBuilder = knex().insert(payload).into("item_template");

  queryBuilder.then((rows) => {
    event.reply(STORE_ITEM_TEMPLATE, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "notification",
      title: "成功",
      message: "新建成功。",
      type: "success",
    });
  });
});

ipcMain.on(FIND_ITEM_TEMPLATE, (event, payload) => {
  let queryBuilder = knex().select().from("item_template").where(payload);

  queryBuilder.then((rows) => {
    event.reply(FIND_ITEM_TEMPLATE, rows.length > 0 ? rows[0] : {});
  });
});

ipcMain.on(UPDATE_ITEM_TEMPLATE, (event, payload) => {
  let queryBuilder = knex().table("item_template").where("entry", payload.entry).update(payload);

  queryBuilder.then((rows) => {
    event.reply(UPDATE_ITEM_TEMPLATE, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "notification",
      title: "成功",
      message: "修改成功。",
      type: "success",
    });
  });
});

ipcMain.on(DESTROY_ITEM_TEMPLATE, (event, payload) => {
  let queryBuilder = knex().table("item_template").where(payload).delete();

  queryBuilder.then((rows) => {
    event.reply(DESTROY_ITEM_TEMPLATE, rows);
    event.reply("GLOBAL_NOTICE", {
      category: "notification",
      title: "成功",
      message: "删除成功。",
      type: "success",
    });
  });
});

// 新建空的物品模板，entry自动生成
ipcMain.on(CREATE_ITEM_TEMPLATE, (event, payload) => {
  let queryBuilder = knex().select("entry").from("item_template").orderBy("entry", "desc");

  queryBuilder.then((rows) => {
    event.reply(CREATE_ITEM_TEMPLATE, {
      entry: rows[0].entry + 1,
    });
  });
});

ipcMain.on(COPY_ITEM_TEMPLATE, (event, payload) => {
  let entry = undefined;
  let gameObjectTemplate = undefined;

  let entryQueryBuilder = knex().select("entry").from("item_template").orderBy("entry", "desc");
  let findGameObjectTemplateQueryBuilder = knex().select().from("item_template").where(payload);
  Promise.all([
    entryQueryBuilder.then((rows) => {
      entry = rows[0].entry;
    }),
    findGameObjectTemplateQueryBuilder.then((rows) => {
      gameObjectTemplate = rows.length > 0 ? rows[0] : {};
    }),
  ]).then(() => {
    gameObjectTemplate.entry = entry + 1;
    let queryBuilder = knex().insert(gameObjectTemplate).into("item_template");
    queryBuilder.then((rows) => {
      event.reply(COPY_ITEM_TEMPLATE, rows);
      event.reply(GLOBAL_NOTICE, {
        type: "success",
        category: "notification",
        title: "成功",
        message: `复制成功，新的游戏对象模板 entry 为 ${entry + 1}。`,
      });
    });
  });
});

ipcMain.on(SEARCH_ITEM_TEMPLATE_LOCALES, (event, payload) => {
  let queryBuilder = knex().select().from("item_template_locale").where("ID", payload.id);

  queryBuilder.then((rows) => {
    event.reply(SEARCH_ITEM_TEMPLATE_LOCALES, rows);
  });
});
