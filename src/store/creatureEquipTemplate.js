const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_CREATURE_EQUIP_TEMPLATES,
  STORE_CREATURE_EQUIP_TEMPLATE,
  FIND_CREATURE_EQUIP_TEMPLATE,
  UPDATE_CREATURE_EQUIP_TEMPLATE,
  DESTROY_CREATURE_EQUIP_TEMPLATE,
  CREATE_CREATURE_EQUIP_TEMPLATE,
  COPY_CREATURE_EQUIP_TEMPLATE
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    creatureEquipTemplates: [],
    creatureEquipTemplate: {}
  }),
  actions: {
    searchCreatureEquipTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_CREATURE_EQUIP_TEMPLATES, payload);
        ipcRenderer.on(SEARCH_CREATURE_EQUIP_TEMPLATES, (event, response) => {
          commit(SEARCH_CREATURE_EQUIP_TEMPLATES, response);
          resolve();
        });
      });
    },
    storeCreatureEquipTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(STORE_CREATURE_EQUIP_TEMPLATE, payload);
        ipcRenderer.on(STORE_CREATURE_EQUIP_TEMPLATE, (event, response) => {
          resolve();
        });
      });
    },
    findCreatureEquipTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(FIND_CREATURE_EQUIP_TEMPLATE, payload);
        ipcRenderer.on(FIND_CREATURE_EQUIP_TEMPLATE, (event, response) => {
          commit(FIND_CREATURE_EQUIP_TEMPLATE, response);
          resolve();
        });
      });
    },
    updateCreatureEquipTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(UPDATE_CREATURE_EQUIP_TEMPLATE, payload);
        ipcRenderer.on(UPDATE_CREATURE_EQUIP_TEMPLATE, (event, response) => {
          resolve();
        });
      });
    },
    destroyCreatureEquipTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(DESTROY_CREATURE_EQUIP_TEMPLATE, payload);
        ipcRenderer.on(DESTROY_CREATURE_EQUIP_TEMPLATE, (event, response) => {
          resolve();
        });
      });
    },
    createCreatureEquipTemplate({ commit }, payload) {
      return new Promise(resolve => {
        commit(CREATE_CREATURE_EQUIP_TEMPLATE, payload);
        resolve();
      });
    },
    copyCreatureEquipTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(COPY_CREATURE_EQUIP_TEMPLATE, payload);
        ipcRenderer.on(COPY_CREATURE_EQUIP_TEMPLATE, (event, response) => {
          resolve();
        });
      });
    }
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
    }
  }
};
