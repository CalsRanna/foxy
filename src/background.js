"use strict";

import { app, protocol, BrowserWindow, Menu } from "electron";
import {
  createProtocol,
  // installVueDevtools,
} from "vue-cli-plugin-electron-builder/lib";
const isDevelopment = process.env.NODE_ENV !== "production";

// Keep a global reference of the window object, if you don't, the window will
// be closed automatically when the JavaScript object is garbage collected.
let win;

// Scheme must be registered before the app is ready
protocol.registerSchemesAsPrivileged([
  { scheme: "app", privileges: { secure: true, standard: true } },
]);

let menuTemplate = [
  {
    label: "文件",
    submenu: [
      {
        label: "新建",
        accelerator: "CmdOrCtrl+N",
        role: "new",
      },
      {
        label: "打开文件",
        accelerator: "CmdOrCtrl+O",
        role: "open",
      },
    ],
  },
  {
    label: "窗口",
    role: "window",
    submenu: [
      {
        label: "重新加载",
        accelerator: "CmdOrCtrl+R",
        click: function(item, focusedWindow) {
          if (focusedWindow) {
            // on reload, start fresh and close any old
            // open secondary windows
            if (focusedWindow.id === 1) {
              BrowserWindow.getAllWindows().forEach(function(win) {
                if (win.id > 1) {
                  win.close();
                }
              });
            }
            focusedWindow.reload();
          }
        },
      },
      {
        label: "最小化",
        role: "minimize",
      },
      {
        label: "关闭",
        role: "close",
      },
      {
        label: "开发者工具",
        accelerator: (function() {
          if (process.platform === "darwin") {
            return "Alt+Command+I";
          } else {
            return "F12";
          }
        })(),
        click: function(item, focusedWindow) {
          if (focusedWindow) {
            focusedWindow.toggleDevTools();
          }
        },
      },
      {
        type: "separator",
      },
    ],
  },
  {
    label: "帮助",
    role: "help",
    submenu: [
      {
        label: "帮助中心",
        click: function() {
          shell.openExternal("https://forum.iptchain.net");
        },
      },
      {
        label: "报告问题",
        click: function() {
          electron.shell.openExternal("https://forum.iptchain.net");
        },
      },
      {
        label: "关于Foxy",
        click: function() {
          electron.shell.openExternal("https://forum.iptchain.net");
        },
      },
    ],
  },
];

function createMenu() {
  const menu = Menu.buildFromTemplate(menuTemplate);
  Menu.setApplicationMenu(menu);
}

function createWindow() {
  // Create the browser window.
  win = new BrowserWindow({
    width: 800,
    height: 600,
    webPreferences: {
      // Use pluginOptions.nodeIntegration, leave this alone
      // See nklayman.github.io/vue-cli-plugin-electron-builder/guide/security.html#node-integration for more info
      nodeIntegration: process.env.ELECTRON_NODE_INTEGRATION,
    },
    show: false,
    title: "Foxy",
  });

  win.maximize();
  win.show();

  if (process.env.WEBPACK_DEV_SERVER_URL) {
    // Load the url of the dev server if in development mode
    win.loadURL(process.env.WEBPACK_DEV_SERVER_URL);
    if (!process.env.IS_TEST) win.webContents.openDevTools();
  } else {
    createProtocol("app");
    // Load the index.html when not in development
    win.loadURL("app://./index.html");
  }

  win.on("closed", () => {
    win = null;
  });
}

// Quit when all windows are closed.
app.on("window-all-closed", () => {
  // On macOS it is common for applications and their menu bar
  // to stay active until the user quits explicitly with Cmd + Q
  if (process.platform !== "darwin") {
    app.quit();
  }
});

app.on("activate", () => {
  // On macOS it's common to re-create a window in the app when the
  // dock icon is clicked and there are no other windows open.
  if (win === null) {
    createWindow();
  }
});

// This method will be called when Electron has finished
// initialization and is ready to create browser windows.
// Some APIs can only be used after this event occurs.
app.on("ready", async () => {
  if (isDevelopment && !process.env.IS_TEST) {
    // Install Vue Devtools
    // Devtools extensions are broken in Electron 6.0.0 and greater
    // See https://github.com/nklayman/vue-cli-plugin-electron-builder/issues/378 for more info
    // Electron will not launch with Devtools extensions installed on Windows 10 with dark mode
    // If you are not using Windows 10 dark mode, you may uncomment these lines
    // In addition, if the linked issue is closed, you can upgrade electron and uncomment these lines
    // try {
    //   await installVueDevtools()
    // } catch (e) {
    //   console.error('Vue Devtools failed to install:', e.toString())
    // }
  }
  createMenu();
  createWindow();
});

// Exit cleanly on request from parent process in development mode.
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
