const ipcRenderer = window.ipcRenderer;

import {
  STORE_CREATURE_TEMPLATE_ADDON,
  FIND_CREATURE_TEMPLATE_ADDON,
  UPDATE_CREATURE_TEMPLATE_ADDON,
  CREATE_CREATURE_TEMPLATE_ADDON,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    creatureTemplateAddon: {},
  }),
  actions: {
    storeCreatureTemplateAddon(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_CREATURE_TEMPLATE_ADDON, payload);
        ipcRenderer.once(STORE_CREATURE_TEMPLATE_ADDON, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_CREATURE_TEMPLATE_ADDON}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findCreatureTemplateAddon({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_CREATURE_TEMPLATE_ADDON, payload);
        ipcRenderer.once(FIND_CREATURE_TEMPLATE_ADDON, (event, response) => {
          commit(FIND_CREATURE_TEMPLATE_ADDON, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_CREATURE_TEMPLATE_ADDON}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateCreatureTemplateAddon(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_CREATURE_TEMPLATE_ADDON, payload);
        ipcRenderer.once(UPDATE_CREATURE_TEMPLATE_ADDON, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_CREATURE_TEMPLATE_ADDON}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createCreatureTemplateAddon({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_CREATURE_TEMPLATE_ADDON, payload);
        resolve();
      });
    },
  },
  mutations: {
    [FIND_CREATURE_TEMPLATE_ADDON](state, creatureTemplateAddon) {
      state.creatureTemplateAddon = creatureTemplateAddon;
    },
    [CREATE_CREATURE_TEMPLATE_ADDON](state, creatureTemplateAddon) {
      state.creatureTemplateAddon = creatureTemplateAddon;
    },
  },
};
