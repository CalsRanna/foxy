const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_QUEST_TEMPLATE_LOCALES,
  STORE_QUEST_TEMPLATE_LOCALES,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    questTemplateLocales: [],
  }),
  actions: {
    searchQuestTemplateLocales({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_QUEST_TEMPLATE_LOCALES, payload);
        ipcRenderer.on(SEARCH_QUEST_TEMPLATE_LOCALES, (event, response) => {
          commit(SEARCH_QUEST_TEMPLATE_LOCALES, response);
          resolve();
        });
        ipcRenderer.on(
          `${SEARCH_QUEST_TEMPLATE_LOCALES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeQuestTemplateLocales(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_QUEST_TEMPLATE_LOCALES, payload);
        ipcRenderer.on(STORE_QUEST_TEMPLATE_LOCALES, () => {
          resolve();
        });
        ipcRenderer.on(
          `${STORE_QUEST_TEMPLATE_LOCALES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_QUEST_TEMPLATE_LOCALES](state, questTemplateLocales) {
      state.questTemplateLocales = questTemplateLocales;
    },
  },
};
