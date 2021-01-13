import { ipcMain } from "electron";
import {
  COPY_CREATURE_TEMPLATE,
  COUNT_CREATURE_TEMPLATES,
  CREATE_CREATURE_TEMPLATE,
  DESTROY_CREATURE_TEMPLATE,
  FIND_CREATURE_ONKILL_REPUTATION,
  FIND_CREATURE_TEMPLATE,
  FIND_CREATURE_TEMPLATE_ADDON,
  GLOBAL_NOTICE,
  SEARCH_CREATURE_EQUIP_TEMPLATES,
  SEARCH_CREATURE_LOOT_TEMPLATES,
  SEARCH_CREATURE_QUEST_ITEMS,
  SEARCH_CREATURE_REFERENCE_LOOT_TEMPLATES,
  SEARCH_CREATURE_TEMPLATES,
  SEARCH_CREATURE_TEMPLATE_LOCALES,
  SEARCH_NPC_TRAINERS,
  SEARCH_NPC_VENDORS,
  SEARCH_PICKPOCKETING_LOOT_TEMPLATES,
  SEARCH_SKINNING_LOOT_TEMPLATES,
  STORE_CREATURE_ONKILL_REPUTATION,
  STORE_CREATURE_TEMPLATE,
  STORE_CREATURE_TEMPLATE_ADDON,
  STORE_CREATURE_TEMPLATE_LOCALES,
  UPDATE_CREATURE_ONKILL_REPUTATION,
  UPDATE_CREATURE_TEMPLATE,
  UPDATE_CREATURE_TEMPLATE_ADDON
} from "../constants";

const { knex } = require("../libs/mysql");

