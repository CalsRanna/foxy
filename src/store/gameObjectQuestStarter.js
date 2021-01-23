const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_GAME_OBJECT_QUEST_STARTERS,
  STORE_GAME_OBJECT_QUEST_STARTER,
  FIND_GAME_OBJECT_QUEST_STARTER,
  UPDATE_GAME_OBJECT_QUEST_STARTER,
  DESTROY_GAME_OBJECT_QUEST_STARTER,
  CREATE_GAME_OBJECT_QUEST_STARTER,
  COPY_GAME_OBJECT_QUEST_STARTER,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    gameObjectQuestStarters: [],
    gameObjectQuestStarter: {},
  }),
  actions: {
    searchGameObjectQuestStarters({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(SEARCH_GAME_OBJECT_QUEST_STARTERS, payload);
        ipcRenderer.on(SEARCH_GAME_OBJECT_QUEST_STARTERS, (event, response) => {
          commit(SEARCH_GAME_OBJECT_QUEST_STARTERS, response);
          resolve();
        });
      });
    },
    storeGameObjectQuestStarter(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(STORE_GAME_OBJECT_QUEST_STARTER, payload);
        ipcRenderer.on(STORE_GAME_OBJECT_QUEST_STARTER, () => {
          resolve();
        });
      });
    },
    findGameObjectQuestStarter({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(FIND_GAME_OBJECT_QUEST_STARTER, payload);
        ipcRenderer.on(FIND_GAME_OBJECT_QUEST_STARTER, (event, response) => {
          commit(FIND_GAME_OBJECT_QUEST_STARTER, response);
          resolve();
        });
      });
    },
    updateGameObjectQuestStarter(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(UPDATE_GAME_OBJECT_QUEST_STARTER, payload);
        ipcRenderer.on(UPDATE_GAME_OBJECT_QUEST_STARTER, () => {
          resolve();
        });
      });
    },
    destroyGameObjectQuestStarter(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(DESTROY_GAME_OBJECT_QUEST_STARTER, payload);
        ipcRenderer.on(DESTROY_GAME_OBJECT_QUEST_STARTER, () => {
          resolve();
        });
      });
    },
    createGameObjectQuestStarter({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_GAME_OBJECT_QUEST_STARTER, payload);
        resolve();
      });
    },
    copyGameObjectQuestStarter(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(COPY_GAME_OBJECT_QUEST_STARTER, payload);
        ipcRenderer.on(COPY_GAME_OBJECT_QUEST_STARTER, () => {
          resolve();
        });
      });
    },
  },
  mutations: {
    [SEARCH_GAME_OBJECT_QUEST_STARTERS](state, gameObjectQuestStarters) {
      state.gameObjectQuestStarters = gameObjectQuestStarters;
    },
    [FIND_GAME_OBJECT_QUEST_STARTER](state, gameObjectQuestStarter) {
      state.gameObjectQuestStarter = gameObjectQuestStarter;
    },
    [CREATE_GAME_OBJECT_QUEST_STARTER](state, gameObjectQuestStarter) {
      state.gameObjectQuestStarter = gameObjectQuestStarter;
    },
  },
};
