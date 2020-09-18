let mysql = require("./mysql");

const { ipcMain } = require("electron");

ipcMain.on("INIT_DATABASE_POOL", (event, payload) => {
  mysql.createPool(payload);
  // 尝试连接数据库，校验配置是否正确
  try {
    mysql
      .query("select guid from creature")
      .then(() => {
        event.reply("UPDATE_MESSAGE_REPLY", {
          category: "notification",
          title: "成功",
          message: `数据库配置检验成功，已更新并保存。`,
          type: "success"
        });
      })
      .catch(error => {
        event.reply("UPDATE_MESSAGE_REPLY", {
          category: "notification",
          title: "失败",
          message: `数据库配置检验失败: ${error}`,
          type: "error"
        });
      });
  } catch (error) {
    event.reply("UPDATE_MESSAGE_REPLY", {
      category: "notification",
      title: "失败",
      message: `数据库连接失败，请检查配置信息。`,
      type: "warning"
    });
  }
});
