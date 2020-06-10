import { remote } from "electron";

export default {
  test() {
    const BrowserWindow = remote.BrowserWindow;
    var win = new BrowserWindow({ width: 800, height: 600 });
    win.loadURL("https://github.com");
  },
};
