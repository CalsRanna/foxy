const ipcRenderer = window.ipcRenderer;

import {
  STORE_QUEST_REQUEST_ITEMS,
  FIND_QUEST_REQUEST_ITEMS,
  UPDATE_QUEST_REQUEST_ITEMS,
  CREATE_QUEST_REQUEST_ITEMS,
} from "./../constants";

export default {
  namespaced: true,
  state() {
    return {
      questRequestItems: {},
    };
  },
  actions: {
    storeQuestRequestItems(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_QUEST_REQUEST_ITEMS, payload);
        ipcRenderer.once(STORE_QUEST_REQUEST_ITEMS, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_QUEST_REQUEST_ITEMS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findQuestRequestItems({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_QUEST_REQUEST_ITEMS, payload);
        ipcRenderer.once(FIND_QUEST_REQUEST_ITEMS, (event, response) => {
          commit(FIND_QUEST_REQUEST_ITEMS, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_QUEST_REQUEST_ITEMS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateQuestRequestItems(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_QUEST_REQUEST_ITEMS, payload);
        ipcRenderer.once(UPDATE_QUEST_REQUEST_ITEMS, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_QUEST_REQUEST_ITEMS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createQuestRequestItems({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_QUEST_REQUEST_ITEMS, payload);
        resolve();
      });
    },
  },
  mutations: {
    [FIND_QUEST_REQUEST_ITEMS](state, questRequestItems) {
      state.questRequestItems = questRequestItems;
    },
    [CREATE_QUEST_REQUEST_ITEMS](state, questRequestItems) {
      state.questRequestItems = questRequestItems;
    },
  },
};
