import { ipcMain } from "electron";
import {
  COPY_ITEM_TEMPLATE,
  COUNT_ITEM_TEMPLATES,
  CREATE_ITEM_TEMPLATE,
  DESTROY_ITEM_TEMPLATE,
  FIND_ITEM_TEMPLATE,
  GLOBAL_NOTICE,
  SEARCH_DISENCHANT_LOOT_TEMPLATES,
  SEARCH_ITEM_ENCHANTMENT_TEMPLATES,
  SEARCH_ITEM_LOOT_TEMPLATES,
  SEARCH_ITEM_TEMPLATES,
  SEARCH_ITEM_TEMPLATE_LOCALES,
  SEARCH_MILLING_LOOT_TEMPLATES,
  SEARCH_PROSPECTING_LOOT_TEMPLATES,
  STORE_ITEM_TEMPLATE,
  STORE_ITEM_TEMPLATE_LOCALES,
  UPDATE_ITEM_TEMPLATE
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
      "it.RequiredLevel"
    ])
    .from("item_template as it")
    .leftJoin("item_template_locale as itl", function() {
      this.on("it.entry", "=", "itl.ID").andOn("itl.locale", "=", knex().raw("?", "zhCN"));
    });
  if (payload.entry) {
    queryBuilder = queryBuilder.where("it.entry", "like", `%${payload.entry}%`);
  }
  if (payload.name) {
    queryBuilder = queryBuilder.where(builder =>
      builder.where("it.name", "like", `%${payload.name}%`).orWhere("itl.Name", "like", `%${payload.name}%`)
    );
  }
  if (payload.class != undefined) {
    queryBuilder = queryBuilder.where("it.class", payload.class);
  }
  if (payload.subclass != undefined) {
    queryBuilder = queryBuilder.where("it.subclass", payload.subclass);
  }
  if (payload.InventoryType != undefined) {
    queryBuilder = queryBuilder.where("it.InventoryType", payload.InventoryType);
  }
  queryBuilder = queryBuilder.limit(50).offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder.then(rows => {
    event.reply(SEARCH_ITEM_TEMPLATES, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

ipcMain.on(COUNT_ITEM_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("item_template as it")
    .leftJoin("item_template_locale as itl", function() {
      this.on("it.entry", "=", "itl.ID").andOn("itl.locale", "=", knex().raw("?", "zhCN"));
    });
  if (payload.entry) {
    queryBuilder = queryBuilder.where("it.entry", "like", `%${payload.entry}%`);
  }
  if (payload.name) {
    queryBuilder = queryBuilder.where(builder =>
      builder.where("it.name", "like", `%${payload.name}%`).orWhere("itl.Name", "like", `%${payload.name}%`)
    );
  }
  if (payload.class != undefined) {
    queryBuilder = queryBuilder.where("it.class", payload.class);
  }
  if (payload.subclass != undefined) {
    queryBuilder = queryBuilder.where("it.subclass", payload.subclass);
  }
  if (payload.InventoryType != undefined) {
    queryBuilder = queryBuilder.where("it.InventoryType", payload.InventoryType);
  }

  queryBuilder.then(rows => {
    event.reply(COUNT_ITEM_TEMPLATES, rows[0].total);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

ipcMain.on(STORE_ITEM_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("item_template");

  queryBuilder.then(rows => {
    event.reply(STORE_ITEM_TEMPLATE, rows);
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

ipcMain.on(FIND_ITEM_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("item_template")
    .where(payload);

  queryBuilder.then(rows => {
    event.reply(FIND_ITEM_TEMPLATE, rows.length > 0 ? rows[0] : {});
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

ipcMain.on(UPDATE_ITEM_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("item_template")
    .where("entry", payload.entry)
    .update(payload);

  queryBuilder.then(rows => {
    event.reply(UPDATE_ITEM_TEMPLATE, rows);
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

ipcMain.on(DESTROY_ITEM_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("item_template")
    .where(payload)
    .delete();

  queryBuilder.then(rows => {
    event.reply(DESTROY_ITEM_TEMPLATE, rows);
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

// 新建空的物品模板，entry自动生成
ipcMain.on(CREATE_ITEM_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .select("entry")
    .from("item_template")
    .orderBy("entry", "desc");

  queryBuilder.then(rows => {
    event.reply(CREATE_ITEM_TEMPLATE, {
      entry: rows[0].entry + 1
    });
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

ipcMain.on(COPY_ITEM_TEMPLATE, (event, payload) => {
  let entry = undefined;
  let gameObjectTemplate = undefined;

  let entryQueryBuilder = knex()
    .select("entry")
    .from("item_template")
    .orderBy("entry", "desc");
  let findGameObjectTemplateQueryBuilder = knex()
    .select()
    .from("item_template")
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
      .into("item_template");
    queryBuilder.then(rows => {
      event.reply(COPY_ITEM_TEMPLATE, rows);
      event.reply(GLOBAL_NOTICE, {
        type: "success",
        category: "notification",
        title: "成功",
        message: `复制成功，新的游戏对象模板 entry 为 ${entry + 1}。`
      });
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString()
      });
    });
  });
});

ipcMain.on(SEARCH_ITEM_TEMPLATE_LOCALES, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("item_template_locale")
    .where("ID", payload.id);

  queryBuilder.then(rows => {
    event.reply(SEARCH_ITEM_TEMPLATE_LOCALES, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

ipcMain.on(STORE_ITEM_TEMPLATE_LOCALES, (event, payload) => {
  let deleteQueryBuilder = knex()
    .table("item_template_locale")
    .where("ID", payload[0].ID)
    .delete();
  let insertQueryBuilder = knex()
    .insert(payload)
    .into("item_template_locale");

  deleteQueryBuilder.then(rows => {
    insertQueryBuilder.then(rows => {
      event.reply(STORE_ITEM_TEMPLATE_LOCALES, rows);
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

ipcMain.on(SEARCH_ITEM_ENCHANTMENT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("item_enchantment_template")
    .where(payload);

  queryBuilder.then(rows => {
    event.reply(SEARCH_ITEM_ENCHANTMENT_TEMPLATES, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

ipcMain.on(SEARCH_ITEM_LOOT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select(["ilt.*", "it.name", "itl.Name as localeName"])
    .from("item_loot_template as ilt")
    .leftJoin("item_template as it", "ilt.Item", "it.entry")
    .leftJoin("item_template_locale as itl", function() {
      this.on("it.entry", "=", "itl.ID").andOn("itl.locale", "=", knex().raw("?", "zhCN"));
    })
    .where("ilt.Entry", payload.Entry);

  queryBuilder.then(rows => {
    event.reply(SEARCH_ITEM_LOOT_TEMPLATES, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

ipcMain.on(SEARCH_DISENCHANT_LOOT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select(["dlt.*", "it.name", "itl.Name as localeName"])
    .from("disenchant_loot_template as dlt")
    .leftJoin("item_template as it", "dlt.Item", "it.entry")
    .leftJoin("item_template_locale as itl", function() {
      this.on("it.entry", "=", "itl.ID").andOn("itl.locale", "=", knex().raw("?", "zhCN"));
    })
    .where("dlt.Entry", payload.Entry);

  queryBuilder.then(rows => {
    event.reply(SEARCH_DISENCHANT_LOOT_TEMPLATES, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

ipcMain.on(SEARCH_PROSPECTING_LOOT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select(["plt.*", "it.name", "itl.Name as localeName"])
    .from("prospecting_loot_template as plt")
    .leftJoin("item_template as it", "plt.Item", "it.entry")
    .leftJoin("item_template_locale as itl", function() {
      this.on("it.entry", "=", "itl.ID").andOn("itl.locale", "=", knex().raw("?", "zhCN"));
    })
    .where("plt.Entry", payload.Entry);

  queryBuilder.then(rows => {
    event.reply(SEARCH_PROSPECTING_LOOT_TEMPLATES, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

ipcMain.on(SEARCH_MILLING_LOOT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select(["mlt.*", "it.name", "itl.Name as localeName"])
    .from("milling_loot_template as mlt")
    .leftJoin("item_template as it", "mlt.Item", "it.entry")
    .leftJoin("item_template_locale as itl", function() {
      this.on("it.entry", "=", "itl.ID").andOn("itl.locale", "=", knex().raw("?", "zhCN"));
    })
    .where("mlt.Entry", payload.Entry);

  queryBuilder.then(rows => {
    event.reply(SEARCH_MILLING_LOOT_TEMPLATES, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});
