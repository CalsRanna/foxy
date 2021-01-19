const ipcRenderer = window.require("electron").ipcRenderer;

import {
  STORE_CREATURE_ONKILL_REPUTATION,
  FIND_CREATURE_ONKILL_REPUTATION,
  UPDATE_CREATURE_ONKILL_REPUTATION,
  CREATE_CREATURE_ONKILL_REPUTATION
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    creatureOnKillReputation: {}
  }),
  actions: {
    storeCreatureOnKillReputation(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(STORE_CREATURE_ONKILL_REPUTATION, payload);
        ipcRenderer.on(STORE_CREATURE_ONKILL_REPUTATION, () => {
          resolve();
        });
      });
    },
    findCreatureOnKillReputation({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(FIND_CREATURE_ONKILL_REPUTATION, payload);
        ipcRenderer.on(FIND_CREATURE_ONKILL_REPUTATION, (event, response) => {
          commit(FIND_CREATURE_ONKILL_REPUTATION, response);
          resolve();
        });
      });
    },
    updateCreatureOnKillReputation(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(UPDATE_CREATURE_ONKILL_REPUTATION, payload);
        ipcRenderer.on(UPDATE_CREATURE_ONKILL_REPUTATION, () => {
          resolve();
        });
      });
    },
    createCreatureOnKillReputation({ commit }, payload) {
      return new Promise(resolve => {
        commit(CREATE_CREATURE_ONKILL_REPUTATION, payload);
        resolve();
      });
    }
  },
  mutations: {
    [FIND_CREATURE_ONKILL_REPUTATION](state, creatureOnKillReputation) {
      state.creatureOnKillReputation = creatureOnKillReputation;
    },
    [CREATE_CREATURE_ONKILL_REPUTATION](state, creatureOnKillReputation) {
      state.creatureOnKillReputation = creatureOnKillReputation;
    }
  }
};
