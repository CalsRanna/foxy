const { knex, init } = require("../libs/mysql");

const { ipcMain } = require("electron");

ipcMain.on("INIT_DATABASE_POOL", (event, payload) => {
  init(payload);
  // 尝试连接数据库，校验配置是否正确
  knex()
    .select("guid")
    .from("creature")
    .then(rows => {
      event.reply("GLOBAL_NOTICE", {
        category: "notification",
        title: "成功",
        message: `数据库配置检验成功，已更新并保存。`,
        type: "success"
      });
      event.reply("INIT_DATABASE_POOL");
    });
  // try {
  //   mysql
  //     .query("select guid from creature")
  //     .then(() => {
  //       event.reply("GLOBAL_NOTICE", {
  //         category: "notification",
  //         title: "成功",
  //         message: `数据库配置检验成功，已更新并保存。`,
  //         type: "success"
  //       });
  //       event.reply("INIT_DATABASE_POOL");
  //     })
  //     .catch(error => {
  //       event.reply("GLOBAL_NOTICE", {
  //         category: "notification",
  //         title: "失败",
  //         message: `数据库配置检验失败: ${error}`,
  //         type: "error"
  //       });
  //       event.reply("INIT_DATABASE_POOL");
  //     });
  // } catch (error) {
  //   event.reply("GLOBAL_NOTICE", {
  //     category: "notification",
  //     title: "失败",
  //     message: `数据库连接失败，请检查配置信息。`,
  //     type: "warning"
  //   });
  //   event.reply("INIT_DATABASE_POOL");
  // }
});
