const ipcRenderer = window.require("electron").ipcRenderer;

import {
  COPY_GAME_OBJECT_TEMPLATE,
  COUNT_GAME_OBJECT_TEMPLATES,
  CREATE_GAME_OBJECT_TEMPLATE,
  DESTROY_GAME_OBJECT_TEMPLATE,
  FIND_GAME_OBJECT_TEMPLATE,
  FIND_GAME_OBJECT_TEMPLATE_ADDON,
  PAGINATE_GAME_OBJECT_TEMPLATES,
  SEARCH_GAME_OBJECT_LOOT_TEMPLATES,
  SEARCH_GAME_OBJECT_QUEST_ITEMS,
  SEARCH_GAME_OBJECT_TEMPLATES,
  SEARCH_GAME_OBJECT_TEMPLATE_LOCALES,
  STORE_GAME_OBJECT_TEMPLATE,
  STORE_GAME_OBJECT_TEMPLATE_ADDON,
  STORE_GAME_OBJECT_TEMPLATE_LOCALES,
  UPDATE_GAME_OBJECT_TEMPLATE,
  UPDATE_GAME_OBJECT_TEMPLATE_ADDON
} from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      page: 1,
      total: 0,
      gameObjectTemplates: [],
      gameObjectTemplate: {},
      gameObjectTemplateLocales: [],
      gameObjectTemplateAddon: {},
      gameObjectQuestItems: [],
      gameObjectLootTemplates: []
    };
  },
  actions: {
    searchGameObjectTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_GAME_OBJECT_TEMPLATES, payload);
        ipcRenderer.on(SEARCH_GAME_OBJECT_TEMPLATES, (event, response) => {
          commit(SEARCH_GAME_OBJECT_TEMPLATES, response);
          resolve();
        });
      });
    },
    countGameObjectTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(COUNT_GAME_OBJECT_TEMPLATES, payload);
        ipcRenderer.on(COUNT_GAME_OBJECT_TEMPLATES, (event, response) => {
          commit(COUNT_GAME_OBJECT_TEMPLATES, response);
          resolve();
        });
      });
    },
    paginateGameObjectTemplates({ commit }, payload) {
      return new Promise(resolve => {
        commit(PAGINATE_GAME_OBJECT_TEMPLATES, payload.page);
        resolve();
      });
    },
    storeGameObjectTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(STORE_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.on(STORE_GAME_OBJECT_TEMPLATE, () => {
          resolve();
        });
      });
    },
    findGameObjectTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(FIND_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.on(FIND_GAME_OBJECT_TEMPLATE, (event, response) => {
          commit(FIND_GAME_OBJECT_TEMPLATE, response);
          resolve();
        });
      });
    },
    updateGameObjectTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(UPDATE_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.on(UPDATE_GAME_OBJECT_TEMPLATE, () => {
          commit(UPDATE_GAME_OBJECT_TEMPLATE, payload);
          resolve();
        });
      });
    },
    destroyGameObjectTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(DESTROY_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.on(DESTROY_GAME_OBJECT_TEMPLATE, () => {
          resolve();
        });
      });
    },
    createGameObjectTemplate({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(CREATE_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.on(CREATE_GAME_OBJECT_TEMPLATE, (event, response) => {
          commit(CREATE_GAME_OBJECT_TEMPLATE, response);
          resolve();
        });
      });
    },
    copyGameObjectTemplate(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(COPY_GAME_OBJECT_TEMPLATE, payload);
        ipcRenderer.on(COPY_GAME_OBJECT_TEMPLATE, () => {
          resolve();
        });
      });
    },
    searchGameObjectTemplateLocales({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_GAME_OBJECT_TEMPLATE_LOCALES, payload);
        ipcRenderer.on(SEARCH_GAME_OBJECT_TEMPLATE_LOCALES, (event, response) => {
          commit(SEARCH_GAME_OBJECT_TEMPLATE_LOCALES, response);
          resolve();
        });
      });
    },
    storeGameObjectTemplateLocales(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(STORE_GAME_OBJECT_TEMPLATE_LOCALES, payload);
        ipcRenderer.on(STORE_GAME_OBJECT_TEMPLATE_LOCALES, () => {
          resolve();
        });
      });
    },
    storeGameObjectTemplateAddon(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(STORE_GAME_OBJECT_TEMPLATE_ADDON, payload);
        ipcRenderer.on(STORE_GAME_OBJECT_TEMPLATE_ADDON, () => {
          resolve();
        });
      });
    },
    findGameObjectTemplateAddon({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(FIND_GAME_OBJECT_TEMPLATE_ADDON, payload);
        ipcRenderer.on(FIND_GAME_OBJECT_TEMPLATE_ADDON, (event, response) => {
          commit(FIND_GAME_OBJECT_TEMPLATE_ADDON, response);
          resolve();
        });
      });
    },
    updateGameObjectTemplateAddon(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(UPDATE_GAME_OBJECT_TEMPLATE_ADDON, payload);
        ipcRenderer.on(UPDATE_GAME_OBJECT_TEMPLATE_ADDON, () => {
          resolve();
        });
      });
    },
    searchGameObjectQuestItems({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_GAME_OBJECT_QUEST_ITEMS, payload);
        ipcRenderer.on(SEARCH_GAME_OBJECT_QUEST_ITEMS, (event, response) => {
          commit(SEARCH_GAME_OBJECT_QUEST_ITEMS, response);
          resolve();
        });
      });
    },
    searchGameObjectLootTemplates({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_GAME_OBJECT_LOOT_TEMPLATES, payload);
        ipcRenderer.on(SEARCH_GAME_OBJECT_LOOT_TEMPLATES, (event, response) => {
          commit(SEARCH_GAME_OBJECT_LOOT_TEMPLATES, response);
          resolve();
        });
      });
    }
  },
  mutations: {
    [SEARCH_GAME_OBJECT_TEMPLATES](state, gameObjectTemplates) {
      state.gameObjectTemplates = gameObjectTemplates;
    },
    [COUNT_GAME_OBJECT_TEMPLATES](state, total) {
      state.total = total;
    },
    [PAGINATE_GAME_OBJECT_TEMPLATES](state, page) {
      state.page = page;
    },
    [FIND_GAME_OBJECT_TEMPLATE](state, gameObjectTemplate) {
      state.gameObjectTemplate = gameObjectTemplate;
    },
    [UPDATE_GAME_OBJECT_TEMPLATE](state, gameObjectTemplate) {
      state.gameObjectTemplate = gameObjectTemplate;
    },
    [CREATE_GAME_OBJECT_TEMPLATE](state, gameObjectTemplate) {
      state.gameObjectTemplate = gameObjectTemplate;
    },
    [SEARCH_GAME_OBJECT_TEMPLATE_LOCALES](state, gameObjectTemplateLocales) {
      state.gameObjectTemplateLocales = gameObjectTemplateLocales;
    },
    [FIND_GAME_OBJECT_TEMPLATE_ADDON](state, gameObjectTemplateAddon) {
      state.gameObjectTemplateAddon = gameObjectTemplateAddon;
    },
    [SEARCH_GAME_OBJECT_QUEST_ITEMS](state, gameObjectQuestItems) {
      state.gameObjectQuestItems = gameObjectQuestItems;
    },
    [SEARCH_GAME_OBJECT_LOOT_TEMPLATES](state, gameObjectLootTemplates) {
      state.gameObjectLootTemplates = gameObjectLootTemplates;
    }
  }
};
