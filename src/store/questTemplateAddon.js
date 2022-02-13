const ipcRenderer = window.ipcRenderer;

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
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_QUEST_TEMPLATE_ADDON, payload);
        ipcRenderer.once(STORE_QUEST_TEMPLATE_ADDON, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_QUEST_TEMPLATE_ADDON}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findQuestTemplateAddon({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_QUEST_TEMPLATE_ADDON, payload);
        ipcRenderer.once(FIND_QUEST_TEMPLATE_ADDON, (event, response) => {
          commit(FIND_QUEST_TEMPLATE_ADDON, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_QUEST_TEMPLATE_ADDON}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateQuestTemplateAddon(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_QUEST_TEMPLATE_ADDON, payload);
        ipcRenderer.once(UPDATE_QUEST_TEMPLATE_ADDON, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_QUEST_TEMPLATE_ADDON}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
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
