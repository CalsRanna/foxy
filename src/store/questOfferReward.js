const ipcRenderer = window.ipcRenderer;

import {
  STORE_QUEST_OFFER_REWARD,
  FIND_QUEST_OFFER_REWARD,
  UPDATE_QUEST_OFFER_REWARD,
  CREATE_QUEST_OFFER_REWARD,
} from "./../constants";

export default {
  namespaced: true,
  state() {
    return {
      questOfferReward: {},
    };
  },
  actions: {
    storeQuestOfferReward(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_QUEST_OFFER_REWARD, payload);
        ipcRenderer.on(STORE_QUEST_OFFER_REWARD, () => {
          resolve();
        });
        ipcRenderer.on(`${STORE_QUEST_OFFER_REWARD}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    findQuestOfferReward({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_QUEST_OFFER_REWARD, payload);
        ipcRenderer.on(FIND_QUEST_OFFER_REWARD, (event, response) => {
          commit(FIND_QUEST_OFFER_REWARD, response);
          resolve();
        });
        ipcRenderer.on(`${FIND_QUEST_OFFER_REWARD}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    updateQuestOfferReward(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_QUEST_OFFER_REWARD, payload);
        ipcRenderer.on(UPDATE_QUEST_OFFER_REWARD, () => {
          resolve();
        });
        ipcRenderer.on(
          `${UPDATE_QUEST_OFFER_REWARD}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createQuestOfferReward({ commit }, payload) {
      return new Promise((resolve) => {
        commit(CREATE_QUEST_OFFER_REWARD, payload);
        resolve();
      });
    },
  },
  mutations: {
    [FIND_QUEST_OFFER_REWARD](state, questOfferReward) {
      state.questOfferReward = questOfferReward;
    },
    [CREATE_QUEST_OFFER_REWARD](state, questOfferReward) {
      state.questOfferReward = questOfferReward;
    },
  },
};
