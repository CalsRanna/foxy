const ipcRenderer = window.ipcRenderer;

import {
  STORE_CREATURE_ONKILL_REPUTATION,
  FIND_CREATURE_ONKILL_REPUTATION,
  UPDATE_CREATURE_ONKILL_REPUTATION,
  CREATE_CREATURE_ONKILL_REPUTATION,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    creatureOnKillReputation: {},
  }),
  actions: {
    storeCreatureOnKillReputation(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_CREATURE_ONKILL_REPUTATION, payload);
        ipcRenderer.once(STORE_CREATURE_ONKILL_REPUTATION, () => {
          resolve();
        });
        ipcRenderer.once(
          `${STORE_CREATURE_ONKILL_REPUTATION}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findCreatureOnKillReputation({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_CREATURE_ONKILL_REPUTATION, payload);
        ipcRenderer.once(FIND_CREATURE_ONKILL_REPUTATION, (event, response) => {
          commit(FIND_CREATURE_ONKILL_REPUTATION, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_CREATURE_ONKILL_REPUTATION}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateCreatureOnKillReputation(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_CREATURE_ONKILL_REPUTATION, payload);
        ipcRenderer.once(UPDATE_CREATURE_ONKILL_REPUTATION, () => {
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_CREATURE_ONKILL_REPUTATION}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createCreatureOnKillReputation({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_CREATURE_ONKILL_REPUTATION, payload);
        resolve();
      });
    },
  },
  mutations: {
    [FIND_CREATURE_ONKILL_REPUTATION](state, creatureOnKillReputation) {
      state.creatureOnKillReputation = creatureOnKillReputation;
    },
    [CREATE_CREATURE_ONKILL_REPUTATION](state, creatureOnKillReputation) {
      state.creatureOnKillReputation = creatureOnKillReputation;
    },
  },
};
