const ipcRenderer = window.ipcRenderer;

import {
  STORE_SPELL_CUSTOM_ATTR,
  FIND_SPELL_CUSTOM_ATTR,
  UPDATE_SPELL_CUSTOM_ATTR,
  CREATE_SPELL_CUSTOM_ATTR,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    spellCustomAttr: {},
  }),
  actions: {
    storeSpellCustomAttr(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_SPELL_CUSTOM_ATTR, payload);
        ipcRenderer.once(STORE_SPELL_CUSTOM_ATTR, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_SPELL_CUSTOM_ATTR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findSpellCustomAttr({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_SPELL_CUSTOM_ATTR, payload);
        ipcRenderer.once(FIND_SPELL_CUSTOM_ATTR, (event, response) => {
          commit(FIND_SPELL_CUSTOM_ATTR, response);
          resolve();
        });
        ipcRenderer.once(`${FIND_SPELL_CUSTOM_ATTR}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateSpellCustomAttr(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_SPELL_CUSTOM_ATTR, payload);
        ipcRenderer.once(UPDATE_SPELL_CUSTOM_ATTR, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_SPELL_CUSTOM_ATTR}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createSpellCustomAttr({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_SPELL_CUSTOM_ATTR, payload);
        resolve();
      });
    },
  },
  mutations: {
    [FIND_SPELL_CUSTOM_ATTR](state, spellCustomAttr) {
      state.spellCustomAttr = spellCustomAttr;
    },
    [CREATE_SPELL_CUSTOM_ATTR](state, spellCustomAttr) {
      state.spellCustomAttr = spellCustomAttr;
    },
  },
};
