import { ipcMain } from "electron";
import {
  COPY_GAME_OBJECT_TEMPLATE,
  COUNT_GAME_OBJECT_TEMPLATES,
  CREATE_GAME_OBJECT_TEMPLATE,
  DESTROY_GAME_OBJECT_TEMPLATE,
  FIND_GAME_OBJECT_TEMPLATE,
  FIND_GAME_OBJECT_TEMPLATE_ADDON,
  GLOBAL_NOTICE,
  SEARCH_GAME_OBJECT_LOOT_TEMPLATES,
  SEARCH_GAME_OBJECT_QUEST_ITEMS,
  SEARCH_GAME_OBJECT_TEMPLATES,
  SEARCH_GAME_OBJECT_TEMPLATE_LOCALES,
  STORE_GAME_OBJECT_TEMPLATE,
  STORE_GAME_OBJECT_TEMPLATE_ADDON,
  STORE_GAME_OBJECT_TEMPLATE_LOCALES,
  UPDATE_GAME_OBJECT_TEMPLATE,
  UPDATE_GAME_OBJECT_TEMPLATE_ADDON
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
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
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
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
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
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
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
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
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
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
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
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

// 新建空的物体模板，entry自动生成
ipcMain.on(CREATE_GAME_OBJECT_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .select("entry")
    .from("gameobject_template")
    .orderBy("entry", "desc");

  queryBuilder.then(rows => {
    event.reply(CREATE_GAME_OBJECT_TEMPLATE, {
      entry: rows[0].entry + 1
    });
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
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
        message: `复制成功，新的物体模板 entry 为 ${entry + 1}。`
      });
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString()
      });
    });
  });
});

ipcMain.on(SEARCH_GAME_OBJECT_TEMPLATE_LOCALES, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("gameobject_template_locale")
    .where(payload);

  queryBuilder.then(rows => {
    event.reply(SEARCH_GAME_OBJECT_TEMPLATE_LOCALES, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

ipcMain.on(STORE_GAME_OBJECT_TEMPLATE_LOCALES, (event, payload) => {
  let deleteQueryBuilder = knex()
    .table("gameobject_template_locale")
    .where("entry", payload[0].entry)
    .delete();
  let insertQueryBuilder = knex()
    .insert(payload)
    .into("gameobject_template_locale");

  deleteQueryBuilder.then(rows => {
    insertQueryBuilder.then(rows => {
      event.reply(STORE_GAME_OBJECT_TEMPLATE_LOCALES, rows);
      event.reply(GLOBAL_NOTICE, {
        type: "success",
        category: "notification",
        title: "成功",
        message: `保存成功。`
      });
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString()
      });
    });
  });
});

ipcMain.on(STORE_GAME_OBJECT_TEMPLATE_ADDON, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("gameobject_template_addon");

  queryBuilder.then(rows => {
    event.reply(STORE_GAME_OBJECT_TEMPLATE_ADDON, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "notification",
      title: "成功",
      message: "新建成功。",
      type: "success"
    });
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

ipcMain.on(FIND_GAME_OBJECT_TEMPLATE_ADDON, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("gameobject_template_addon")
    .where(payload);

  queryBuilder.then(rows => {
    event.reply(FIND_GAME_OBJECT_TEMPLATE_ADDON, rows.length > 0 ? rows[0] : {});
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

ipcMain.on(UPDATE_GAME_OBJECT_TEMPLATE_ADDON, (event, payload) => {
  let queryBuilder = knex()
    .table("gameobject_template_addon")
    .where("entry", payload.entry)
    .update(payload);

  queryBuilder.then(rows => {
    event.reply(UPDATE_GAME_OBJECT_TEMPLATE_ADDON, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "notification",
      title: "成功",
      message: "修改成功。",
      type: "success"
    });
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

ipcMain.on(SEARCH_GAME_OBJECT_QUEST_ITEMS, (event, payload) => {
  let queryBuilder = knex()
    .select(["gq.*", "it.name", "itl.Name as localeName"])
    .from("gameobject_questitem as gq")
    .leftJoin("item_template as it", "gq.ItemId", "it.entry")
    .leftJoin("item_template_locale as itl", function() {
      this.on("it.entry", "=", "itl.ID").andOn("itl.locale", "=", knex().raw("?", "zhCN"));
    })
    .where("gq.GameObjectEntry", payload.GameObjectEntry);

  queryBuilder.then(rows => {
    event.reply(SEARCH_GAME_OBJECT_QUEST_ITEMS, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

ipcMain.on(SEARCH_GAME_OBJECT_LOOT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select(["glt.*", "it.name", "itl.Name as localeName"])
    .from("gameobject_loot_template as glt")
    .leftJoin("item_template as it", "glt.Item", "it.entry")
    .leftJoin("item_template_locale as itl", function() {
      this.on("it.entry", "=", "itl.ID").andOn("itl.locale", "=", knex().raw("?", "zhCN"));
    })
    .where("glt.Entry", payload.Entry);

  queryBuilder.then(rows => {
    event.reply(SEARCH_GAME_OBJECT_LOOT_TEMPLATES, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});
