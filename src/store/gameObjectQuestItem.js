const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_GAME_OBJECT_QUEST_ITEMS,
  STORE_GAME_OBJECT_QUEST_ITEM,
  FIND_GAME_OBJECT_QUEST_ITEM,
  UPDATE_GAME_OBJECT_QUEST_ITEM,
  DESTROY_GAME_OBJECT_QUEST_ITEM,
  CREATE_GAME_OBJECT_QUEST_ITEM,
  COPY_GAME_OBJECT_QUEST_ITEM,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    gameObjectQuestItems: [],
    gameObjectQuestItem: {},
  }),
  actions: {
    searchGameObjectQuestItems({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(SEARCH_GAME_OBJECT_QUEST_ITEMS, payload);
        ipcRenderer.on(SEARCH_GAME_OBJECT_QUEST_ITEMS, (event, response) => {
          commit(SEARCH_GAME_OBJECT_QUEST_ITEMS, response);
          resolve();
        });
      });
    },
    storeGameObjectQuestItem(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(STORE_GAME_OBJECT_QUEST_ITEM, payload);
        ipcRenderer.on(STORE_GAME_OBJECT_QUEST_ITEM, () => {
          resolve();
        });
      });
    },
    findGameObjectQuestItem({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(FIND_GAME_OBJECT_QUEST_ITEM, payload);
        ipcRenderer.on(FIND_GAME_OBJECT_QUEST_ITEM, (event, response) => {
          commit(FIND_GAME_OBJECT_QUEST_ITEM, response);
          resolve();
        });
      });
    },
    updateGameObjectQuestItem(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(UPDATE_GAME_OBJECT_QUEST_ITEM, payload);
        ipcRenderer.on(UPDATE_GAME_OBJECT_QUEST_ITEM, () => {
          resolve();
        });
      });
    },
    destroyGameObjectQuestItem(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(DESTROY_GAME_OBJECT_QUEST_ITEM, payload);
        ipcRenderer.on(DESTROY_GAME_OBJECT_QUEST_ITEM, () => {
          resolve();
        });
      });
    },
    createGameObjectQuestItem({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(CREATE_GAME_OBJECT_QUEST_ITEM, payload);
        ipcRenderer.on(CREATE_GAME_OBJECT_QUEST_ITEM, (event, response) => {
          commit(CREATE_GAME_OBJECT_QUEST_ITEM, response);
          resolve();
        });
      });
    },
    copyGameObjectQuestItem(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(COPY_GAME_OBJECT_QUEST_ITEM, payload);
        ipcRenderer.on(COPY_GAME_OBJECT_QUEST_ITEM, () => {
          resolve();
        });
      });
    },
  },
  mutations: {
    [SEARCH_GAME_OBJECT_QUEST_ITEMS](state, gameObjectQuestItems) {
      state.gameObjectQuestItems = gameObjectQuestItems;
    },
    [FIND_GAME_OBJECT_QUEST_ITEM](state, gameObjectQuestItem) {
      state.gameObjectQuestItem = gameObjectQuestItem;
    },
    [CREATE_GAME_OBJECT_QUEST_ITEM](state, gameObjectQuestItem) {
      state.gameObjectQuestItem = gameObjectQuestItem;
    },
  },
};
