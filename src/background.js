"use strict";

import { app, protocol, BrowserWindow, ipcMain, dialog, Menu } from "electron";
import { createProtocol } from "vue-cli-plugin-electron-builder/lib";

import "./background/initiator";
import "./background/exporter";
import "./background/achievement";
import "./background/achievementCategorySelector";
import "./background/achievementCriteria";
import "./background/areaTable";
import "./background/areaTableOrQuestSortSelector";
import "./background/broadcastTextSelector";
import "./background/charTitleSelector";
import "./background/creatureTemplate";
import "./background/creatureTemplateLocale";
import "./background/creatureTemplateAddon";
import "./background/creatureTemplateResistance";
import "./background/creatureTemplateSpell";
import "./background/creatureOnKillReputation";
import "./background/creatureEquipTemplate";
import "./background/creatureQuestItem";
import "./background/currencyCategory";
import "./background/currencyCategorySelector";
import "./background/currencyType";
import "./background/emoteSelector";
import "./background/emoteText";
import "./background/npcVendor";
import "./background/npcTrainer";
import "./background/creatureLootTemplate";
import "./background/pickpocketingLootTemplate";
import "./background/skinningLootTemplate";
import "./background/itemTemplate";
import "./background/itemTemplateLocale";
import "./background/itemTemplateSelector";
import "./background/itemEnchantmentTemplate";
import "./background/itemLootTemplate";
import "./background/disenchantLootTemplate";
import "./background/prospectingLootTemplate";
import "./background/mapSelector";
import "./background/millingLootTemplate";
import "./background/gameObjectDisplayInfoSelector";
import "./background/gameObjectTemplate";
import "./background/gameObjectTemplateLocale";
import "./background/gameObjectTemplateAddon";
import "./background/gameObjectQuestItem";
import "./background/gameObjectLootTemplate";
import "./background/questTemplate";
import "./background/questTemplateLocale";
import "./background/questTemplateAddon";
import "./background/questOfferReward";
import "./background/questRequestItems";
import "./background/creatureQuestStarter";
import "./background/creatureQuestEnder";
import "./background/gameObjectQuestStarter";
import "./background/gameObjectQuestEnder";
import "./background/gossipMenu";
import "./background/npcText";
import "./background/npcTextLocale";
import "./background/gossipMenuOption";
import "./background/questFactionReward";
import "./background/smartScript";
import "./background/spell";
import "./background/spellArea";
import "./background/spellBonusData";
import "./background/spellCustomAttr";
import "./background/spellGroup";
import "./background/spellLinkedSpell";
import "./background/spellLootTemplate";
import "./background/referenceLootTemplateCard";
import "./background/scalingStatDistribution";
import "./background/scalingStatValue";
import "./background/itemExtendedCost";
import "./background/itemExtendedCostSelector";
import "./background/itemSet";
import "./background/pageText";
import "./background/pageTextLocale";
import "./background/pageTextSelector";
import "./background/lockSelector";
import "./background/talent";
import "./background/talentTab";
import "./background/referenceLootTemplate";
import "./background/factionSelector";
import "./background/factionTemplateSelector";
import "./background/creatureSpellDataSelector";
import "./background/creatureModelInfoSelector";
import "./background/creatureTemplateSelector";
import "./background/spellSelector";
import "./background/spellCastTimeSelector";
import "./background/spellCategorySelector";
import "./background/spellDescriptionVariableSelector";
import "./background/spellDifficultySelector";
import "./background/spellDurationSelector";
import "./background/spellIconSelector";
import "./background/spellItemEnchantment";
import "./background/spellRangeSelector";
import "./background/gossipMenuSelector";
import "./background/scalingStatDistributionSelector";
import "./background/waypointDataSelector";
import "./background/itemSetSelector";
import "./background/itemEnchantmentTemplateSelector";
import "./background/itemRandomPropertiesSelector";
import "./background/itemRandomSuffixSelector";
import "./background/itemDisplayInfoSelector";
import "./background/questInfo";
import "./background/questInfoSelector";
import "./background/questSort";
import "./background/questTemplateSelector";
import "./background/version";

const isDevelopment = process.env.NODE_ENV !== "production";

const path = require("path");

let win;

protocol.registerSchemesAsPrivileged([
  { scheme: "app", privileges: { secure: true, standard: true } },
]);

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
      preload: path.join(__dirname, "preload.js"),
    },
  });

  const appMenuTemplate = [
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
    {
      label: "关于",
      submenu: [
        {
          label: "关于Foxy",
          click() {
            dialog.showMessageBox({
              message:
                "Foxy by Cals Ranna\n\n一款致力于让自定义变得更简单的魔兽世界编辑器。",
              buttons: ["确定"],
            });
          },
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
          acclerator: "CmdOrCtrl+Q",
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

process.on("uncaughtException", (error) => {
  win.webContents.send("GLOBAL_MESSAGE_BOX", error);
});

process.on("unhandledRejection", (error) => {
  win.webContents.send("GLOBAL_MESSAGE_BOX", error);
});

ipcMain.on("SELECT_DBC_PATH", (event) => {
  dialog.showOpenDialog({ properties: ["openDirectory"] }).then((payload) => {
    event.reply("SELECT_DBC_PATH_REPLY", payload.filePaths[0]);
  });
});

ipcMain.on("SELECT_CONFIG_PATH", (event) => {
  dialog.showOpenDialog({ properties: ["openDirectory"] }).then((payload) => {
    event.reply("SELECT_CONFIG_PATH_REPLY", payload.filePaths[0]);
  });
});

ipcMain.on("RELOAD_APP", (event) => {
  win.reload();
});
