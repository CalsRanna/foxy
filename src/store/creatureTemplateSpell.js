const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_CREATURE_TEMPLATE_SPELLS,
  STORE_CREATURE_TEMPLATE_SPELL,
  FIND_CREATURE_TEMPLATE_SPELL,
  UPDATE_CREATURE_TEMPLATE_SPELL,
  DESTROY_CREATURE_TEMPLATE_SPELL,
  CREATE_CREATURE_TEMPLATE_SPELL,
  COPY_CREATURE_TEMPLATE_SPELL,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    creatureTemplateSpells: [],
    creatureTemplateSpell: {},
  }),
  actions: {
    searchCreatureTemplateSpells({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_CREATURE_TEMPLATE_SPELLS, payload);
        ipcRenderer.once(SEARCH_CREATURE_TEMPLATE_SPELLS, (event, response) => {
          commit(SEARCH_CREATURE_TEMPLATE_SPELLS, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_CREATURE_TEMPLATE_SPELLS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeCreatureTemplateSpell(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_CREATURE_TEMPLATE_SPELL, payload);
        ipcRenderer.once(STORE_CREATURE_TEMPLATE_SPELL, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_CREATURE_TEMPLATE_SPELL}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findCreatureTemplateSpell({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_CREATURE_TEMPLATE_SPELL, payload);
        ipcRenderer.once(FIND_CREATURE_TEMPLATE_SPELL, (event, response) => {
          commit(FIND_CREATURE_TEMPLATE_SPELL, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_CREATURE_TEMPLATE_SPELL}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateCreatureTemplateSpell(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_CREATURE_TEMPLATE_SPELL, payload);
        ipcRenderer.once(UPDATE_CREATURE_TEMPLATE_SPELL, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_CREATURE_TEMPLATE_SPELL}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyCreatureTemplateSpell(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_CREATURE_TEMPLATE_SPELL, payload);
        ipcRenderer.once(DESTROY_CREATURE_TEMPLATE_SPELL, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_CREATURE_TEMPLATE_SPELL}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createCreatureTemplateSpell({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_CREATURE_TEMPLATE_SPELL, payload);
        ipcRenderer.once(CREATE_CREATURE_TEMPLATE_SPELL, (event, response) => {
          commit(CREATE_CREATURE_TEMPLATE_SPELL, response);
          resolve();
        });
        ipcRenderer.once(
          `${CREATE_CREATURE_TEMPLATE_SPELL}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    copyCreatureTemplateSpell(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_CREATURE_TEMPLATE_SPELL, payload);
        ipcRenderer.once(COPY_CREATURE_TEMPLATE_SPELL, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_CREATURE_TEMPLATE_SPELL}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_CREATURE_TEMPLATE_SPELLS](state, creatureTemplateSpells) {
      state.creatureTemplateSpells = creatureTemplateSpells;
    },
    [FIND_CREATURE_TEMPLATE_SPELL](state, creatureTemplateSpell) {
      state.creatureTemplateSpell = creatureTemplateSpell;
    },
    [CREATE_CREATURE_TEMPLATE_SPELL](state, creatureTemplateSpell) {
      state.creatureTemplateSpell = creatureTemplateSpell;
    },
  },
};
