const ipcRenderer = window.require("electron").ipcRenderer;

import {
  STORE_QUEST_TEMPLATE_ADDON,
  FIND_QUEST_TEMPLATE_ADDON,
  UPDATE_QUEST_TEMPLATE_ADDON,
  CREATE_QUEST_TEMPLATE_ADDON,
} from "./../constants";

export default {
  namespaced: true,
  state() {
    return {
      questTemplateAddon: {},
    };
  },
  actions: {
    storeQuestTemplateAddon(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(STORE_QUEST_TEMPLATE_ADDON, payload);
        ipcRenderer.on(STORE_QUEST_TEMPLATE_ADDON, () => {
          resolve();
        });
      });
    },
    findQuestTemplateAddon({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(FIND_QUEST_TEMPLATE_ADDON, payload);
        ipcRenderer.on(FIND_QUEST_TEMPLATE_ADDON, (event, response) => {
          commit(FIND_QUEST_TEMPLATE_ADDON, response);
          resolve();
        });
      });
    },
    updateQuestTemplateAddon(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(UPDATE_QUEST_TEMPLATE_ADDON, payload);
        ipcRenderer.on(UPDATE_QUEST_TEMPLATE_ADDON, () => {
          resolve();
        });
      });
    },
    createQuestTemplateAddon({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_QUEST_TEMPLATE_ADDON, payload);
        resolve();
      });
    },
  },
  mutations: {
    [FIND_QUEST_TEMPLATE_ADDON](state, questTemplateAddon) {
      state.questTemplateAddon = questTemplateAddon;
    },
    [CREATE_QUEST_TEMPLATE_ADDON](state, questTemplateAddon) {
      state.questTemplateAddon = questTemplateAddon;
    },
  },
};
