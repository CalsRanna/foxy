const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_ACHIEVEMENT_REWARD_LOCALES,
  STORE_ACHIEVEMENT_REWARD_LOCALES,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    achievementRewardLocales: [],
  }),
  actions: {
    searchAchievementRewardLocales({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_ACHIEVEMENT_REWARD_LOCALES, payload);
        ipcRenderer.once(
          SEARCH_ACHIEVEMENT_REWARD_LOCALES,
          (event, response) => {
            commit(SEARCH_ACHIEVEMENT_REWARD_LOCALES, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${SEARCH_ACHIEVEMENT_REWARD_LOCALES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeAchievementRewardLocales(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_ACHIEVEMENT_REWARD_LOCALES, payload);
        ipcRenderer.once(STORE_ACHIEVEMENT_REWARD_LOCALES, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_ACHIEVEMENT_REWARD_LOCALES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_ACHIEVEMENT_REWARD_LOCALES](state, achievementRewardLocales) {
      state.achievementRewardLocales = achievementRewardLocales;
    },
  },
};
