const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_NPC_TRAINERS,
  STORE_NPC_TRAINER,
  FIND_NPC_TRAINER,
  UPDATE_NPC_TRAINER,
  DESTROY_NPC_TRAINER,
  CREATE_NPC_TRAINER,
  COPY_NPC_TRAINER,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    npcTrainers: [],
    npcTrainer: {},
  }),
  actions: {
    searchNpcTrainers({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_NPC_TRAINERS, payload);
        ipcRenderer.once(SEARCH_NPC_TRAINERS, (event, response) => {
          commit(SEARCH_NPC_TRAINERS, response);
          resolve();
        });
        ipcRenderer.once(`${SEARCH_NPC_TRAINERS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    storeNpcTrainer(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_NPC_TRAINER, payload);
        ipcRenderer.once(STORE_NPC_TRAINER, () => {
          resolve();
        });
        ipcRenderer.once(`${STORE_NPC_TRAINER}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findNpcTrainer({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_NPC_TRAINER, payload);
        ipcRenderer.once(FIND_NPC_TRAINER, (event, response) => {
          commit(FIND_NPC_TRAINER, response);
          resolve();
        });
        ipcRenderer.once(`${FIND_NPC_TRAINER}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateNpcTrainer(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_NPC_TRAINER, payload);
        ipcRenderer.once(UPDATE_NPC_TRAINER, () => {
          resolve();
        });
        ipcRenderer.once(`${UPDATE_NPC_TRAINER}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    destroyNpcTrainer(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_NPC_TRAINER, payload);
        ipcRenderer.once(DESTROY_NPC_TRAINER, () => {
          resolve();
        });
        ipcRenderer.once(`${DESTROY_NPC_TRAINER}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    createNpcTrainer({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_NPC_TRAINER, payload);
        resolve();
      });
    },
    copyNpcTrainer(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_NPC_TRAINER, payload);
        ipcRenderer.once(COPY_NPC_TRAINER, () => {
          resolve();
        });
        ipcRenderer.once(`${COPY_NPC_TRAINER}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
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
    },
  },
};
