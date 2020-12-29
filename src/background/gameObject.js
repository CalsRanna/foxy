import { ipcMain } from "electron";
import {
  COPY_GAME_OBJECT_TEMPLATE,
  COUNT_GAME_OBJECT_TEMPLATES,
  CREATE_GAME_OBJECT_TEMPLATE,
  DESTROY_GAME_OBJECT_TEMPLATE,
  FIND_GAME_OBJECT_TEMPLATE,
  GLOBAL_NOTICE,
  SEARCH_GAME_OBJECT_TEMPLATES,
  STORE_GAME_OBJECT_TEMPLATE,
  UPDATE_GAME_OBJECT_TEMPLATE
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_GAME_OBJECT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select(["gt.entry", "gt.displayId", "gt.name", "gtl.name as localeName", "gt.type", "gt.size"])
    .from("gameobject_template as gt")
    .leftJoin("gameobject_template_locale as gtl", function() {
      this.on("gt.entry", "=", "gtl.entry").andOn("gtl.locale", "=", knex().raw("?", "zhCN"));
    });
  if (payload.entry) {
    queryBuilder = queryBuilder.where("gt.entry", "like", `%${payload.entry}%`);
  }
  if (payload.name) {
    queryBuilder = queryBuilder.where(builder =>
      builder.where("gt.name", "like", `%${payload.name}%`).orWhere("gtl.name", "like", `%${payload.name}%`)
    );
  }
  queryBuilder = queryBuilder.limit(50).offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder.then(rows => {
    event.reply(SEARCH_GAME_OBJECT_TEMPLATES, rows);
  });
});

ipcMain.on(COUNT_GAME_OBJECT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("gameobject_template as gt")
    .leftJoin("gameobject_template_locale as gtl", function() {
      this.on("gt.entry", "=", "gtl.entry").andOn("gtl.locale", "=", knex().raw("?", "zhCN"));
    });
  if (payload.entry) {
    queryBuilder = queryBuilder.where("gt.entry", "like", `%${payload.entry}%`);
  }
  if (payload.name) {
    queryBuilder = queryBuilder.where(builder =>
      builder.where("gt.name", "like", `%${payload.name}%`).orWhere("gtl.name", "like", `%${payload.name}%`)
    );
  }

  queryBuilder.then(rows => {
    event.reply(COUNT_GAME_OBJECT_TEMPLATES, rows[0].total);
  });
});

ipcMain.on(STORE_GAME_OBJECT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("gameobject_template");

  queryBuilder.then(rows => {
    event.reply(STORE_GAME_OBJECT_TEMPLATE, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "notification",
      title: "成功",
      message: "新建成功。",
      type: "success"
    });
  });
});

ipcMain.on(FIND_GAME_OBJECT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("gameobject_template")
    .where(payload);

  queryBuilder.then(rows => {
    event.reply(FIND_GAME_OBJECT_TEMPLATE, rows.length > 0 ? rows[0] : {});
  });
});

ipcMain.on(UPDATE_GAME_OBJECT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("gameobject_template")
    .where("entry", payload.entry)
    .update(payload);

  queryBuilder.then(rows => {
    event.reply(UPDATE_GAME_OBJECT_TEMPLATE, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "notification",
      title: "成功",
      message: "修改成功。",
      type: "success"
    });
  });
});

ipcMain.on(DESTROY_GAME_OBJECT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("gameobject_template")
    .where(payload)
    .delete();

  queryBuilder.then(rows => {
    event.reply(DESTROY_GAME_OBJECT_TEMPLATE, rows);
    event.reply("GLOBAL_NOTICE", {
      category: "notification",
      title: "成功",
      message: "删除成功。",
      type: "success"
    });
  });
});

// 新建空的游戏对象模板，entry自动生成
ipcMain.on(CREATE_GAME_OBJECT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .select("entry")
    .from("gameobject_template")
    .orderBy("entry", "desc");

  queryBuilder.then(rows => {
    event.reply(CREATE_GAME_OBJECT_TEMPLATE, {
      entry: rows[0].entry + 1
    });
  });
});

ipcMain.on(COPY_GAME_OBJECT_TEMPLATE, (event, payload) => {
  let entry = undefined;
  let gameObjectTemplate = undefined;

  let entryQueryBuilder = knex()
    .select("entry")
    .from("gameobject_template")
    .orderBy("entry", "desc");
  let findGameObjectTemplateQueryBuilder = knex()
    .select()
    .from("gameobject_template")
    .where(payload);
  Promise.all([
    entryQueryBuilder.then(rows => {
      entry = rows[0].entry;
    }),
    findGameObjectTemplateQueryBuilder.then(rows => {
      gameObjectTemplate = rows.length > 0 ? rows[0] : {};
    })
  ]).then(() => {
    gameObjectTemplate.entry = entry + 1;
    let queryBuilder = knex()
      .insert(gameObjectTemplate)
      .into("gameobject_template");
    queryBuilder.then(rows => {
      event.reply(COPY_GAME_OBJECT_TEMPLATE, rows);
      event.reply(GLOBAL_NOTICE, {
        type: "success",
        category: "notification",
        title: "成功",
        message: `复制成功，新的游戏对象模板 entry 为 ${entry + 1}。`
      });
    });
  });
});