// 搜索满足条件的生物模板
ipcMain.on(SEARCH_CREATURE_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select([
      "ct.entry",
      "ct.name",
      "ctl.Name as localeName",
      "ct.subname",
      "ctl.Title as localeTitle",
      "ct.minlevel",
      "ct.maxlevel"
    ])
    .from("creature_template as ct")
    .leftJoin("creature_template_locale as ctl", function() {
      this.on("ct.entry", "=", "ctl.entry").andOn("ctl.locale", "=", knex().raw("?", "zhCN"));
    });
  if (payload.entry) {
    queryBuilder = queryBuilder.where("ct.entry", "like", `%${payload.entry}%`);
  }
  if (payload.name) {
    queryBuilder = queryBuilder.where(builder =>
      builder.where("ct.name", "like", `%${payload.name}%`).orWhere("ctl.Name", "like", `%${payload.name}%`)
    );
  }
  if (payload.subname) {
    queryBuilder = queryBuilder.where(builder =>
      builder.where("ct.subname", "like", `%${payload.subname}%`).orWhere("ctl.Title", "like", `%${payload.subname}%`)
    );
  }
  queryBuilder = queryBuilder.limit(50).offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder.then(rows => {
    event.reply(SEARCH_CREATURE_TEMPLATES, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

// 计算满足条件的生物模板数量
ipcMain.on(COUNT_CREATURE_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("creature_template as ct")
    .leftJoin("creature_template_locale as ctl", function() {
      this.on("ct.entry", "=", "ctl.entry").andOn("ctl.locale", "=", knex().raw("?", "zhCN"));
    });
  if (payload.entry) {
    queryBuilder = queryBuilder.where("ct.entry", "like", `%${payload.entry}%`);
  }
  if (payload.name) {
    queryBuilder = queryBuilder.where(builder =>
      builder.where("ct.name", "like", `%${payload.name}%`).orWhere("ctl.Name", "like", `%${payload.name}%`)
    );
  }
  if (payload.subname) {
    queryBuilder = queryBuilder.where(builder =>
      builder.where("ct.subname", "like", `%${payload.subname}%`).orWhere("ctl.Title", "like", `%${payload.subname}%`)
    );
  }

  queryBuilder.then(rows => {
    event.reply(COUNT_CREATURE_TEMPLATES, rows[0].total);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

// 保存生物模板
ipcMain.on(STORE_CREATURE_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("creature_template");

  queryBuilder.then(rows => {
    event.reply(STORE_CREATURE_TEMPLATE, rows);
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

// 根据条件得到指定的生物模板
ipcMain.on(FIND_CREATURE_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("creature_template")
    .where(payload);

  queryBuilder.then(rows => {
    event.reply(FIND_CREATURE_TEMPLATE, rows.length > 0 ? rows[0] : {});
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

// 修改生物模板
ipcMain.on(UPDATE_CREATURE_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("creature_template")
    .where("entry", payload.entry)
    .update(payload);

  queryBuilder.then(rows => {
    event.reply(UPDATE_CREATURE_TEMPLATE, rows);
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

// 删除满足条件生物模板
ipcMain.on(DESTROY_CREATURE_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .table("creature_template")
    .where(payload)
    .delete();

  queryBuilder.then(rows => {
    event.reply(DESTROY_CREATURE_TEMPLATE, rows);
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

// 新建空的生物模板，entry自动生成
ipcMain.on(CREATE_CREATURE_TEMPLATE, (event, payload) => {
  let queryBuilder = knex()
    .select("entry")
    .from("creature_template")
    .orderBy("entry", "desc");

  queryBuilder.then(rows => {
    event.reply(CREATE_CREATURE_TEMPLATE, {
      entry: rows[0].entry + 1
    });
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

// 复制满足条件的生物模板
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
    entryQueryBuilder.then(rows => {
      entry = rows[0].entry;
    }),
    findCreatureTemplateQueryBuilder.then(rows => {
      creatureTemplate = rows.length > 0 ? rows[0] : {};
    })
  ]).then(() => {
    creatureTemplate.entry = entry + 1;
    let queryBuilder = knex()
      .insert(creatureTemplate)
      .into("creature_template");
    queryBuilder.then(rows => {
      event.reply(COPY_CREATURE_TEMPLATE, rows);
      event.reply(GLOBAL_NOTICE, {
        type: "success",
        category: "notification",
        title: "成功",
        message: `复制成功，新的生物模板 entry 为 ${entry + 1}。`
      });
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString()
      });
    });
  });
});

// 搜索满足条件的本地化生物模板
ipcMain.on(SEARCH_CREATURE_TEMPLATE_LOCALES, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("creature_template_locale")
    .where(payload);

  queryBuilder.then(rows => {
    event.reply(SEARCH_CREATURE_TEMPLATE_LOCALES, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

// 保存本地化生物模板，批量保存
ipcMain.on(STORE_CREATURE_TEMPLATE_LOCALES, (event, payload) => {
  let deleteQueryBuilder = knex()
    .table("creature_template_locale")
    .where("entry", payload[0].entry)
    .delete();
  let insertQueryBuilder = knex()
    .insert(payload)
    .into("creature_template_locale");

  deleteQueryBuilder.then(rows => {
    insertQueryBuilder.then(rows => {
      event.reply(STORE_CREATURE_TEMPLATE_LOCALES, rows);
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

// 保存生物模板补充信息
ipcMain.on(STORE_CREATURE_TEMPLATE_ADDON, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("creature_template_addon");

  queryBuilder.then(rows => {
    event.reply(STORE_CREATURE_TEMPLATE_ADDON, rows);
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

// 根据条件得到指定的生物模板补充信息
ipcMain.on(FIND_CREATURE_TEMPLATE_ADDON, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("creature_template_addon")
    .where(payload);

  queryBuilder.then(rows => {
    event.reply(FIND_CREATURE_TEMPLATE_ADDON, rows.length > 0 ? rows[0] : {});
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

// 修改生物模板补充信息
ipcMain.on(UPDATE_CREATURE_TEMPLATE_ADDON, (event, payload) => {
  let queryBuilder = knex()
    .table("creature_template_addon")
    .where("entry", payload.entry)
    .update(payload);

  queryBuilder.then(rows => {
    event.reply(UPDATE_CREATURE_TEMPLATE_ADDON, rows);
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

// 保存生物击杀声望奖励
ipcMain.on(STORE_CREATURE_ONKILL_REPUTATION, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("creature_onkill_reputation");

  queryBuilder.then(rows => {
    event.reply(STORE_CREATURE_ONKILL_REPUTATION, rows);
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

// 根据条件得到指定的生物击杀声望奖励
ipcMain.on(FIND_CREATURE_ONKILL_REPUTATION, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("creature_onkill_reputation")
    .where(payload);

  queryBuilder.then(rows => {
    event.reply(FIND_CREATURE_ONKILL_REPUTATION, rows.length > 0 ? rows[0] : {});
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

// 修改生物击杀声望奖励
ipcMain.on(UPDATE_CREATURE_ONKILL_REPUTATION, (event, payload) => {
  let queryBuilder = knex()
    .table("creature_onkill_reputation")
    .where("creature_id", payload.creature_id)
    .update(payload);

  queryBuilder.then(rows => {
    event.reply(UPDATE_CREATURE_ONKILL_REPUTATION, rows);
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

// 搜索满足条件的生物装备模板
ipcMain.on(SEARCH_CREATURE_EQUIP_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select([
      "cet.*",
      "it1.displayid as displayid1",
      "it1.name as name1",
      "itl1.Name as Name1",
      "it2.displayid as displayid2",
      "it2.name as name2",
      "itl2.Name as Name2",
      "it3.displayid as displayid3",
      "it3.name as name3",
      "itl3.Name as Name3"
    ])
    .from("creature_equip_template as cet")
    .leftJoin("item_template as it1", "cet.ItemID1", "it1.entry")
    .leftJoin("item_template_locale as itl1", function() {
      this.on("cet.ItemID1", "=", "itl1.ID").andOn("itl1.locale", "=", knex().raw("?", "zhCN"));
    })
    .leftJoin("item_template as it2", "cet.ItemID2", "it2.entry")
    .leftJoin("item_template_locale as itl2", function() {
      this.on("cet.ItemID2", "=", "itl2.ID").andOn("itl2.locale", "=", knex().raw("?", "zhCN"));
    })
    .leftJoin("item_template as it3", "cet.ItemID3", "it3.entry")
    .leftJoin("item_template_locale as itl3", function() {
      this.on("cet.ItemID3", "=", "itl3.ID").andOn("itl3.locale", "=", knex().raw("?", "zhCN"));
    })
    .where("cet.CreatureID", payload.creatureId);

  queryBuilder.then(rows => {
    event.reply(SEARCH_CREATURE_EQUIP_TEMPLATES, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

// 搜索满足条件的商人信息
ipcMain.on(SEARCH_NPC_VENDORS, (event, payload) => {
  let queryBuilder = knex()
    .select(["nv.*", "it.displayid", "it.name", "itl.Name"])
    .from("npc_vendor as nv")
    .leftJoin("item_template as it", "nv.item", "it.entry")
    .leftJoin("item_template_locale as itl", function() {
      this.on("nv.item", "=", "itl.ID").andOn("itl.locale", "=", knex().raw("?", "zhCN"));
    })
    .where("nv.entry", payload.entry);

  queryBuilder.then(rows => {
    event.reply(SEARCH_NPC_VENDORS, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

// 搜索满足条件的训练师信息
ipcMain.on(SEARCH_NPC_TRAINERS, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("npc_trainer")
    .where("ID", payload.id);

  queryBuilder.then(rows => {
    event.reply(SEARCH_NPC_TRAINERS, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

// 搜索满足条件的生物任务物品掉落
ipcMain.on(SEARCH_CREATURE_QUEST_ITEMS, (event, payload) => {
  let queryBuilder = knex()
    .select(["cq.*", "it.name", "itl.Name as localeName"])
    .from("creature_questitem as cq")
    .leftJoin("item_template as it", "cq.ItemId", "it.entry")
    .leftJoin("item_template_locale as itl", function() {
      this.on("it.entry", "=", "itl.ID").andOn("itl.locale", "=", knex().raw("?", "zhCN"));
    })
    .where("cq.CreatureEntry", payload.creatureEntry);

  queryBuilder.then(rows => {
    event.reply(SEARCH_CREATURE_QUEST_ITEMS, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

// 搜索满足条件的生物击杀物品掉落
ipcMain.on(SEARCH_CREATURE_LOOT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select(["clt.*", "it.name", "itl.Name as localeName"])
    .from("creature_loot_template as clt")
    .leftJoin("item_template as it", "clt.Item", "it.entry")
    .leftJoin("item_template_locale as itl", function() {
      this.on("it.entry", "=", "itl.ID").andOn("itl.locale", "=", knex().raw("?", "zhCN"));
    })
    .where("clt.Entry", payload.entry);

  queryBuilder.then(rows => {
    event.reply(SEARCH_CREATURE_LOOT_TEMPLATES, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

ipcMain.on(SEARCH_CREATURE_REFERENCE_LOOT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select(["rlt.*", "it.name", "itl.Name as localeName"])
    .from("reference_loot_template as rlt")
    .leftJoin("item_template as it", "rlt.Item", "it.entry")
    .leftJoin("item_template_locale as itl", function() {
      this.on("it.entry", "=", "itl.ID").andOn("itl.locale", "=", knex().raw("?", "zhCN"));
    })
    .whereIn("rlt.Entry", payload.entries);

  queryBuilder.then(rows => {
    event.reply(SEARCH_CREATURE_REFERENCE_LOOT_TEMPLATES, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

// 搜索满足条件的生物偷窃物品掉落
ipcMain.on(SEARCH_PICKPOCKETING_LOOT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select(["plt.*", "it.name", "itl.Name as localeName"])
    .from("pickpocketing_loot_template as plt")
    .leftJoin("item_template as it", "plt.Item", "it.entry")
    .leftJoin("item_template_locale as itl", function() {
      this.on("it.entry", "=", "itl.ID").andOn("itl.locale", "=", knex().raw("?", "zhCN"));
    })
    .where("plt.Entry", payload.entry);

  queryBuilder.then(rows => {
    event.reply(SEARCH_PICKPOCKETING_LOOT_TEMPLATES, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});

// 搜索满足条件的生物剥皮物品掉落
ipcMain.on(SEARCH_SKINNING_LOOT_TEMPLATES, (event, payload) => {
  let queryBuilder = knex()
    .select(["slt.*", "it.name", "itl.Name as localeName"])
    .from("skinning_loot_template as slt")
    .leftJoin("item_template as it", "slt.Item", "it.entry")
    .leftJoin("item_template_locale as itl", function() {
      this.on("it.entry", "=", "itl.ID").andOn("itl.locale", "=", knex().raw("?", "zhCN"));
    })
    .where("slt.Entry", payload.entry);

  queryBuilder.then(rows => {
    event.reply(SEARCH_SKINNING_LOOT_TEMPLATES, rows);
    event.reply(GLOBAL_NOTICE, {
      category: "message",
      message: queryBuilder.toString()
    });
  });
});
