const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_SCALING_STAT_VALUES,
  COUNT_SCALING_STAT_VALUES,
  PAGINATE_SCALING_STAT_VALUES,
  STORE_SCALING_STAT_VALUE,
  FIND_SCALING_STAT_VALUE,
  UPDATE_SCALING_STAT_VALUE,
  DESTROY_SCALING_STAT_VALUE,
  CREATE_SCALING_STAT_VALUE,
  COPY_SCALING_STAT_VALUE,
} from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      refresh: true,
      credential: {
        ID: undefined,
        Charlevel: undefined,
      },
      pagination: {
        page: 1,
        total: 0,
      },
      scalingStatValues: [],
      scalingStatValue: {},
    };
  },
  actions: {
    searchScalingStatValues({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_SCALING_STAT_VALUES, payload);
        ipcRenderer.once(SEARCH_SCALING_STAT_VALUES, (event, response) => {
          commit(SEARCH_SCALING_STAT_VALUES, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_SCALING_STAT_VALUES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countScalingStatValues({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_SCALING_STAT_VALUES, payload);
        ipcRenderer.once(COUNT_SCALING_STAT_VALUES, (event, response) => {
          commit(COUNT_SCALING_STAT_VALUES, response);
          resolve();
        });
        ipcRenderer.once(
          `${COUNT_SCALING_STAT_VALUES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateScalingStatValues({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_SCALING_STAT_VALUES, payload.page);
        resolve();
      });
    },
    storeScalingStatValue({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_SCALING_STAT_VALUE, payload);
        ipcRenderer.once(STORE_SCALING_STAT_VALUE, () => {
          commit("UPDATE_REFRESH_OF_SCALING_STAT_VALUE", true);
          resolve();
        });
        ipcRenderer.once(
          `${STORE_SCALING_STAT_VALUE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findScalingStatValue({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_SCALING_STAT_VALUE, payload);
        ipcRenderer.once(FIND_SCALING_STAT_VALUE, (event, response) => {
          commit(FIND_SCALING_STAT_VALUE, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_SCALING_STAT_VALUE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateScalingStatValue({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_SCALING_STAT_VALUE, payload);
        ipcRenderer.once(UPDATE_SCALING_STAT_VALUE, () => {
          commit("UPDATE_REFRESH_OF_SCALING_STAT_VALUE", true);
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_SCALING_STAT_VALUE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyScalingStatValue(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_SCALING_STAT_VALUE, payload);
        ipcRenderer.once(DESTROY_SCALING_STAT_VALUE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_SCALING_STAT_VALUE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createScalingStatValue({ commit }) {
      return new Promise((resolve) => {
        commit(CREATE_SCALING_STAT_VALUE, {});
        resolve();
      });
    },
    copyScalingStatValue(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_SCALING_STAT_VALUE, payload);
        ipcRenderer.once(COPY_SCALING_STAT_VALUE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_SCALING_STAT_VALUE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_SCALING_STAT_VALUE");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_SCALING_STAT_VALUES](state, scalingStatValues) {
      state.scalingStatValues = scalingStatValues;
      state.refresh = false;
    },
    [COUNT_SCALING_STAT_VALUES](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_SCALING_STAT_VALUES](state, page) {
      state.pagination.page = page;
    },
    [FIND_SCALING_STAT_VALUE](state, scalingStatValue) {
      state.scalingStatValue = scalingStatValue;
    },
    [UPDATE_SCALING_STAT_VALUE](state, scalingStatValue) {
      state.scalingStatValue = scalingStatValue;
    },
    [CREATE_SCALING_STAT_VALUE](state, scalingStatValue) {
      state.scalingStatValue = scalingStatValue;
    },
    UPDATE_REFRESH_OF_SCALING_STAT_VALUE(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_SCALING_STAT_VALUE(state) {
      state.credential = {
        ID: undefined,
        Stat: undefined,
      };
    },
  },
};
