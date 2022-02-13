const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_ITEM_EXTENDED_COSTS,
  COUNT_ITEM_EXTENDED_COSTS,
  PAGINATE_ITEM_EXTENDED_COSTS,
  STORE_ITEM_EXTENDED_COST,
  FIND_ITEM_EXTENDED_COST,
  UPDATE_ITEM_EXTENDED_COST,
  DESTROY_ITEM_EXTENDED_COST,
  CREATE_ITEM_EXTENDED_COST,
  COPY_ITEM_EXTENDED_COST,
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
      itemExtendedCosts: [],
      itemExtendedCost: {},
    };
  },
  actions: {
    searchItemExtendedCosts({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_ITEM_EXTENDED_COSTS, payload);
        ipcRenderer.once(SEARCH_ITEM_EXTENDED_COSTS, (event, response) => {
          commit(SEARCH_ITEM_EXTENDED_COSTS, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_ITEM_EXTENDED_COSTS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countItemExtendedCosts({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_ITEM_EXTENDED_COSTS, payload);
        ipcRenderer.once(COUNT_ITEM_EXTENDED_COSTS, (event, response) => {
          commit(COUNT_ITEM_EXTENDED_COSTS, response);
          resolve();
        });
        ipcRenderer.once(
          `${COUNT_ITEM_EXTENDED_COSTS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateItemExtendedCosts({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_ITEM_EXTENDED_COSTS, payload.page);
        resolve();
      });
    },
    storeItemExtendedCost({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_ITEM_EXTENDED_COST, payload);
        ipcRenderer.once(STORE_ITEM_EXTENDED_COST, () => {
          commit("UPDATE_REFRESH_OF_ITEM_EXTENDED_COST", true);
          resolve();
        });
        ipcRenderer.once(
          `${STORE_ITEM_EXTENDED_COST}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findItemExtendedCost({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_ITEM_EXTENDED_COST, payload);
        ipcRenderer.once(FIND_ITEM_EXTENDED_COST, (event, response) => {
          commit(FIND_ITEM_EXTENDED_COST, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_ITEM_EXTENDED_COST}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateItemExtendedCost({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_ITEM_EXTENDED_COST, payload);
        ipcRenderer.once(UPDATE_ITEM_EXTENDED_COST, () => {
          commit("UPDATE_REFRESH_OF_ITEM_EXTENDED_COST", true);
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_ITEM_EXTENDED_COST}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyItemExtendedCost(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_ITEM_EXTENDED_COST, payload);
        ipcRenderer.once(DESTROY_ITEM_EXTENDED_COST, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_ITEM_EXTENDED_COST}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createItemExtendedCost({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_ITEM_EXTENDED_COST, payload);
        ipcRenderer.once(CREATE_ITEM_EXTENDED_COST, (event, response) => {
          commit(CREATE_ITEM_EXTENDED_COST, response);
          resolve();
        });
        ipcRenderer.once(
          `${CREATE_ITEM_EXTENDED_COST}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    copyItemExtendedCost(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_ITEM_EXTENDED_COST, payload);
        ipcRenderer.once(COPY_ITEM_EXTENDED_COST, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_ITEM_EXTENDED_COST}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_ITEM_EXTENDED_COST");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_ITEM_EXTENDED_COSTS](state, itemExtendedCosts) {
      state.itemExtendedCosts = itemExtendedCosts;
      state.refresh = false;
    },
    [COUNT_ITEM_EXTENDED_COSTS](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_ITEM_EXTENDED_COSTS](state, page) {
      state.pagination.page = page;
    },
    [FIND_ITEM_EXTENDED_COST](state, itemExtendedCost) {
      state.itemExtendedCost = itemExtendedCost;
    },
    [UPDATE_ITEM_EXTENDED_COST](state, itemExtendedCost) {
      state.itemExtendedCost = itemExtendedCost;
    },
    [CREATE_ITEM_EXTENDED_COST](state, itemExtendedCost) {
      state.itemExtendedCost = itemExtendedCost;
    },
    UPDATE_REFRESH_OF_ITEM_EXTENDED_COST(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_ITEM_EXTENDED_COST(state) {
      state.credential = {
        ID: undefined,
        Name: undefined,
      };
    },
  },
};
