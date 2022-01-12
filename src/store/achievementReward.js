const ipcRenderer = window.ipcRenderer;

import {
  STORE_ACHIEVEMENT_REWARD,
  FIND_ACHIEVEMENT_REWARD,
  UPDATE_ACHIEVEMENT_REWARD,
  CREATE_ACHIEVEMENT_REWARD,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    achievementReward: {},
  }),
  actions: {
    storeAchievementReward(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_ACHIEVEMENT_REWARD, payload);
        ipcRenderer.on(STORE_ACHIEVEMENT_REWARD, () => {
          resolve();
        });
        ipcRenderer.on(`${STORE_ACHIEVEMENT_REWARD}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findAchievementReward({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_ACHIEVEMENT_REWARD, payload);
        ipcRenderer.on(FIND_ACHIEVEMENT_REWARD, (event, response) => {
          commit(FIND_ACHIEVEMENT_REWARD, response);
          resolve();
        });
        ipcRenderer.on(`${FIND_ACHIEVEMENT_REWARD}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateAchievementReward(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_ACHIEVEMENT_REWARD, payload);
        ipcRenderer.on(UPDATE_ACHIEVEMENT_REWARD, () => {
          resolve();
        });
        ipcRenderer.on(
          `${UPDATE_ACHIEVEMENT_REWARD}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createAchievementReward({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_ACHIEVEMENT_REWARD, payload);
        resolve();
      });
    },
  },
  mutations: {
    [FIND_ACHIEVEMENT_REWARD](state, achievementReward) {
      state.achievementReward = achievementReward;
    },
    [CREATE_ACHIEVEMENT_REWARD](state, achievementReward) {
      state.achievementReward = achievementReward;
    },
  },
};
