import { ipcMain } from "electron";

import {
  SEARCH_SPELLS,
  COUNT_SPELLS,
  STORE_SPELL,
  FIND_SPELL,
  UPDATE_SPELL,
  DESTROY_SPELL,
  CREATE_SPELL,
  COPY_SPELL,
  GLOBAL_NOTICE,
} from "../constants";

const { foxyKnex } = require("../libs/mysql");

ipcMain.on(SEARCH_SPELLS, (event, payload) => {
  let queryBuilder = foxyKnex()
    .select([
      "ds.ID as ID",
      "Name_Lang_zhCN",
      "NameSubtext_Lang_zhCN",
      "Description_Lang_zhCN",
      "AuraDescription_Lang_zhCN",
      "DurationIndex",
      "EffectBasePoints_1",
      "EffectBasePoints_2",
      "EffectBasePoints_3",
      "EffectDieSides_1",
      "EffectDieSides_2",
      "EffectDieSides_3",
      "EffectAuraPeriod_1",
      "EffectAuraPeriod_2",
      "EffectAuraPeriod_3",
      "ProcCharges",
      "dsd.Duration as Duration",
    ])
    .from("dbc_spell as ds")
    .leftJoin("dbc_spell_duration as dsd", "ds.DurationIndex", "dsd.ID");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ds.ID", "like", `%${payload.ID}%`);
  }
  if (payload.Name) {
    queryBuilder = queryBuilder.where(
      "Name_Lang_zhCN",
      "like",
      `%${payload.Name}%`
    );
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_SPELLS, rows);
    })
    .catch((error) => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(COUNT_SPELLS, (event, payload) => {
  let queryBuilder = foxyKnex()
    .count("* as total")
    .from("dbc_spell as ds")
    .leftJoin("dbc_spell_duration as dsd", "ds.DurationIndex", "dsd.ID");
  if (payload.ID) {
    queryBuilder = queryBuilder.where("ds.ID", "like", `%${payload.ID}%`);
  }
  if (payload.Name) {
    queryBuilder = queryBuilder.where(
      "Name_Lang_zhCN",
      "like",
      `%${payload.Name}%`
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_SPELLS, rows[0].total);
    })
    .catch((error) => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(STORE_SPELL, (event, payload) => {
  let queryBuilder = foxyKnex()
    .insert(payload)
    .into("dbc_spell");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_SPELL, rows);
      event.reply(GLOBAL_NOTICE, {
        category: "notification",
        title: "成功",
        message: "新建成功。",
        type: "success",
      });
    })
    .catch((error) => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(FIND_SPELL, (event, payload) => {
  let queryBuilder = foxyKnex()
    .select()
    .from("dbc_spell")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_SPELL, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(UPDATE_SPELL, (event, payload) => {
  let queryBuilder = foxyKnex()
    .table("dbc_spell")
    .where(payload.credential)
    .update(payload.spell);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_SPELL, rows);
      event.reply(GLOBAL_NOTICE, {
        category: "notification",
        title: "成功",
        message: "修改成功。",
        type: "success",
      });
    })
    .catch((error) => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(DESTROY_SPELL, (event, payload) => {
  let queryBuilder = foxyKnex()
    .table("dbc_spell")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_SPELL, rows);
      event.reply("GLOBAL_NOTICE", {
        category: "notification",
        title: "成功",
        message: "删除成功。",
        type: "success",
      });
    })
    .catch((error) => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(CREATE_SPELL, (event, payload) => {
  let queryBuilder = foxyKnex()
    .select("ID")
    .from("dbc_spell")
    .orderBy("ID", "desc");

  queryBuilder
    .then((rows) => {
      event.reply(CREATE_SPELL, {
        ID: rows[0].ID + 1,
      });
    })
    .catch((error) => {
      throw error;
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(COPY_SPELL, (event, payload) => {
  let ID = undefined;
  let spell = undefined;

  let IDQueryBuilder = foxyKnex()
    .select("ID")
    .from("dbc_spell")
    .orderBy("ID", "desc");
  let findSpellQueryBuilder = foxyKnex()
    .select()
    .from("dbc_spell")
    .where(payload);
  Promise.all([
    IDQueryBuilder.then((rows) => {
      ID = rows[0].ID;
    }),
    findSpellQueryBuilder.then((rows) => {
      spell = rows.length > 0 ? rows[0] : {};
    }),
  ]).then(() => {
    spell.ID = ID + 1;
    let queryBuilder = foxyKnex()
      .insert(spell)
      .into("dbc_spell");
    queryBuilder
      .then((rows) => {
        event.reply(COPY_SPELL, rows);
        event.reply(GLOBAL_NOTICE, {
          type: "success",
          category: "notification",
          title: "成功",
          message: `复制成功，新的技能ID为${ID + 1}。`,
        });
      })
      .catch((error) => {
        throw error;
      })
      .finally(() => {
        event.reply(GLOBAL_NOTICE, {
          category: "message",
          message: queryBuilder.toString(),
        });
      });
  });
});
