const ipcRenderer = window.require("electron").ipcRenderer;

import {
  FIND_VERSION
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    version: {},
  }),
  actions: {
    findVersion({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_VERSION);
        ipcRenderer.on(FIND_VERSION, (event, version) => {
          commit(FIND_VERSION, version);
          resolve();
        });
        ipcRenderer.on(`${FIND_VERSION}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
  },
  mutations: {
    [FIND_VERSION](state, version) {
      state.version = version;
    },
  },
};
