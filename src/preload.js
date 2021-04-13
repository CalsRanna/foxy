const { ipcRenderer } = require("electron");
const { shell } = require("electron");

window.ipcRenderer = ipcRenderer;
window.shell = shell;
