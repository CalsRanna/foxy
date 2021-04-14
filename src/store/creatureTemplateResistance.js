const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_CREATURE_TEMPLATE_RESISTANCES,
  STORE_CREATURE_TEMPLATE_RESISTANCE,
  FIND_CREATURE_TEMPLATE_RESISTANCE,
  UPDATE_CREATURE_TEMPLATE_RESISTANCE,
  DESTROY_CREATURE_TEMPLATE_RESISTANCE,
  CREATE_CREATURE_TEMPLATE_RESISTANCE,
  COPY_CREATURE_TEMPLATE_RESISTANCE,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    creatureTemplateResistances: [],
    creatureTemplateResistance: {},
  }),
  actions: {
    searchCreatureTemplateResistances({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_CREATURE_TEMPLATE_RESISTANCES, payload);
        ipcRenderer.on(
          SEARCH_CREATURE_TEMPLATE_RESISTANCES,
          (event, response) => {
            commit(SEARCH_CREATURE_TEMPLATE_RESISTANCES, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${SEARCH_CREATURE_TEMPLATE_RESISTANCES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeCreatureTemplateResistance(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_CREATURE_TEMPLATE_RESISTANCE, payload);
        ipcRenderer.on(STORE_CREATURE_TEMPLATE_RESISTANCE, () => {
          resolve();
        });
        ipcRenderer.on(
          `${STORE_CREATURE_TEMPLATE_RESISTANCE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findCreatureTemplateResistance({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_CREATURE_TEMPLATE_RESISTANCE, payload);
        ipcRenderer.on(FIND_CREATURE_TEMPLATE_RESISTANCE, (event, response) => {
          commit(FIND_CREATURE_TEMPLATE_RESISTANCE, response);
          resolve();
        });
        ipcRenderer.on(
          `${FIND_CREATURE_TEMPLATE_RESISTANCE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateCreatureTemplateResistance(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_CREATURE_TEMPLATE_RESISTANCE, payload);
        ipcRenderer.on(UPDATE_CREATURE_TEMPLATE_RESISTANCE, () => {
          resolve();
        });
        ipcRenderer.on(
          `${UPDATE_CREATURE_TEMPLATE_RESISTANCE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyCreatureTemplateResistance(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_CREATURE_TEMPLATE_RESISTANCE, payload);
        ipcRenderer.on(DESTROY_CREATURE_TEMPLATE_RESISTANCE, () => {
          resolve();
        });
        ipcRenderer.on(
          `${DESTROY_CREATURE_TEMPLATE_RESISTANCE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createCreatureTemplateResistance({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_CREATURE_TEMPLATE_RESISTANCE, payload);
        ipcRenderer.on(
          CREATE_CREATURE_TEMPLATE_RESISTANCE,
          (event, response) => {
            commit(CREATE_CREATURE_TEMPLATE_RESISTANCE, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${CREATE_CREATURE_TEMPLATE_RESISTANCE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    copyCreatureTemplateResistance(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_CREATURE_TEMPLATE_RESISTANCE, payload);
        ipcRenderer.on(COPY_CREATURE_TEMPLATE_RESISTANCE, () => {
          resolve();
        });
        ipcRenderer.on(
          `${COPY_CREATURE_TEMPLATE_RESISTANCE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_CREATURE_TEMPLATE_RESISTANCES](state, creatureTemplateResistances) {
      state.creatureTemplateResistances = creatureTemplateResistances;
    },
    [FIND_CREATURE_TEMPLATE_RESISTANCE](state, creatureTemplateResistance) {
      state.creatureTemplateResistance = creatureTemplateResistance;
    },
    [CREATE_CREATURE_TEMPLATE_RESISTANCE](state, creatureTemplateResistance) {
      state.creatureTemplateResistance = creatureTemplateResistance;
    },
  },
};
