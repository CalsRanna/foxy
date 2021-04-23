import path from 'path'
import { app, BrowserWindow,Menu } from "electron";
 import dotenv from 'dotenv'
import { MenuItemConstructorOptions } from 'electron/main';

 const isDevelopment = process.env.NODE_ENV !== "production";
 
 dotenv.config({ path: path.join(__dirname, '../../.env') })
 
 let win: BrowserWindow | null;
 
 function createWindow() {
  win = new BrowserWindow({
    title: "Foxy",
    width: 1440,
    height: 900,
    show: false,
    frame: true,
    webPreferences: {
      nodeIntegration: true,
      contextIsolation: false,
      // preload: path.join(__dirname, "preload.js"),
    },
  });

  const appMenuTemplate: MenuItemConstructorOptions[] = [
    {
      label: "文件",
      submenu: [{ label: "退出", accelerator: "CmdOrCtrl+Q", role: "quit" }],
    },
    {
      label: "工具",
      submenu: [
        {
          label: "导出",
          accelerator: "CmdOrCtrl+S",
          click() {
            win.webContents.send("START_EXPORT");
          },
        },
      ],
    },
    {
      label: "页面",
      submenu: [
        {
          label: "刷新",
          accelerator: "CmdOrCtrl+R",
          role: "forceReload",
        },
        {
          label: "控制台",
          role: "toggleDevTools",
        },
      ],
    },
  ];

  if (process.platform === "darwin") {
    appMenuTemplate.unshift({
      label: app.getName(),
      submenu: [
        {
          label: "退出",
          accelerator: "CmdOrCtrl+Q",
          click() {
            app.quit();
          },
        },
      ],
    });
  }

  const appMenu = Menu.buildFromTemplate(appMenuTemplate);
  Menu.setApplicationMenu(appMenu);

  win.maximize();
  win.show();

  if (isDevelopment) {
    win.loadURL(`http://localhost:${process.env.PORT}`);
  } else {
    win.loadURL(`file://${path.join(__dirname, '../../dist/render/index.html')}`);
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