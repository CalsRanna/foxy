const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_ACHIEVEMENTS,
  COUNT_ACHIEVEMENTS,
  PAGINATE_ACHIEVEMENTS,
  STORE_ACHIEVEMENT,
  FIND_ACHIEVEMENT,
  UPDATE_ACHIEVEMENT,
  DESTROY_ACHIEVEMENT,
  CREATE_ACHIEVEMENT,
  COPY_ACHIEVEMENT,
} from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      refresh: true,
      credential: {
        ID: undefined,
        Name: undefined,
      },
      pagination: {
        page: 1,
        total: 0,
      },
      achievements: [],
      achievement: {},
    };
  },
  actions: {
    searchAchievements({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_ACHIEVEMENTS, payload);
        ipcRenderer.once(SEARCH_ACHIEVEMENTS, (event, response) => {
          commit(SEARCH_ACHIEVEMENTS, response);
          resolve();
        });
        ipcRenderer.once(`${SEARCH_ACHIEVEMENTS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    countAchievements({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_ACHIEVEMENTS, payload);
        ipcRenderer.once(COUNT_ACHIEVEMENTS, (event, response) => {
          commit(COUNT_ACHIEVEMENTS, response);
          resolve();
        });
        ipcRenderer.once(`${COUNT_ACHIEVEMENTS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    paginateAchievements({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_ACHIEVEMENTS, payload.page);
        resolve();
      });
    },
    storeAchievement({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_ACHIEVEMENT, payload);
        ipcRenderer.once(STORE_ACHIEVEMENT, () => {
          commit("UPDATE_REFRESH_OF_ACHIEVEMENT", true);
          resolve();
        });
        ipcRenderer.once(`${STORE_ACHIEVEMENT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findAchievement({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_ACHIEVEMENT, payload);
        ipcRenderer.once(FIND_ACHIEVEMENT, (event, response) => {
          commit(FIND_ACHIEVEMENT, response);
          resolve();
        });
        ipcRenderer.once(`${FIND_ACHIEVEMENT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateAchievement({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_ACHIEVEMENT, payload);
        ipcRenderer.once(UPDATE_ACHIEVEMENT, () => {
          commit("UPDATE_REFRESH_OF_ACHIEVEMENT", true);
          resolve();
        });
        ipcRenderer.once(`${UPDATE_ACHIEVEMENT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroyAchievement(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_ACHIEVEMENT, payload);
        ipcRenderer.once(DESTROY_ACHIEVEMENT, () => {
          resolve();
        });
        ipcRenderer.once(`${DESTROY_ACHIEVEMENT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createAchievement({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_ACHIEVEMENT, payload);
        ipcRenderer.once(CREATE_ACHIEVEMENT, (event, response) => {
          commit(CREATE_ACHIEVEMENT, response);
          resolve();
        });
        ipcRenderer.once(`${CREATE_ACHIEVEMENT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    copyAchievement(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_ACHIEVEMENT, payload);
        ipcRenderer.once(COPY_ACHIEVEMENT, () => {
          resolve();
        });
        ipcRenderer.once(`${COPY_ACHIEVEMENT}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_ACHIEVEMENT");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_ACHIEVEMENTS](state, achievements) {
      state.achievements = achievements;
      state.refresh = false;
    },
    [COUNT_ACHIEVEMENTS](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_ACHIEVEMENTS](state, page) {
      state.pagination.page = page;
    },
    [FIND_ACHIEVEMENT](state, achievement) {
      state.achievement = achievement;
    },
    [UPDATE_ACHIEVEMENT](state, achievement) {
      state.achievement = achievement;
    },
    [CREATE_ACHIEVEMENT](state, achievement) {
      state.achievement = achievement;
    },
    UPDATE_REFRESH_OF_ACHIEVEMENT(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_ACHIEVEMENT(state) {
      state.credential = {
        ID: undefined,
        Name: undefined,
      };
    },
  },
};
