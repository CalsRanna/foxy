const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_QUEST_FACTION_REWARDS,
  COUNT_QUEST_FACTION_REWARDS,
  PAGINATE_QUEST_FACTION_REWARDS,
  STORE_QUEST_FACTION_REWARD,
  FIND_QUEST_FACTION_REWARD,
  UPDATE_QUEST_FACTION_REWARD,
  DESTROY_QUEST_FACTION_REWARD,
  CREATE_QUEST_FACTION_REWARD,
  COPY_QUEST_FACTION_REWARD,
} from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      refresh: true,
      credential: {
        ID: undefined,
      },
      pagination: {
        page: 1,
        total: 0,
      },
      questFactionRewards: [],
      questFactionReward: {},
    };
  },
  actions: {
    searchQuestFactionRewards({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_QUEST_FACTION_REWARDS, payload);
        ipcRenderer.once(SEARCH_QUEST_FACTION_REWARDS, (event, response) => {
          commit(SEARCH_QUEST_FACTION_REWARDS, response);
          resolve();
        });
        ipcRenderer.once(
          `${SEARCH_QUEST_FACTION_REWARDS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    countQuestFactionRewards({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COUNT_QUEST_FACTION_REWARDS, payload);
        ipcRenderer.once(COUNT_QUEST_FACTION_REWARDS, (event, response) => {
          commit(COUNT_QUEST_FACTION_REWARDS, response);
          resolve();
        });
        ipcRenderer.once(
          `${COUNT_QUEST_FACTION_REWARDS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    paginateQuestFactionRewards({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_QUEST_FACTION_REWARDS, payload.page);
        resolve();
      });
    },
    storeQuestFactionReward({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(STORE_QUEST_FACTION_REWARD, payload);
        ipcRenderer.once(STORE_QUEST_FACTION_REWARD, () => {
          commit("UPDATE_REFRESH_OF_QUEST_FACTION_REWARD", true);
          resolve();
        });
        ipcRenderer.once(
          `${STORE_QUEST_FACTION_REWARD}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    findQuestFactionReward({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(FIND_QUEST_FACTION_REWARD, payload);
        ipcRenderer.once(FIND_QUEST_FACTION_REWARD, (event, response) => {
          commit(FIND_QUEST_FACTION_REWARD, response);
          resolve();
        });
        ipcRenderer.once(
          `${FIND_QUEST_FACTION_REWARD}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    updateQuestFactionReward({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(UPDATE_QUEST_FACTION_REWARD, payload);
        ipcRenderer.once(UPDATE_QUEST_FACTION_REWARD, () => {
          commit("UPDATE_REFRESH_OF_QUEST_FACTION_REWARD", true);
          resolve();
        });
        ipcRenderer.once(
          `${UPDATE_QUEST_FACTION_REWARD}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    destroyQuestFactionReward(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(DESTROY_QUEST_FACTION_REWARD, payload);
        ipcRenderer.once(DESTROY_QUEST_FACTION_REWARD, () => {
          resolve();
        });
        ipcRenderer.once(
          `${DESTROY_QUEST_FACTION_REWARD}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    createQuestFactionReward({ commit }, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(CREATE_QUEST_FACTION_REWARD, payload);
        ipcRenderer.once(CREATE_QUEST_FACTION_REWARD, (event, response) => {
          commit(CREATE_QUEST_FACTION_REWARD, response);
          resolve();
        });
        ipcRenderer.once(
          `${CREATE_QUEST_FACTION_REWARD}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    copyQuestFactionReward(context, payload) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(COPY_QUEST_FACTION_REWARD, payload);
        ipcRenderer.once(COPY_QUEST_FACTION_REWARD, () => {
          resolve();
        });
        ipcRenderer.once(
          `${COPY_QUEST_FACTION_REWARD}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_QUEST_FACTION_REWARD");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_QUEST_FACTION_REWARDS](state, questFactionRewards) {
      state.questFactionRewards = questFactionRewards;
      state.refresh = false;
    },
    [COUNT_QUEST_FACTION_REWARDS](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_QUEST_FACTION_REWARDS](state, page) {
      state.pagination.page = page;
    },
    [FIND_QUEST_FACTION_REWARD](state, questFactionReward) {
      state.questFactionReward = questFactionReward;
    },
    [UPDATE_QUEST_FACTION_REWARD](state, questFactionReward) {
      state.questFactionReward = questFactionReward;
    },
    [CREATE_QUEST_FACTION_REWARD](state, questFactionReward) {
      state.questFactionReward = questFactionReward;
    },
    UPDATE_REFRESH_OF_QUEST_FACTION_REWARD(state, refresh) {
      state.refresh = refresh;
    },
    RESET_CREDENTIAL_OF_QUEST_FACTION_REWARD(state) {
      state.credential = {
        ID: undefined,
      };
    },
  },
};
