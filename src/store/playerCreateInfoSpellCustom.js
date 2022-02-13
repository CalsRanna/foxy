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
        ipcRenderer.once(
          SEARCH_PLAYER_CREATE_INFO_SPELL_CUSTOMS,
          (event, response) => {
            commit(SEARCH_PLAYER_CREATE_INFO_SPELL_CUSTOMS, response);
            resolve();
          }
        );
        ipcRenderer.once(
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
        ipcRenderer.once(STORE_PLAYER_CREATE_INFO_SPELL_CUSTOM, () => {
          resolve();
        });
        ipcRenderer.once(
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
        ipcRenderer.once(
          FIND_PLAYER_CREATE_INFO_SPELL_CUSTOM,
          (event, response) => {
            commit(FIND_PLAYER_CREATE_INFO_SPELL_CUSTOM, response);
            resolve();
          }
        );
        ipcRenderer.once(
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
        ipcRenderer.once(UPDATE_PLAYER_CREATE_INFO_SPELL_CUSTOM, () => {
          resolve();
        });
        ipcRenderer.once(
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
        ipcRenderer.once(DESTROY_PLAYER_CREATE_INFO_SPELL_CUSTOM, () => {
          resolve();
        });
        ipcRenderer.once(
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
        ipcRenderer.once(COPY_PLAYER_CREATE_INFO_SPELL_CUSTOM, () => {
          resolve();
        });
        ipcRenderer.once(
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
