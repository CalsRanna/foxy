const ipcRenderer = window.ipcRenderer;

import {
  STORE_ACHIEVEMENT_CRITERIA,
  FIND_ACHIEVEMENT_CRITERIA,
  UPDATE_ACHIEVEMENT_CRITERIA,
  CREATE_ACHIEVEMENT_CRITERIA,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    achievementCriteria: {},
  }),
  actions: {
    storeAchievementCriteria(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_ACHIEVEMENT_CRITERIA, payload);
        ipcRenderer.on(STORE_ACHIEVEMENT_CRITERIA, () => {
          resolve();
        });
        ipcRenderer.on(
          `${STORE_ACHIEVEMENT_CRITERIA}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findAchievementCriteria({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_ACHIEVEMENT_CRITERIA, payload);
        ipcRenderer.on(FIND_ACHIEVEMENT_CRITERIA, (event, response) => {
          commit(FIND_ACHIEVEMENT_CRITERIA, response);
          resolve();
        });
        ipcRenderer.on(
          `${FIND_ACHIEVEMENT_CRITERIA}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateAchievementCriteria(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_ACHIEVEMENT_CRITERIA, payload);
        ipcRenderer.on(UPDATE_ACHIEVEMENT_CRITERIA, () => {
          resolve();
        });
        ipcRenderer.on(
          `${UPDATE_ACHIEVEMENT_CRITERIA}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createAchievementCriteria({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_ACHIEVEMENT_CRITERIA, payload);
        resolve();
      });
    },
  },
  mutations: {
    [FIND_ACHIEVEMENT_CRITERIA](state, achievementCriteria) {
      state.achievementCriteria = achievementCriteria;
    },
    [CREATE_ACHIEVEMENT_CRITERIA](state, achievementCriteria) {
      state.achievementCriteria = achievementCriteria;
    },
  },
};
