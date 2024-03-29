const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_CREATURE_EQUIP_TEMPLATES,
  STORE_CREATURE_EQUIP_TEMPLATE,
  FIND_CREATURE_EQUIP_TEMPLATE,
  UPDATE_CREATURE_EQUIP_TEMPLATE,
  DESTROY_CREATURE_EQUIP_TEMPLATE,
  CREATE_CREATURE_EQUIP_TEMPLATE,
  COPY_CREATURE_EQUIP_TEMPLATE,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    creatureEquipTemplates: [],
    creatureEquipTemplate: {},
  }),
  actions: {
    searchCreatureEquipTemplates({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_CREATURE_EQUIP_TEMPLATES, payload);
        ipcRenderer.once(SEARCH_CREATURE_EQUIP_TEMPLATES, (event, response) => {
          commit(SEARCH_CREATURE_EQUIP_TEMPLATES, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_CREATURE_EQUIP_TEMPLATES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeCreatureEquipTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_CREATURE_EQUIP_TEMPLATE, payload);
        ipcRenderer.once(STORE_CREATURE_EQUIP_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_CREATURE_EQUIP_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findCreatureEquipTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_CREATURE_EQUIP_TEMPLATE, payload);
        ipcRenderer.once(FIND_CREATURE_EQUIP_TEMPLATE, (event, response) => {
          commit(FIND_CREATURE_EQUIP_TEMPLATE, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_CREATURE_EQUIP_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateCreatureEquipTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_CREATURE_EQUIP_TEMPLATE, payload);
        ipcRenderer.once(UPDATE_CREATURE_EQUIP_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_CREATURE_EQUIP_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyCreatureEquipTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_CREATURE_EQUIP_TEMPLATE, payload);
        ipcRenderer.once(DESTROY_CREATURE_EQUIP_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_CREATURE_EQUIP_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createCreatureEquipTemplate({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_CREATURE_EQUIP_TEMPLATE, payload);
        ipcRenderer.once(CREATE_CREATURE_EQUIP_TEMPLATE, (event, response) => {
          commit(CREATE_CREATURE_EQUIP_TEMPLATE, response);
          resolve();
        });
        ipcRenderer.once(
          `${CREATE_CREATURE_EQUIP_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    copyCreatureEquipTemplate(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_CREATURE_EQUIP_TEMPLATE, payload);
        ipcRenderer.once(COPY_CREATURE_EQUIP_TEMPLATE, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_CREATURE_EQUIP_TEMPLATE}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_CREATURE_EQUIP_TEMPLATES](state, creatureEquipTemplates) {
      state.creatureEquipTemplates = creatureEquipTemplates;
    },
    [FIND_CREATURE_EQUIP_TEMPLATE](state, creatureEquipTemplate) {
      state.creatureEquipTemplate = creatureEquipTemplate;
    },
    [CREATE_CREATURE_EQUIP_TEMPLATE](state, creatureEquipTemplate) {
      state.creatureEquipTemplate = creatureEquipTemplate;
    },
  },
};
