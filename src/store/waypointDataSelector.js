const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_WAYPOINT_DATAS_FOR_SELECTOR,
  COUNT_WAYPOINT_DATAS_FOR_SELECTOR,
  PAGINATE_WAYPOINT_DATAS_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    waypointDatas: [],
  }),
  actions: {
    searchWaypointDatasForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_WAYPOINT_DATAS_FOR_SELECTOR, payload);
        ipcRenderer.on(
          SEARCH_WAYPOINT_DATAS_FOR_SELECTOR,
          (event, response) => {
            commit(SEARCH_WAYPOINT_DATAS_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${SEARCH_WAYPOINT_DATAS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countWaypointDatasForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_WAYPOINT_DATAS_FOR_SELECTOR, payload);
        ipcRenderer.on(COUNT_WAYPOINT_DATAS_FOR_SELECTOR, (event, response) => {
          commit(COUNT_WAYPOINT_DATAS_FOR_SELECTOR, response);
          resolve();
        });
        ipcRenderer.on(
          `${COUNT_WAYPOINT_DATAS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateWaypointDatasForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_WAYPOINT_DATAS_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_WAYPOINT_DATAS_FOR_SELECTOR](state, waypointDatas) {
      state.waypointDatas = waypointDatas;
    },
    [COUNT_WAYPOINT_DATAS_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_WAYPOINT_DATAS_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
