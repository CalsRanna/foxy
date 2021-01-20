"use strict";

import { app, protocol, BrowserWindow, ipcMain, dialog } from "electron";
import { createProtocol } from "vue-cli-plugin-electron-builder/lib";

import "./background/dbc";
// import "./background/creature";
import "./background/creatureTemplate";
import "./background/creatureTemplateLocale";
import "./background/creatureTemplateAddon";
import "./background/creatureOnKillReputation";
import "./background/creatureEquipTemplate";
import "./background/creatureQuestItem";
import "./background/npcVendor";
import "./background/npcTrainer";
import "./background/creatureLootTemplate";
import "./background/pickpocketingLootTemplate";
import "./background/skinningLootTemplate";
import "./background/itemTemplate";
import "./background/itemTemplateLocale";
import "./background/itemEnchantmentTemplate";
import "./background/itemLootTemplate";
import "./background/disenchantLootTemplate";
import "./background/prospectingLootTemplate";
import "./background/millingLootTemplate";
import "./background/gameObject";
import "./background/quest";
import "./background/smartScript";
import "./background/database";
import "./background/gossipMenu";

const isDevelopment = process.env.NODE_ENV !== "production";

let win;

protocol.registerSchemesAsPrivileged([
  { scheme: "app", privileges: { secure: true, standard: true } }
]);

function createWindow() {
  win = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      // nodeIntegration: process.env.ELECTRON_NODE_INTEGRATION,
      nodeIntegration: true
    },
    show: false,
    title: "Foxy",
    frame: true
    // maximizable: false,
    // fullscreen: true,
  });

  win.maximize();
  win.show();

  if (process.env.WEBPACK_DEV_SERVER_URL) {
    win.loadURL(process.env.WEBPACK_DEV_SERVER_URL);
  } else {
    createProtocol("app");
    win.loadURL("app://./index.html");
  }

  win.on("closed", () => {
    win = null;
  });
}

app.on("window-all-closed", () => {
  if (process.platform !== "darwin") {
    app.quit();
  }
});

app.on("activate", () => {
  if (win === null) {
    createWindow();
  }
});

app.on("ready", async () => {
  createWindow();
});

if (isDevelopment) {
  if (process.platform === "win32") {
    process.on("message", data => {
      if (data === "graceful-exit") {
        app.quit();
      }
    });
  } else {
    process.on("SIGTERM", () => {
      app.quit();
    });
  }
}

process.on("uncaughtException", error => {
  win.webContents.send("GLOBAL_NOTICE", {
    category: "alert",
    type: "error",
    title: `${error.code}`,
    message: `${error.message}<br>${error.stack}`
  });
});

ipcMain.on("SELECT_DBC_PATH", event => {
  dialog.showOpenDialog({ properties: ["openDirectory"] }).then(payload => {
    event.reply("SELECT_DBC_PATH_REPLY", payload.filePaths[0]);
  });
});

ipcMain.on("SELECT_CONFIG_PATH", event => {
  dialog.showOpenDialog({ properties: ["openDirectory"] }).then(payload => {
    event.reply("SELECT_CONFIG_PATH_REPLY", payload.filePaths[0]);
  });
});
