const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_CREATURE_QUEST_STARTERS,
  STORE_CREATURE_QUEST_STARTER,
  FIND_CREATURE_QUEST_STARTER,
  UPDATE_CREATURE_QUEST_STARTER,
  DESTROY_CREATURE_QUEST_STARTER,
  CREATE_CREATURE_QUEST_STARTER,
  COPY_CREATURE_QUEST_STARTER,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    creatureQuestStarters: [],
    creatureQuestStarter: {},
  }),
  actions: {
    searchCreatureQuestStarters({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(SEARCH_CREATURE_QUEST_STARTERS, payload);
        ipcRenderer.on(SEARCH_CREATURE_QUEST_STARTERS, (event, response) => {
          commit(SEARCH_CREATURE_QUEST_STARTERS, response);
          resolve();
        });
      });
    },
    storeCreatureQuestStarter(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(STORE_CREATURE_QUEST_STARTER, payload);
        ipcRenderer.on(STORE_CREATURE_QUEST_STARTER, () => {
          resolve();
        });
      });
    },
    findCreatureQuestStarter({ commit }, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(FIND_CREATURE_QUEST_STARTER, payload);
        ipcRenderer.on(FIND_CREATURE_QUEST_STARTER, (event, response) => {
          commit(FIND_CREATURE_QUEST_STARTER, response);
          resolve();
        });
      });
    },
    updateCreatureQuestStarter(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(UPDATE_CREATURE_QUEST_STARTER, payload);
        ipcRenderer.on(UPDATE_CREATURE_QUEST_STARTER, () => {
          resolve();
        });
      });
    },
    destroyCreatureQuestStarter(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(DESTROY_CREATURE_QUEST_STARTER, payload);
        ipcRenderer.on(DESTROY_CREATURE_QUEST_STARTER, () => {
          resolve();
        });
      });
    },
    createCreatureQuestStarter({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_CREATURE_QUEST_STARTER, payload);
        resolve();
      });
    },
    copyCreatureQuestStarter(context, payload) {
      return new Promise((resolve) => {
        ipcRenderer.send(COPY_CREATURE_QUEST_STARTER, payload);
        ipcRenderer.on(COPY_CREATURE_QUEST_STARTER, () => {
          resolve();
        });
      });
    },
  },
  mutations: {
    [SEARCH_CREATURE_QUEST_STARTERS](state, creatureQuestStarters) {
      state.creatureQuestStarters = creatureQuestStarters;
    },
    [FIND_CREATURE_QUEST_STARTER](state, creatureQuestStarter) {
      state.creatureQuestStarter = creatureQuestStarter;
    },
    [CREATE_CREATURE_QUEST_STARTER](state, creatureQuestStarter) {
      state.creatureQuestStarter = creatureQuestStarter;
    },
  },
};
