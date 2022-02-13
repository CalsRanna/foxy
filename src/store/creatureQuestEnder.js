const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_CREATURE_QUEST_ENDERS,
  STORE_CREATURE_QUEST_ENDER,
  FIND_CREATURE_QUEST_ENDER,
  UPDATE_CREATURE_QUEST_ENDER,
  DESTROY_CREATURE_QUEST_ENDER,
  CREATE_CREATURE_QUEST_ENDER,
  COPY_CREATURE_QUEST_ENDER,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    creatureQuestEnders: [],
    creatureQuestEnder: {},
  }),
  actions: {
    searchCreatureQuestEnders({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_CREATURE_QUEST_ENDERS, payload);
        ipcRenderer.once(SEARCH_CREATURE_QUEST_ENDERS, (event, response) => {
          commit(SEARCH_CREATURE_QUEST_ENDERS, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_CREATURE_QUEST_ENDERS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeCreatureQuestEnder(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_CREATURE_QUEST_ENDER, payload);
        ipcRenderer.once(STORE_CREATURE_QUEST_ENDER, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_CREATURE_QUEST_ENDER}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findCreatureQuestEnder({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_CREATURE_QUEST_ENDER, payload);
        ipcRenderer.once(FIND_CREATURE_QUEST_ENDER, (event, response) => {
          commit(FIND_CREATURE_QUEST_ENDER, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_CREATURE_QUEST_ENDER}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateCreatureQuestEnder(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_CREATURE_QUEST_ENDER, payload);
        ipcRenderer.once(UPDATE_CREATURE_QUEST_ENDER, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_CREATURE_QUEST_ENDER}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyCreatureQuestEnder(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_CREATURE_QUEST_ENDER, payload);
        ipcRenderer.once(DESTROY_CREATURE_QUEST_ENDER, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_CREATURE_QUEST_ENDER}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createCreatureQuestEnder({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_CREATURE_QUEST_ENDER, payload);
        resolve();
      });
    },
    copyCreatureQuestEnder(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_CREATURE_QUEST_ENDER, payload);
        ipcRenderer.once(COPY_CREATURE_QUEST_ENDER, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_CREATURE_QUEST_ENDER}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_CREATURE_QUEST_ENDERS](state, creatureQuestEnders) {
      state.creatureQuestEnders = creatureQuestEnders;
    },
    [FIND_CREATURE_QUEST_ENDER](state, creatureQuestEnder) {
      state.creatureQuestEnder = creatureQuestEnder;
    },
    [CREATE_CREATURE_QUEST_ENDER](state, creatureQuestEnder) {
      state.creatureQuestEnder = creatureQuestEnder;
    },
  },
};
