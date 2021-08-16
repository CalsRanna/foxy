const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR,
  COUNT_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR,
  PAGINATE_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    achievementCategories: [],
  }),
  actions: {
    searchAchievementCategoriesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR, payload);
        ipcRenderer.on(
          SEARCH_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR,
          (event, response) => {
            commit(SEARCH_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${SEARCH_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countAchievementCategoriesForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR, payload);
        ipcRenderer.on(
          COUNT_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR,
          (event, response) => {
            commit(COUNT_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${COUNT_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateAchievementCategoriesForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR](state, achievementCategories) {
      state.achievementCategories = achievementCategories;
    },
    [COUNT_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_ACHIEVEMENT_CATEGORIES_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
