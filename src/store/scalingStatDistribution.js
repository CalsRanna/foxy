const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_SCALING_STAT_DISTRIBUTIONS,
  COUNT_SCALING_STAT_DISTRIBUTIONS,
  PAGINATE_SCALING_STAT_DISTRIBUTIONS,
  STORE_SCALING_STAT_DISTRIBUTION,
  FIND_SCALING_STAT_DISTRIBUTION,
  UPDATE_SCALING_STAT_DISTRIBUTION,
  DESTROY_SCALING_STAT_DISTRIBUTION,
  CREATE_SCALING_STAT_DISTRIBUTION,
  COPY_SCALING_STAT_DISTRIBUTION,
} from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      refresh: true,
      credential: {
        ID: undefined,
        Stat: undefined,
      },
      pagination: {
        page: 1,
        total: 0,
      },
      scalingStatDistributions: [],
      scalingStatDistribution: {},
    };
  },
  actions: {
    searchScalingStatDistributions({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_SCALING_STAT_DISTRIBUTIONS, payload);
        ipcRenderer.on(SEARCH_SCALING_STAT_DISTRIBUTIONS, (event, response) => {
          commit(SEARCH_SCALING_STAT_DISTRIBUTIONS, response);
          resolve();
        });
        ipcRenderer.on(
          `${SEARCH_SCALING_STAT_DISTRIBUTIONS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countScalingStatDistributions({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_SCALING_STAT_DISTRIBUTIONS, payload);
        ipcRenderer.on(COUNT_SCALING_STAT_DISTRIBUTIONS, (event, response) => {
          commit(COUNT_SCALING_STAT_DISTRIBUTIONS, response);
          resolve();
        });
        ipcRenderer.on(
          `${COUNT_SCALING_STAT_DISTRIBUTIONS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateScalingStatDistributions({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_SCALING_STAT_DISTRIBUTIONS, payload.page);
        resolve();
      });
    },
    storeScalingStatDistribution({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_SCALING_STAT_DISTRIBUTION, payload);
        ipcRenderer.on(STORE_SCALING_STAT_DISTRIBUTION, () => {
          commit("UPDATE_REFRESH_OF_SCALING_STAT_DISTRIBUTION", true);
          resolve();
        });
        ipcRenderer.on(
          `${STORE_SCALING_STAT_DISTRIBUTION}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findScalingStatDistribution({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_SCALING_STAT_DISTRIBUTION, payload);
        ipcRenderer.on(FIND_SCALING_STAT_DISTRIBUTION, (event, response) => {
          commit(FIND_SCALING_STAT_DISTRIBUTION, response);
          resolve();
        });
        ipcRenderer.on(
          `${FIND_SCALING_STAT_DISTRIBUTION}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateScalingStatDistribution({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_SCALING_STAT_DISTRIBUTION, payload);
        ipcRenderer.on(UPDATE_SCALING_STAT_DISTRIBUTION, () => {
          commit("UPDATE_REFRESH_OF_SCALING_STAT_DISTRIBUTION", true);
          resolve();
        });
        ipcRenderer.on(
          `${UPDATE_SCALING_STAT_DISTRIBUTION}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyScalingStatDistribution(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_SCALING_STAT_DISTRIBUTION, payload);
        ipcRenderer.on(DESTROY_SCALING_STAT_DISTRIBUTION, () => {
          resolve();
        });
        ipcRenderer.on(
          `${DESTROY_SCALING_STAT_DISTRIBUTION}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createScalingStatDistribution({ commit }) {
      return new Promise((resolve) => {
        commit(CREATE_SCALING_STAT_DISTRIBUTION, {
          Stat: "New - Smart Script",
        });
        resolve();
      });
    },
    copyScalingStatDistribution(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_SCALING_STAT_DISTRIBUTION, payload);
        ipcRenderer.on(COPY_SCALING_STAT_DISTRIBUTION, () => {
          resolve();
        });
        ipcRenderer.on(
          `${COPY_SCALING_STAT_DISTRIBUTION}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_SCALING_STAT_DISTRIBUTION");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_SCALING_STAT_DISTRIBUTIONS](state, scalingStatDistributions) {
      state.scalingStatDistributions = scalingStatDistributions;
      state.refresh = false;
    },
    [COUNT_SCALING_STAT_DISTRIBUTIONS](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_SCALING_STAT_DISTRIBUTIONS](state, page) {
      state.pagination.page = page;
    },
    [FIND_SCALING_STAT_DISTRIBUTION](state, scalingStatDistribution) {
      state.scalingStatDistribution = scalingStatDistribution;
    },
    [UPDATE_SCALING_STAT_DISTRIBUTION](state, scalingStatDistribution) {
      state.scalingStatDistribution = scalingStatDistribution;
    },
    [CREATE_SCALING_STAT_DISTRIBUTION](state, scalingStatDistribution) {
      state.scalingStatDistribution = scalingStatDistribution;
    },
    UPDATE_REFRESH_OF_SCALING_STAT_DISTRIBUTION(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_SCALING_STAT_DISTRIBUTION(state) {
      state.credential = {
        ID: undefined,
        Stat: undefined,
      };
    },
  },
};
