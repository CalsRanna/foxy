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
        ipcRenderer.on(SEARCH_CREATURE_TEMPLATE_SPELLS, (event, response) => {
          commit(SEARCH_CREATURE_TEMPLATE_SPELLS, response);
          resolve();
        });
        ipcRenderer.on(
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
        ipcRenderer.on(STORE_CREATURE_TEMPLATE_SPELL, () => {
          resolve();
        });
        ipcRenderer.on(
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
        ipcRenderer.on(FIND_CREATURE_TEMPLATE_SPELL, (event, response) => {
          commit(FIND_CREATURE_TEMPLATE_SPELL, response);
          resolve();
        });
        ipcRenderer.on(
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
        ipcRenderer.on(UPDATE_CREATURE_TEMPLATE_SPELL, () => {
          resolve();
        });
        ipcRenderer.on(
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
        ipcRenderer.on(DESTROY_CREATURE_TEMPLATE_SPELL, () => {
          resolve();
        });
        ipcRenderer.on(
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
        ipcRenderer.on(CREATE_CREATURE_TEMPLATE_SPELL, (event, response) => {
          commit(CREATE_CREATURE_TEMPLATE_SPELL, response);
          resolve();
        });
        ipcRenderer.on(
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
        ipcRenderer.on(COPY_CREATURE_TEMPLATE_SPELL, () => {
          resolve();
        });
        ipcRenderer.on(
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
