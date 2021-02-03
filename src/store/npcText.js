const ipcRenderer = window.require("electron").ipcRenderer;

import {
  STORE_NPC_TEXT,
  FIND_NPC_TEXT,
  UPDATE_NPC_TEXT,
  CREATE_NPC_TEXT,
} from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      npcText: {},
    };
  },
  actions: {
    storeNpcText(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_NPC_TEXT, payload);
        ipcRenderer.on(STORE_NPC_TEXT, () => {
          resolve();
        });
        ipcRenderer.on(`${STORE_NPC_TEXT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findNpcText({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_NPC_TEXT, payload);
        ipcRenderer.on(FIND_NPC_TEXT, (event, response) => {
          commit(FIND_NPC_TEXT, response);
          resolve();
        });
        ipcRenderer.on(`${FIND_NPC_TEXT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateNpcText({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_NPC_TEXT, payload);
        ipcRenderer.on(UPDATE_NPC_TEXT, () => {
          commit(UPDATE_NPC_TEXT, payload.npcText);
          resolve();
        });
        ipcRenderer.on(`${UPDATE_NPC_TEXT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createNpcText({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_NPC_TEXT, payload);
        resolve();
      });
    },
  },
  mutations: {
    [FIND_NPC_TEXT](state, npcText) {
      state.npcText = npcText;
    },
    [UPDATE_NPC_TEXT](state, npcText) {
      state.npcText = npcText;
    },
    [CREATE_NPC_TEXT](state, npcText) {
      state.npcText = npcText;
    },
  },
};
