const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR,
  COUNT_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR,
  PAGINATE_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    pagination: {
      total: 0,
      page: 1,
      size: 50,
    },
    scalingStatDistributions: [],
  }),
  actions: {
    searchScalingStatDistributionsForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(
          SEARCH_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR,
          payload
        );
        ipcRenderer.once(
          SEARCH_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR,
          (event, response) => {
            commit(SEARCH_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${SEARCH_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countScalingStatDistributionsForSelector({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(
          COUNT_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR,
          payload
        );
        ipcRenderer.once(
          COUNT_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR,
          (event, response) => {
            commit(COUNT_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${COUNT_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateScalingStatDistributionsForSelector({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR, payload.page);
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR](
      state,
      scalingStatDistributions
    ) {
      state.scalingStatDistributions = scalingStatDistributions;
    },
    [COUNT_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_SCALING_STAT_DISTRIBUTIONS_FOR_SELECTOR](state, page) {
      state.pagination.page = page;
    },
  },
};
