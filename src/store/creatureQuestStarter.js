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
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_CREATURE_QUEST_STARTERS, payload);
        ipcRenderer.on(SEARCH_CREATURE_QUEST_STARTERS, (event, response) => {
          commit(SEARCH_CREATURE_QUEST_STARTERS, response);
          resolve();
        });
        ipcRenderer.on(
          `${SEARCH_CREATURE_QUEST_STARTERS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeCreatureQuestStarter(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_CREATURE_QUEST_STARTER, payload);
        ipcRenderer.on(STORE_CREATURE_QUEST_STARTER, () => {
          resolve();
        });
        ipcRenderer.on(
          `${STORE_CREATURE_QUEST_STARTER}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findCreatureQuestStarter({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_CREATURE_QUEST_STARTER, payload);
        ipcRenderer.on(FIND_CREATURE_QUEST_STARTER, (event, response) => {
          commit(FIND_CREATURE_QUEST_STARTER, response);
          resolve();
        });
        ipcRenderer.on(
          `${FIND_CREATURE_QUEST_STARTER}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateCreatureQuestStarter(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_CREATURE_QUEST_STARTER, payload);
        ipcRenderer.on(UPDATE_CREATURE_QUEST_STARTER, () => {
          resolve();
        });
        ipcRenderer.on(
          `${UPDATE_CREATURE_QUEST_STARTER}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyCreatureQuestStarter(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_CREATURE_QUEST_STARTER, payload);
        ipcRenderer.on(DESTROY_CREATURE_QUEST_STARTER, () => {
          resolve();
        });
        ipcRenderer.on(
          `${DESTROY_CREATURE_QUEST_STARTER}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createCreatureQuestStarter({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_CREATURE_QUEST_STARTER, payload);
        resolve();
      });
    },
    copyCreatureQuestStarter(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_CREATURE_QUEST_STARTER, payload);
        ipcRenderer.on(COPY_CREATURE_QUEST_STARTER, () => {
          resolve();
        });
        ipcRenderer.on(
          `${COPY_CREATURE_QUEST_STARTER}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
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
