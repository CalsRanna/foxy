const ipcRenderer = window.require("electron").ipcRenderer;

import { STORE_NPC_TEXT, FIND_NPC_TEXT, UPDATE_NPC_TEXT } from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      npcText: {},
    };
  },
  actions: {
    storeNpcText(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(STORE_NPC_TEXT, payload);
        ipcRenderer.on(STORE_NPC_TEXT, () => {
          resolve();
        });
      });
    },
    findNpcText({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(FIND_NPC_TEXT, payload);
        ipcRenderer.on(FIND_NPC_TEXT, (event, response) => {
          commit(FIND_NPC_TEXT, response);
          resolve();
        });
      });
    },
    updateNpcText({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(UPDATE_NPC_TEXT, payload);
        ipcRenderer.on(UPDATE_NPC_TEXT, () => {
          commit(UPDATE_NPC_TEXT, payload.npcText);
          resolve();
        });
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
  },
};
