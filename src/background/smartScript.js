import { ipcMain } from "electron";
import {
  SEARCH_SMART_SCRIPTS,
  COUNT_SMART_SCRIPTS,
  STORE_SMART_SCRIPT,
  FIND_SMART_SCRIPT,
  UPDATE_SMART_SCRIPT,
  DESTROY_SMART_SCRIPT,
  COPY_SMART_SCRIPT,
  GLOBAL_NOTICE,
} from "../constants";

const { knex } = require("../libs/mysql");

ipcMain.on(SEARCH_SMART_SCRIPTS, (event, payload) => {
  let queryBuilder = knex()
    .select([
      "ss.entryorguid",
      "ss.source_type",
      "ss.id",
      "ss.link",
      "ss.event_type",
      "ss.action_type",
      "ss.target_type",
      "ss.comment",
    ])
    .from("smart_scripts as ss");
  if (payload.entryorguid) {
    queryBuilder = queryBuilder.where(
      "ss.entryorguid",
      "like",
      `%${payload.entryorguid}%`
    );
  }
  if (payload.comment) {
    queryBuilder = queryBuilder.where(
      "ss.comment",
      "like",
      `%${payload.comment}%`
    );
  }
  queryBuilder = queryBuilder
    .limit(50)
    .offset(payload.page != undefined ? (payload.page - 1) * 50 : 0);

  queryBuilder
    .then((rows) => {
      event.reply(SEARCH_SMART_SCRIPTS, rows);
    })
    .catch((error) => {
      event.reply(`${SEARCH_SMART_SCRIPTS}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(COUNT_SMART_SCRIPTS, (event, payload) => {
  let queryBuilder = knex()
    .count("* as total")
    .from("smart_scripts as ss");
  if (payload.entryorguid) {
    queryBuilder = queryBuilder.where(
      "ss.entryorguid",
      "like",
      `%${payload.entryorguid}%`
    );
  }
  if (payload.comment) {
    queryBuilder = queryBuilder.where(
      "ss.comment",
      "like",
      `%${payload.comment}%`
    );
  }

  queryBuilder
    .then((rows) => {
      event.reply(COUNT_SMART_SCRIPTS, rows[0].total);
    })
    .catch((error) => {
      event.reply(`${COUNT_SMART_SCRIPTS}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(STORE_SMART_SCRIPT, (event, payload) => {
  let queryBuilder = knex()
    .insert(payload)
    .into("smart_scripts");

  queryBuilder
    .then((rows) => {
      event.reply(STORE_SMART_SCRIPT, rows);
      event.reply(GLOBAL_NOTICE, {
        category: "notification",
        title: "成功",
        message: "新建成功。",
        type: "success",
      });
    })
    .catch((error) => {
      event.reply(`${STORE_SMART_SCRIPT}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(FIND_SMART_SCRIPT, (event, payload) => {
  let queryBuilder = knex()
    .select()
    .from("smart_scripts")
    .where(payload);

  queryBuilder
    .then((rows) => {
      event.reply(FIND_SMART_SCRIPT, rows.length > 0 ? rows[0] : {});
    })
    .catch((error) => {
      event.reply(`${FIND_SMART_SCRIPT}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

// payload包含修改后的smartScript和credential, 单主键时默认为主键
ipcMain.on(UPDATE_SMART_SCRIPT, (event, payload) => {
  let queryBuilder = knex()
    .table("smart_scripts")
    .where(payload.credential)
    .update(payload.smartScript);

  queryBuilder
    .then((rows) => {
      event.reply(UPDATE_SMART_SCRIPT, rows);
      event.reply(GLOBAL_NOTICE, {
        category: "notification",
        title: "成功",
        message: "修改成功。",
        type: "success",
      });
    })
    .catch((error) => {
      event.reply(`${UPDATE_SMART_SCRIPT}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(DESTROY_SMART_SCRIPT, (event, payload) => {
  let queryBuilder = knex()
    .table("smart_scripts")
    .where(payload)
    .delete();

  queryBuilder
    .then((rows) => {
      event.reply(DESTROY_SMART_SCRIPT, rows);
      event.reply("GLOBAL_NOTICE", {
        category: "notification",
        title: "成功",
        message: "删除成功。",
        type: "success",
      });
    })
    .catch((error) => {
      event.reply(`${DESTROY_SMART_SCRIPT}_REJECT`, error);
    })
    .finally(() => {
      event.reply(GLOBAL_NOTICE, {
        category: "message",
        message: queryBuilder.toString(),
      });
    });
});

ipcMain.on(COPY_SMART_SCRIPT, (event, payload) => {
  let id = undefined;
  let smartScript = undefined;

  let idQueryBuilder = knex()
    .select("id")
    .from("smart_scripts")
    .where(payload)
    .orderBy("id", "desc");
  let findSmartScriptQueryBuilder = knex()
    .select()
    .from("smart_scripts")
    .where(payload);
  Promise.all([
    idQueryBuilder.then((rows) => {
      id = rows[0].id;
    }),
    findSmartScriptQueryBuilder.then((rows) => {
      smartScript = rows.length > 0 ? rows[0] : {};
    }),
  ])
    .then(() => {
      smartScript.id = id + 1;
      let queryBuilder = knex()
        .insert(smartScript)
        .into("smart_scripts");
      queryBuilder
        .then((rows) => {
          event.reply(COPY_SMART_SCRIPT, rows);
          event.reply(GLOBAL_NOTICE, {
            type: "success",
            category: "notification",
            title: "成功",
            message: `复制成功，新的物体模板 id 为 ${id + 1}。`,
          });
          event.reply(GLOBAL_NOTICE, {
            category: "message",
            message: queryBuilder.toString(),
          });
        })
        .catch((error) => {
          event.reply(`${COPY_SMART_SCRIPT}_REJECT`, error);
        })
        .finally(() => {
          event.reply(GLOBAL_NOTICE, {
            category: "message",
            message: queryBuilder.toString(),
          });
        });
    })
    .catch((error) => {
      event.reply(`${COPY_SMART_SCRIPT}_REJECT`, error);
    });
});
