const ipcRenderer = window.ipcRenderer;

import {
  STORE_ACHIEVEMENT_CATEGORY,
  FIND_ACHIEVEMENT_CATEGORY,
  UPDATE_ACHIEVEMENT_CATEGORY,
  CREATE_ACHIEVEMENT_CATEGORY,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    achievementCategory: {},
  }),
  actions: {
    storeAchievementCategory(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_ACHIEVEMENT_CATEGORY, payload);
        ipcRenderer.once(STORE_ACHIEVEMENT_CATEGORY, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_ACHIEVEMENT_CATEGORY}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findAchievementCategory({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_ACHIEVEMENT_CATEGORY, payload);
        ipcRenderer.once(FIND_ACHIEVEMENT_CATEGORY, (event, response) => {
          commit(FIND_ACHIEVEMENT_CATEGORY, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_ACHIEVEMENT_CATEGORY}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateAchievementCategory(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_ACHIEVEMENT_CATEGORY, payload);
        ipcRenderer.once(UPDATE_ACHIEVEMENT_CATEGORY, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_ACHIEVEMENT_CATEGORY}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createAchievementCategory({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_ACHIEVEMENT_CATEGORY, payload);
        resolve();
      });
    },
  },
  mutations: {
    [FIND_ACHIEVEMENT_CATEGORY](state, achievementCategory) {
      state.achievementCategory = achievementCategory;
    },
    [CREATE_ACHIEVEMENT_CATEGORY](state, achievementCategory) {
      state.achievementCategory = achievementCategory;
    },
  },
};
