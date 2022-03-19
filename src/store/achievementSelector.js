const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_ACHIEVEMENTS_FOR_SELECTOR,
  COUNT_ACHIEVEMENTS_FOR_SELECTOR,
  PAGINATE_ACHIEVEMENTS_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    achievements: [],
  }),
  actions: {
    searchAchievementsForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_ACHIEVEMENTS_FOR_SELECTOR, payload);
        ipcRenderer.once(
          SEARCH_ACHIEVEMENTS_FOR_SELECTOR,
          (event, response) => {
            commit(SEARCH_ACHIEVEMENTS_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${SEARCH_ACHIEVEMENTS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countAchievementsForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_ACHIEVEMENTS_FOR_SELECTOR, payload);
        ipcRenderer.once(COUNT_ACHIEVEMENTS_FOR_SELECTOR, (event, response) => {
          commit(COUNT_ACHIEVEMENTS_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.once(
          `${COUNT_ACHIEVEMENTS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateAchievementsForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_ACHIEVEMENTS_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_ACHIEVEMENTS_FOR_SELECTOR](state, achievements) {
      state.achievements = achievements;
    },
    [COUNT_ACHIEVEMENTS_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_ACHIEVEMENTS_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
