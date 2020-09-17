let mysql = require("./mysql");

const { ipcMain } = require("electron");

ipcMain.on("INIT_DATABASE_POOL", (event, payload) => {
  mysql.createPool(payload);
});
