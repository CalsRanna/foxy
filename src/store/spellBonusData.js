const ipcRenderer = window.require("electron").ipcRenderer;

import {
  STORE_SPELL_BONUS_DATA,
  FIND_SPELL_BONUS_DATA,
  UPDATE_SPELL_BONUS_DATA,
  CREATE_SPELL_BONUS_DATA,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    spellBonusData: {},
  }),
  actions: {
    storeSpellBonusData(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_SPELL_BONUS_DATA, payload);
        ipcRenderer.on(STORE_SPELL_BONUS_DATA, () => {
          resolve();
        });
        ipcRenderer.on(`${STORE_SPELL_BONUS_DATA}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findSpellBonusData({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_SPELL_BONUS_DATA, payload);
        ipcRenderer.on(FIND_SPELL_BONUS_DATA, (event, response) => {
          commit(FIND_SPELL_BONUS_DATA, response);
          resolve();
        });
        ipcRenderer.on(`${FIND_SPELL_BONUS_DATA}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateSpellBonusData(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_SPELL_BONUS_DATA, payload);
        ipcRenderer.on(UPDATE_SPELL_BONUS_DATA, () => {
          resolve();
        });
        ipcRenderer.on(`${UPDATE_SPELL_BONUS_DATA}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createSpellBonusData({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_SPELL_BONUS_DATA, payload);
        resolve();
      });
    },
  },
  mutations: {
    [FIND_SPELL_BONUS_DATA](state, spellBonusData) {
      state.spellBonusData = spellBonusData;
    },
    [CREATE_SPELL_BONUS_DATA](state, spellBonusData) {
      state.spellBonusData = spellBonusData;
    },
  },
};
