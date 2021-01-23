const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_GAME_OBJECT_QUEST_ENDERS,
  STORE_GAME_OBJECT_QUEST_ENDER,
  FIND_GAME_OBJECT_QUEST_ENDER,
  UPDATE_GAME_OBJECT_QUEST_ENDER,
  DESTROY_GAME_OBJECT_QUEST_ENDER,
  CREATE_GAME_OBJECT_QUEST_ENDER,
  COPY_GAME_OBJECT_QUEST_ENDER,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    gameObjectQuestEnders: [],
    gameObjectQuestEnder: {},
  }),
  actions: {
    searchGameObjectQuestEnders({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(SEARCH_GAME_OBJECT_QUEST_ENDERS, payload);
        ipcRenderer.on(SEARCH_GAME_OBJECT_QUEST_ENDERS, (event, response) => {
          commit(SEARCH_GAME_OBJECT_QUEST_ENDERS, response);
          resolve();
        });
      });
    },
    storeGameObjectQuestEnder(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(STORE_GAME_OBJECT_QUEST_ENDER, payload);
        ipcRenderer.on(STORE_GAME_OBJECT_QUEST_ENDER, () => {
          resolve();
        });
      });
    },
    findGameObjectQuestEnder({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(FIND_GAME_OBJECT_QUEST_ENDER, payload);
        ipcRenderer.on(FIND_GAME_OBJECT_QUEST_ENDER, (event, response) => {
          commit(FIND_GAME_OBJECT_QUEST_ENDER, response);
          resolve();
        });
      });
    },
    updateGameObjectQuestEnder(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(UPDATE_GAME_OBJECT_QUEST_ENDER, payload);
        ipcRenderer.on(UPDATE_GAME_OBJECT_QUEST_ENDER, () => {
          resolve();
        });
      });
    },
    destroyGameObjectQuestEnder(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(DESTROY_GAME_OBJECT_QUEST_ENDER, payload);
        ipcRenderer.on(DESTROY_GAME_OBJECT_QUEST_ENDER, () => {
          resolve();
        });
      });
    },
    createGameObjectQuestEnder({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_GAME_OBJECT_QUEST_ENDER, payload);
        resolve();
      });
    },
    copyGameObjectQuestEnder(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(COPY_GAME_OBJECT_QUEST_ENDER, payload);
        ipcRenderer.on(COPY_GAME_OBJECT_QUEST_ENDER, () => {
          resolve();
        });
      });
    },
  },
  mutations: {
    [SEARCH_GAME_OBJECT_QUEST_ENDERS](state, gameObjectQuestEnders) {
      state.gameObjectQuestEnders = gameObjectQuestEnders;
    },
    [FIND_GAME_OBJECT_QUEST_ENDER](state, gameObjectQuestEnder) {
      state.gameObjectQuestEnder = gameObjectQuestEnder;
    },
    [CREATE_GAME_OBJECT_QUEST_ENDER](state, gameObjectQuestEnder) {
      state.gameObjectQuestEnder = gameObjectQuestEnder;
    },
  },
};
