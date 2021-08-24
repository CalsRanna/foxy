const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_QUEST_OFFER_REWARD_LOCALES,
  STORE_QUEST_OFFER_REWARD_LOCALES,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    questOfferRewardLocales: [],
  }),
  actions: {
    searchQuestOfferRewardLocales({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_QUEST_OFFER_REWARD_LOCALES, payload);
        ipcRenderer.on(SEARCH_QUEST_OFFER_REWARD_LOCALES, (event, response) => {
          commit(SEARCH_QUEST_OFFER_REWARD_LOCALES, response);
          resolve();
        });
        ipcRenderer.on(
          `${SEARCH_QUEST_OFFER_REWARD_LOCALES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    storeQuestOfferRewardLocales(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_QUEST_OFFER_REWARD_LOCALES, payload);
        ipcRenderer.on(STORE_QUEST_OFFER_REWARD_LOCALES, () => {
          resolve();
        });
        ipcRenderer.on(
          `${STORE_QUEST_OFFER_REWARD_LOCALES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_QUEST_OFFER_REWARD_LOCALES](state, questOfferRewardLocales) {
      state.questOfferRewardLocales = questOfferRewardLocales;
    },
  },
};
