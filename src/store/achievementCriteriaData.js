const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_ACHIEVEMENT_CRITERIA_DATAS,
  STORE_ACHIEVEMENT_CRITERIA_DATA,
  FIND_ACHIEVEMENT_CRITERIA_DATA,
  UPDATE_ACHIEVEMENT_CRITERIA_DATA,
  DESTROY_ACHIEVEMENT_CRITERIA_DATA,
  CREATE_ACHIEVEMENT_CRITERIA_DATA,
  COPY_ACHIEVEMENT_CRITERIA_DATA,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    achievementCriteriaDatas: [],
    achievementCriteriaData: {},
  }),
  actions: {
    searchAchievementCriteriaDatas({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_ACHIEVEMENT_CRITERIA_DATAS, payload);
        ipcRenderer.once(
          SEARCH_ACHIEVEMENT_CRITERIA_DATAS,
          (event, response) => {
            commit(SEARCH_ACHIEVEMENT_CRITERIA_DATAS, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${SEARCH_ACHIEVEMENT_CRITERIA_DATAS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeAchievementCriteriaData(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_ACHIEVEMENT_CRITERIA_DATA, payload);
        ipcRenderer.once(STORE_ACHIEVEMENT_CRITERIA_DATA, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_ACHIEVEMENT_CRITERIA_DATA}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findAchievementCriteriaData({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_ACHIEVEMENT_CRITERIA_DATA, payload);
        ipcRenderer.once(FIND_ACHIEVEMENT_CRITERIA_DATA, (event, response) => {
          commit(FIND_ACHIEVEMENT_CRITERIA_DATA, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_ACHIEVEMENT_CRITERIA_DATA}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateAchievementCriteriaData(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_ACHIEVEMENT_CRITERIA_DATA, payload);
        ipcRenderer.once(UPDATE_ACHIEVEMENT_CRITERIA_DATA, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_ACHIEVEMENT_CRITERIA_DATA}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyAchievementCriteriaData(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_ACHIEVEMENT_CRITERIA_DATA, payload);
        ipcRenderer.once(DESTROY_ACHIEVEMENT_CRITERIA_DATA, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_ACHIEVEMENT_CRITERIA_DATA}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createAchievementCriteriaData({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_ACHIEVEMENT_CRITERIA_DATA, payload);
        ipcRenderer.once(
          CREATE_ACHIEVEMENT_CRITERIA_DATA,
          (event, response) => {
            commit(CREATE_ACHIEVEMENT_CRITERIA_DATA, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${CREATE_ACHIEVEMENT_CRITERIA_DATA}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    copyAchievementCriteriaData(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_ACHIEVEMENT_CRITERIA_DATA, payload);
        ipcRenderer.once(COPY_ACHIEVEMENT_CRITERIA_DATA, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_ACHIEVEMENT_CRITERIA_DATA}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_ACHIEVEMENT_CRITERIA_DATAS](state, achievementCriteriaDatas) {
      state.achievementCriteriaDatas = achievementCriteriaDatas;
    },
    [FIND_ACHIEVEMENT_CRITERIA_DATA](state, achievementCriteriaData) {
      state.achievementCriteriaData = achievementCriteriaData;
    },
    [CREATE_ACHIEVEMENT_CRITERIA_DATA](state, achievementCriteriaData) {
      state.achievementCriteriaData = achievementCriteriaData;
    },
  },
};
