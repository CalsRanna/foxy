const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR,
  COUNT_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR,
  PAGINATE_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    gameObjectDisplayInfos: [],
  }),
  actions: {
    searchGameObjectDisplayInfosForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(
          SEARCH_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR,
          payload
        );
        ipcRenderer.on(
          SEARCH_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR,
          (event, response) => {
            commit(SEARCH_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${SEARCH_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countGameObjectDisplayInfosForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR, payload);
        ipcRenderer.on(
          COUNT_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR,
          (event, response) => {
            commit(COUNT_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${COUNT_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateGameObjectDisplayInfosForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR](
      state,
      gameObjectDisplayInfos
    ) {
      state.gameObjectDisplayInfos = gameObjectDisplayInfos;
    },
    [COUNT_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_GAME_OBJECT_DISPLAY_INFOS_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
