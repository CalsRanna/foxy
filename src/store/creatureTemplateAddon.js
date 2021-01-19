const ipcRenderer = window.require("electron").ipcRenderer;

import {
  STORE_CREATURE_TEMPLATE_ADDON,
  FIND_CREATURE_TEMPLATE_ADDON,
  UPDATE_CREATURE_TEMPLATE_ADDON,
  CREATE_CREATURE_TEMPLATE_ADDON
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    creatureTemplateAddon: {}
  }),
  actions: {
    storeCreatureTemplateAddon(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(STORE_CREATURE_TEMPLATE_ADDON, payload);
        ipcRenderer.on(STORE_CREATURE_TEMPLATE_ADDON, () => {
          resolve();
        });
      });
    },
    findCreatureTemplateAddon({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(FIND_CREATURE_TEMPLATE_ADDON, payload);
        ipcRenderer.on(FIND_CREATURE_TEMPLATE_ADDON, (event, response) => {
          commit(FIND_CREATURE_TEMPLATE_ADDON, response);
          resolve();
        });
      });
    },
    updateCreatureTemplateAddon(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(UPDATE_CREATURE_TEMPLATE_ADDON, payload);
        ipcRenderer.on(UPDATE_CREATURE_TEMPLATE_ADDON, () => {
          resolve();
        });
      });
    },
    createCreatureTemplateAddon({ commit }, payload) {
      return new Promise(resolve => {
        commit(CREATE_CREATURE_TEMPLATE_ADDON, payload);
      });
    }
  },
  mutations: {
    [FIND_CREATURE_TEMPLATE_ADDON](state, creatureTemplateAddon) {
      state.creatureTemplateAddon = creatureTemplateAddon;
    },
    [CREATE_CREATURE_TEMPLATE_ADDON](state, creatureTemplateAddon) {
      state.creatureTemplateAddon = creatureTemplateAddon;
    }
  }
};
