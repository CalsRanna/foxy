const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_NPC_TRAINERS,
  STORE_NPC_TRAINER,
  FIND_NPC_TRAINER,
  UPDATE_NPC_TRAINER,
  DESTROY_NPC_TRAINER,
  CREATE_NPC_TRAINER,
  COPY_NPC_TRAINER
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    npcTrainers: [],
    npcTrainer: {}
  }),
  actions: {
    searchNpcTrainers({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_NPC_TRAINERS, payload);
        ipcRenderer.on(SEARCH_NPC_TRAINERS, (event, response) => {
          commit(SEARCH_NPC_TRAINERS, response);
          resolve();
        });
      });
    },
    storeNpcTrainer(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(STORE_NPC_TRAINER, payload);
        ipcRenderer.on(STORE_NPC_TRAINER, () => {
          resolve();
        });
      });
    },
    findNpcTrainer({ commit }, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(FIND_NPC_TRAINER, payload);
        ipcRenderer.on(FIND_NPC_TRAINER, (event, response) => {
          commit(FIND_NPC_TRAINER, response);
          resolve();
        });
      });
    },
    updateNpcTrainer(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(UPDATE_NPC_TRAINER, payload);
        ipcRenderer.on(UPDATE_NPC_TRAINER, () => {
          resolve();
        });
      });
    },
    destroyNpcTrainer(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(DESTROY_NPC_TRAINER, payload);
        ipcRenderer.on(DESTROY_NPC_TRAINER, () => {
          resolve();
        });
      });
    },
    createNpcTrainer({ commit }, payload) {
      return new Promise(resolve => {
        commit(CREATE_NPC_TRAINER, payload);
        resolve();
      });
    },
    copyNpcTrainer(context, payload) {
      return new Promise(resolve => {
        ipcRenderer.send(COPY_NPC_TRAINER, payload);
        ipcRenderer.on(COPY_NPC_TRAINER, () => {
          resolve();
        });
      });
    }
  },
  mutations: {
    [SEARCH_NPC_TRAINERS](state, npcTrainers) {
      state.npcTrainers = npcTrainers;
    },
    [FIND_NPC_TRAINER](state, npcTrainer) {
      state.npcTrainer = npcTrainer;
    },
    [CREATE_NPC_TRAINER](state, npcTrainer) {
      state.npcTrainer = npcTrainer;
    }
  }
};
