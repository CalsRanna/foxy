const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_PLAYER_CREATE_INFO_SPELL_CUSTOMS,
  STORE_PLAYER_CREATE_INFO_SPELL_CUSTOM,
  FIND_PLAYER_CREATE_INFO_SPELL_CUSTOM,
  UPDATE_PLAYER_CREATE_INFO_SPELL_CUSTOM,
  DESTROY_PLAYER_CREATE_INFO_SPELL_CUSTOM,
  CREATE_PLAYER_CREATE_INFO_SPELL_CUSTOM,
  COPY_PLAYER_CREATE_INFO_SPELL_CUSTOM,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    playerCreateInfoSpellCustoms: [],
    playerCreateInfoSpellCustom: {},
  }),
  actions: {
    searchPlayerCreateInfoSpellCustoms({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_PLAYER_CREATE_INFO_SPELL_CUSTOMS, payload);
        ipcRenderer.on(
          SEARCH_PLAYER_CREATE_INFO_SPELL_CUSTOMS,
          (event, response) => {
            commit(SEARCH_PLAYER_CREATE_INFO_SPELL_CUSTOMS, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${SEARCH_PLAYER_CREATE_INFO_SPELL_CUSTOMS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storePlayerCreateInfoSpellCustom(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_PLAYER_CREATE_INFO_SPELL_CUSTOM, payload);
        ipcRenderer.on(STORE_PLAYER_CREATE_INFO_SPELL_CUSTOM, () => {
          resolve();
        });
        ipcRenderer.on(
          `${STORE_PLAYER_CREATE_INFO_SPELL_CUSTOM}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findPlayerCreateInfoSpellCustom({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_PLAYER_CREATE_INFO_SPELL_CUSTOM, payload);
        ipcRenderer.on(
          FIND_PLAYER_CREATE_INFO_SPELL_CUSTOM,
          (event, response) => {
            commit(FIND_PLAYER_CREATE_INFO_SPELL_CUSTOM, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${FIND_PLAYER_CREATE_INFO_SPELL_CUSTOM}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updatePlayerCreateInfoSpellCustom(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_PLAYER_CREATE_INFO_SPELL_CUSTOM, payload);
        ipcRenderer.on(UPDATE_PLAYER_CREATE_INFO_SPELL_CUSTOM, () => {
          resolve();
        });
        ipcRenderer.on(
          `${UPDATE_PLAYER_CREATE_INFO_SPELL_CUSTOM}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyPlayerCreateInfoSpellCustom(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_PLAYER_CREATE_INFO_SPELL_CUSTOM, payload);
        ipcRenderer.on(DESTROY_PLAYER_CREATE_INFO_SPELL_CUSTOM, () => {
          resolve();
        });
        ipcRenderer.on(
          `${DESTROY_PLAYER_CREATE_INFO_SPELL_CUSTOM}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createPlayerCreateInfoSpellCustom({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_PLAYER_CREATE_INFO_SPELL_CUSTOM, payload);
        resolve();
      });
    },
    copyPlayerCreateInfoSpellCustom(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_PLAYER_CREATE_INFO_SPELL_CUSTOM, payload);
        ipcRenderer.on(COPY_PLAYER_CREATE_INFO_SPELL_CUSTOM, () => {
          resolve();
        });
        ipcRenderer.on(
          `${COPY_PLAYER_CREATE_INFO_SPELL_CUSTOM}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_PLAYER_CREATE_INFO_SPELL_CUSTOMS](
      state,
      playerCreateInfoSpellCustoms
    ) {
      state.playerCreateInfoSpellCustoms = playerCreateInfoSpellCustoms;
    },
    [FIND_PLAYER_CREATE_INFO_SPELL_CUSTOM](state, playerCreateInfoSpellCustom) {
      state.playerCreateInfoSpellCustom = playerCreateInfoSpellCustom;
    },
    [CREATE_PLAYER_CREATE_INFO_SPELL_CUSTOM](
      state,
      playerCreateInfoSpellCustom
    ) {
      state.playerCreateInfoSpellCustom = playerCreateInfoSpellCustom;
    },
  },
};
