const ipcRenderer = window.ipcRenderer;

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
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_GAME_OBJECT_QUEST_ENDERS, payload);
        ipcRenderer.once(SEARCH_GAME_OBJECT_QUEST_ENDERS, (event, response) => {
          commit(SEARCH_GAME_OBJECT_QUEST_ENDERS, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_GAME_OBJECT_QUEST_ENDERS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeGameObjectQuestEnder(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_GAME_OBJECT_QUEST_ENDER, payload);
        ipcRenderer.once(STORE_GAME_OBJECT_QUEST_ENDER, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_GAME_OBJECT_QUEST_ENDER}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findGameObjectQuestEnder({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_GAME_OBJECT_QUEST_ENDER, payload);
        ipcRenderer.once(FIND_GAME_OBJECT_QUEST_ENDER, (event, response) => {
          commit(FIND_GAME_OBJECT_QUEST_ENDER, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_GAME_OBJECT_QUEST_ENDER}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateGameObjectQuestEnder(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_GAME_OBJECT_QUEST_ENDER, payload);
        ipcRenderer.once(UPDATE_GAME_OBJECT_QUEST_ENDER, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_GAME_OBJECT_QUEST_ENDER}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyGameObjectQuestEnder(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_GAME_OBJECT_QUEST_ENDER, payload);
        ipcRenderer.once(DESTROY_GAME_OBJECT_QUEST_ENDER, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_GAME_OBJECT_QUEST_ENDER}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createGameObjectQuestEnder({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_GAME_OBJECT_QUEST_ENDER, payload);
        resolve();
      });
    },
    copyGameObjectQuestEnder(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_GAME_OBJECT_QUEST_ENDER, payload);
        ipcRenderer.once(COPY_GAME_OBJECT_QUEST_ENDER, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_GAME_OBJECT_QUEST_ENDER}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
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
