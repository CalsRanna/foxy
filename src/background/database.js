const { knex, init } = require("../libs/mysql");

import { ipcMain } from "electron";
import { INIT_MYSQL_CONNECTION, TEST_MYSQL_CONNECTION } from "../constants";

ipcMain.on(INIT_MYSQL_CONNECTION, (event, payload) => {
  init(payload);
  event.reply(INIT_MYSQL_CONNECTION);
});

ipcMain.on(TEST_MYSQL_CONNECTION, (event, payload) => {
  init(payload);
  // 尝试连接数据库，校验配置是否正确
  try {
    knex()
      .select("guid")
      .from("creature")
      .first()
      .then((rows) => {
        event.reply("GLOBAL_NOTICE", {
          category: "notification",
          title: "成功",
          message: `数据库配置检验成功。`,
          type: "success",
        });
        event.reply(TEST_MYSQL_CONNECTION);
      });
  } catch (error) {
    event.reply("GLOBAL_NOTICE", {
      category: "alert",
      title: "发生未知错误",
      message: error.statck,
      type: "success",
    });
  }
});
