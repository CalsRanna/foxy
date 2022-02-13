const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_PLAYER_CREATE_INFOS,
  COUNT_PLAYER_CREATE_INFOS,
  PAGINATE_PLAYER_CREATE_INFOS,
  STORE_PLAYER_CREATE_INFO,
  FIND_PLAYER_CREATE_INFO,
  UPDATE_PLAYER_CREATE_INFO,
  DESTROY_PLAYER_CREATE_INFO,
  CREATE_PLAYER_CREATE_INFO,
  COPY_PLAYER_CREATE_INFO,
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
      playerCreateInfos: [],
      playerCreateInfo: {},
    };
  },
  actions: {
    searchPlayerCreateInfos({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_PLAYER_CREATE_INFOS, payload);
        ipcRenderer.once(SEARCH_PLAYER_CREATE_INFOS, (event, response) => {
          commit(SEARCH_PLAYER_CREATE_INFOS, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_PLAYER_CREATE_INFOS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countPlayerCreateInfos({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_PLAYER_CREATE_INFOS, payload);
        ipcRenderer.once(COUNT_PLAYER_CREATE_INFOS, (event, response) => {
          commit(COUNT_PLAYER_CREATE_INFOS, response);
          resolve();
        });
        ipcRenderer.once(
          `${COUNT_PLAYER_CREATE_INFOS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginatePlayerCreateInfos({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_PLAYER_CREATE_INFOS, payload.page);
        resolve();
      });
    },
    storePlayerCreateInfo({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_PLAYER_CREATE_INFO, payload);
        ipcRenderer.once(STORE_PLAYER_CREATE_INFO, () => {
          commit("UPDATE_REFRESH_OF_PLAYER_CREATE_INFO", true);
          resolve();
        });
        ipcRenderer.once(
          `${STORE_PLAYER_CREATE_INFO}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findPlayerCreateInfo({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_PLAYER_CREATE_INFO, payload);
        ipcRenderer.once(FIND_PLAYER_CREATE_INFO, (event, response) => {
          commit(FIND_PLAYER_CREATE_INFO, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_PLAYER_CREATE_INFO}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updatePlayerCreateInfo({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_PLAYER_CREATE_INFO, payload);
        ipcRenderer.once(UPDATE_PLAYER_CREATE_INFO, () => {
          commit("UPDATE_REFRESH_OF_PLAYER_CREATE_INFO", true);
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_PLAYER_CREATE_INFO}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyPlayerCreateInfo(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_PLAYER_CREATE_INFO, payload);
        ipcRenderer.once(DESTROY_PLAYER_CREATE_INFO, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_PLAYER_CREATE_INFO}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createPlayerCreateInfo({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_PLAYER_CREATE_INFO, {});
        resolve();
      });
    },
    copyPlayerCreateInfo(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_PLAYER_CREATE_INFO, payload);
        ipcRenderer.once(COPY_PLAYER_CREATE_INFO, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_PLAYER_CREATE_INFO}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_PLAYER_CREATE_INFO");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_PLAYER_CREATE_INFOS](state, playerCreateInfos) {
      state.playerCreateInfos = playerCreateInfos;
      state.refresh = false;
    },
    [COUNT_PLAYER_CREATE_INFOS](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_PLAYER_CREATE_INFOS](state, page) {
      state.pagination.page = page;
    },
    [FIND_PLAYER_CREATE_INFO](state, playerCreateInfo) {
      state.playerCreateInfo = playerCreateInfo;
    },
    [UPDATE_PLAYER_CREATE_INFO](state, playerCreateInfo) {
      state.playerCreateInfo = playerCreateInfo;
    },
    [CREATE_PLAYER_CREATE_INFO](state, playerCreateInfo) {
      state.playerCreateInfo = playerCreateInfo;
    },
    UPDATE_REFRESH_OF_PLAYER_CREATE_INFO(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_PLAYER_CREATE_INFO(state) {
      state.credential = {
        ID: undefined,
        Name: undefined,
      };
    },
  },
};
