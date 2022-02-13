const ipcRenderer = window.ipcRenderer;

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
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_GAME_OBJECT_QUEST_STARTERS, payload);
        ipcRenderer.once(
          SEARCH_GAME_OBJECT_QUEST_STARTERS,
          (event, response) => {
            commit(SEARCH_GAME_OBJECT_QUEST_STARTERS, response);
            resolve();
          }
        );
        ipcRenderer.once(
          `${SEARCH_GAME_OBJECT_QUEST_STARTERS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeGameObjectQuestStarter(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_GAME_OBJECT_QUEST_STARTER, payload);
        ipcRenderer.once(STORE_GAME_OBJECT_QUEST_STARTER, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_GAME_OBJECT_QUEST_STARTER}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findGameObjectQuestStarter({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_GAME_OBJECT_QUEST_STARTER, payload);
        ipcRenderer.once(FIND_GAME_OBJECT_QUEST_STARTER, (event, response) => {
          commit(FIND_GAME_OBJECT_QUEST_STARTER, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_GAME_OBJECT_QUEST_STARTER}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateGameObjectQuestStarter(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_GAME_OBJECT_QUEST_STARTER, payload);
        ipcRenderer.once(UPDATE_GAME_OBJECT_QUEST_STARTER, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_GAME_OBJECT_QUEST_STARTER}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyGameObjectQuestStarter(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_GAME_OBJECT_QUEST_STARTER, payload);
        ipcRenderer.once(DESTROY_GAME_OBJECT_QUEST_STARTER, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_GAME_OBJECT_QUEST_STARTER}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createGameObjectQuestStarter({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_GAME_OBJECT_QUEST_STARTER, payload);
        resolve();
      });
    },
    copyGameObjectQuestStarter(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_GAME_OBJECT_QUEST_STARTER, payload);
        ipcRenderer.once(COPY_GAME_OBJECT_QUEST_STARTER, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_GAME_OBJECT_QUEST_STARTER}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
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
