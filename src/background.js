"use strict";

import { app, protocol, BrowserWindow, ipcMain } from "electron";
import { createProtocol } from "vue-cli-plugin-electron-builder/lib";

import creature from "./background/creature.js";

const isDevelopment = process.env.NODE_ENV !== "production";

let win;

protocol.registerSchemesAsPrivileged([
  { scheme: "app", privileges: { secure: true, standard: true } },
]);

function createWindow() {
  win = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      // nodeIntegration: process.env.ELECTRON_NODE_INTEGRATION,
      nodeIntegration: true,
    },
    show: false,
    title: "Foxy",
    frame: true,
    // maximizable: false,
    // fullscreen: true,
  });

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
    process.on("message", (data) => {
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

ipcMain.on("OPEN_SETTING_VIEW", (event) => {
  let window = new BrowserWindow({
    width: 800,
    height: 600,
    frame: false,
    parent: win,
    webPreferences: {
      nodeIntegration: true,
    },
  });
  window.on("closed", () => {
    window = null;
  });
  if (process.env.WEBPACK_DEV_SERVER_URL) {
    win.loadURL(`${process.env.WEBPACK_DEV_SERVER_URL}/setting.html`);
  } else {
    createProtocol("app");
    win.loadURL("app://./setting.html");
  }
});

ipcMain.on("LOAD_ICONS", (event) => {
  event.reply("LOAD_ICONS_REPLY", 123);
});

ipcMain.on("LOAD_SPELLS", (event) => {
  event.returnValue = "加载技能中……";
});
