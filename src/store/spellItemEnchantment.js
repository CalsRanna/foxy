const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_SPELL_ITEM_ENCHANTMENTS,
  COUNT_SPELL_ITEM_ENCHANTMENTS,
  PAGINATE_SPELL_ITEM_ENCHANTMENTS,
  STORE_SPELL_ITEM_ENCHANTMENT,
  FIND_SPELL_ITEM_ENCHANTMENT,
  UPDATE_SPELL_ITEM_ENCHANTMENT,
  DESTROY_SPELL_ITEM_ENCHANTMENT,
  CREATE_SPELL_ITEM_ENCHANTMENT,
  COPY_SPELL_ITEM_ENCHANTMENT,
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
      spellItemEnchantments: [],
      spellItemEnchantment: {},
    };
  },
  actions: {
    searchSpellItemEnchantments({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_SPELL_ITEM_ENCHANTMENTS, payload);
        ipcRenderer.once(SEARCH_SPELL_ITEM_ENCHANTMENTS, (event, response) => {
          commit(SEARCH_SPELL_ITEM_ENCHANTMENTS, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_SPELL_ITEM_ENCHANTMENTS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countSpellItemEnchantments({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_SPELL_ITEM_ENCHANTMENTS, payload);
        ipcRenderer.once(COUNT_SPELL_ITEM_ENCHANTMENTS, (event, response) => {
          commit(COUNT_SPELL_ITEM_ENCHANTMENTS, response);
          resolve();
        });
        ipcRenderer.once(
          `${COUNT_SPELL_ITEM_ENCHANTMENTS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateSpellItemEnchantments({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_SPELL_ITEM_ENCHANTMENTS, payload.page);
        resolve();
      });
    },
    storeSpellItemEnchantment({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_SPELL_ITEM_ENCHANTMENT, payload);
        ipcRenderer.once(STORE_SPELL_ITEM_ENCHANTMENT, () => {
          commit("UPDATE_REFRESH_OF_SPELL_ITEM_ENCHANTMENT", true);
          resolve();
        });
        ipcRenderer.once(
          `${STORE_SPELL_ITEM_ENCHANTMENT}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findSpellItemEnchantment({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_SPELL_ITEM_ENCHANTMENT, payload);
        ipcRenderer.once(FIND_SPELL_ITEM_ENCHANTMENT, (event, response) => {
          commit(FIND_SPELL_ITEM_ENCHANTMENT, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_SPELL_ITEM_ENCHANTMENT}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateSpellItemEnchantment({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_SPELL_ITEM_ENCHANTMENT, payload);
        ipcRenderer.once(UPDATE_SPELL_ITEM_ENCHANTMENT, () => {
          commit("UPDATE_REFRESH_OF_SPELL_ITEM_ENCHANTMENT", true);
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_SPELL_ITEM_ENCHANTMENT}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroySpellItemEnchantment(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_SPELL_ITEM_ENCHANTMENT, payload);
        ipcRenderer.once(DESTROY_SPELL_ITEM_ENCHANTMENT, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_SPELL_ITEM_ENCHANTMENT}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createSpellItemEnchantment({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_SPELL_ITEM_ENCHANTMENT, payload);
        ipcRenderer.once(CREATE_SPELL_ITEM_ENCHANTMENT, (event, response) => {
          commit(CREATE_SPELL_ITEM_ENCHANTMENT, response);
          resolve();
        });
        ipcRenderer.once(
          `${CREATE_SPELL_ITEM_ENCHANTMENT}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    copySpellItemEnchantment(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_SPELL_ITEM_ENCHANTMENT, payload);
        ipcRenderer.once(COPY_SPELL_ITEM_ENCHANTMENT, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_SPELL_ITEM_ENCHANTMENT}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_SPELL_ITEM_ENCHANTMENT");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_SPELL_ITEM_ENCHANTMENTS](state, spellItemEnchantments) {
      state.spellItemEnchantments = spellItemEnchantments;
      state.refresh = false;
    },
    [COUNT_SPELL_ITEM_ENCHANTMENTS](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_SPELL_ITEM_ENCHANTMENTS](state, page) {
      state.pagination.page = page;
    },
    [FIND_SPELL_ITEM_ENCHANTMENT](state, spellItemEnchantment) {
      state.spellItemEnchantment = spellItemEnchantment;
    },
    [UPDATE_SPELL_ITEM_ENCHANTMENT](state, spellItemEnchantment) {
      state.spellItemEnchantment = spellItemEnchantment;
    },
    [CREATE_SPELL_ITEM_ENCHANTMENT](state, spellItemEnchantment) {
      state.spellItemEnchantment = spellItemEnchantment;
    },
    UPDATE_REFRESH_OF_SPELL_ITEM_ENCHANTMENT(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_SPELL_ITEM_ENCHANTMENT(state) {
      state.credential = {
        ID: undefined,
        Name: undefined,
      };
    },
  },
};
