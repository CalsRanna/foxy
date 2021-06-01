const ipcRenderer = window.ipcRenderer;

import { UPDATE_CHECKED_DBCS } from "../constants";

export default {
  namespaced: true,
  state: () => ({
    checkedDbcs: ["Item"],
    preparation: [],
    items: [],
    spells: [],
    scalingStatDistributions: [],
    scalingStatValues: [],
    itemSets: [],
    talents: [],
    talentTabs: [],
  }),
  actions: {
    updateCheckedDbcs({ commit }, payload) {
      commit(UPDATE_CHECKED_DBCS, payload.checkedDbcs);
    },
    searchItemDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("SEARCH_ITEM_DBC");
        ipcRenderer.on("SEARCH_ITEM_DBC", (event, items) => {
          commit("SEARCH_ITEM_DBC", items);
          resolve();
        });
        ipcRenderer.on("SEARCH_ITEM_DBC_REJECT", (event, error) => {
          reject(error);
        });
      });
    },
    searchSpellDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("SEARCH_SPELL_DBC");
        ipcRenderer.on("SEARCH_SPELL_DBC", (event, spells) => {
          commit("SEARCH_SPELL_DBC", spells);
          resolve();
        });
        ipcRenderer.on("SEARCH_SPELL_DBC_REJECT", (event, error) => {
          reject(error);
        });
      });
    },
    searchScalingStatDistributionDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("SEARCH_SCALING_STAT_DISTRIBUTION_DBC");
        ipcRenderer.on(
          "SEARCH_SCALING_STAT_DISTRIBUTION_DBC",
          (event, scalingStatDistributions) => {
            commit(
              "SEARCH_SCALING_STAT_DISTRIBUTION_DBC",
              scalingStatDistributions
            );
            resolve();
          }
        );
        ipcRenderer.on(
          "SEARCH_SCALING_STAT_DISTRIBUTION_DBC_REJECT",
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    searchScalingStatValuesDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("SEARCH_SCALING_STAT_VALUES_DBC");
        ipcRenderer.on(
          "SEARCH_SCALING_STAT_VALUES_DBC",
          (event, scalingStatValues) => {
            commit("SEARCH_SCALING_STAT_VALUES_DBC", scalingStatValues);
            resolve();
          }
        );
        ipcRenderer.on(
          "SEARCH_SCALING_STAT_VALUES_DBC_REJECT",
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    searchItemSetDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("SEARCH_ITEM_SET_DBC");
        ipcRenderer.on("SEARCH_ITEM_SET_DBC", (event, itemSets) => {
          commit("SEARCH_ITEM_SET_DBC", itemSets);
          resolve();
        });
        ipcRenderer.on("SEARCH_ITEM_SET_DBC_REJECT", (event, error) => {
          reject(error);
        });
      });
    },
    searchTalentDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("SEARCH_TALENT_DBC");
        ipcRenderer.on("SEARCH_TALENT_DBC", (event, talents) => {
          commit("SEARCH_TALENT_DBC", talents);
          resolve();
        });
        ipcRenderer.on("SEARCH_TALENT_DBC_REJECT", (event, error) => {
          reject(error);
        });
      });
    },
    searchTalentTabDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("SEARCH_TALENT_TAB_DBC");
        ipcRenderer.on("SEARCH_TALENT_TAB_DBC", (event, talentTabs) => {
          commit("SEARCH_TALENT_TAB_DBC", talentTabs);
          resolve();
        });
        ipcRenderer.on("SEARCH_TALENT_TAB_DBC_REJECT", (event, error) => {
          reject(error);
        });
      });
    },
    writeItemDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("WRITE_ITEM_DBC");
        ipcRenderer.on("WRITE_ITEM_DBC", (event) => {
          resolve();
        });
        ipcRenderer.on("WRITE_ITEM_DBC_REJECT", (event, error) => {
          reject(error);
        });
      });
    },
    writeSpellDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("WRITE_SPELL_DBC");
        ipcRenderer.on("WRITE_SPELL_DBC", (event) => {
          resolve();
        });
        ipcRenderer.on("WRITE_SPELL_DBC_REJECT", (event, error) => {
          reject(error);
        });
      });
    },
    writeScalingStatDistributionDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("WRITE_SCALING_STAT_DISTRIBUTION_DBC");
        ipcRenderer.on("WRITE_SCALING_STAT_DISTRIBUTION_DBC", (event) => {
          resolve();
        });
        ipcRenderer.on(
          "WRITE_SCALING_STAT_DISTRIBUTION_DBC_REJECT",
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    writeScalingStatValuesDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("WRITE_SCALING_STAT_VALUES_DBC");
        ipcRenderer.on("WRITE_SCALING_STAT_VALUES_DBC", (event) => {
          resolve();
        });
        ipcRenderer.on(
          "WRITE_SCALING_STAT_VALUES_DBC_REJECT",
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    writeItemSetDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("WRITE_ITEM_SET_DBC");
        ipcRenderer.on("WRITE_ITEM_SET_DBC", (event) => {
          resolve();
        });
        ipcRenderer.on("WRITE_ITEM_SET_DBC_REJECT", (event, error) => {
          reject(error);
        });
      });
    },
    writeTalentDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("WRITE_TALENT_DBC");
        ipcRenderer.on("WRITE_TALENT_DBC", (event) => {
          resolve();
        });
        ipcRenderer.on("WRITE_TALENT_DBC_REJECT", (event, error) => {
          reject(error);
        });
      });
    },
    writeTalentTabDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("WRITE_TALENT_TAB_DBC");
        ipcRenderer.on("WRITE_TALENT_TAB_DBC", (event) => {
          resolve();
        });
        ipcRenderer.on("WRITE_TALENT_TAB_DBC_REJECT", (event, error) => {
          reject(error);
        });
      });
    },
  },
  mutations: {
    [UPDATE_CHECKED_DBCS](state, checkedDbcs) {
      state.checkedDbcs = checkedDbcs;
    },
    SEARCH_ITEM_DBC(state, items) {
      state.items = items;
    },
    SEARCH_SPELL_DBC(state, spells) {
      state.spells = spells;
    },
    SEARCH_SCALING_STAT_DISTRIBUTION_DBC(state, scalingStatDistributions) {
      state.scalingStatDistributions = scalingStatDistributions;
    },
    SEARCH_SCALING_STAT_VALUES_DBC(state, scalingStatValues) {
      state.scalingStatValues = scalingStatValues;
    },
    SEARCH_ITEM_SET_DBC(state, itemSets) {
      state.itemSets = itemSets;
    },
    SEARCH_TALENT_DBC(state, talents) {
      state.talents = talents;
    },
    SEARCH_TALENT_TAB_DBC(state, talentTabs) {
      state.talentTabs = talentTabs;
    },
  },
};
