const ipcRenderer = window.ipcRenderer;

import { UPDATE_CHECKED_DBCS } from "../constants";

export default {
  namespaced: true,
  state: () => ({
    checkedDbcs: ["Item", "Spell"],
    preparation: [],
    areaTables: [],
    emotesTexts: [],
    items: [],
    itemSets: [],
    questFactionRewards: [],
    questInfos: [],
    questSorts: [],
    scalingStatDistributions: [],
    scalingStatValues: [],
    spells: [],
    spellItemEnchantments: [],
    talents: [],
    talentTabs: [],
  }),
  actions: {
    updateCheckedDbcs({ commit }, payload) {
      commit(UPDATE_CHECKED_DBCS, payload.checkedDbcs);
    },
    searchAreaTableDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("SEARCH_AREA_TABLE_DBC");
        ipcRenderer.on("SEARCH_AREA_TABLE_DBC", (event, areaTables) => {
          commit("SEARCH_AREA_TABLE_DBC", areaTables);
          resolve();
        });
        ipcRenderer.on("SEARCH_AREA_TABLE_DBC_REJECT", (event, error) => {
          reject(error);
        });
      });
    },
    searchEmotesTextDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("SEARCH_EMOTES_TEXT_DBC");
        ipcRenderer.on("SEARCH_EMOTES_TEXT_DBC", (event, emotesTexts) => {
          commit("SEARCH_EMOTES_TEXT_DBC", emotesTexts);
          resolve();
        });
        ipcRenderer.on("SEARCH_EMOTES_TEXT_DBC_REJECT", (event, error) => {
          reject(error);
        });
      });
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
    searchQuestFactionRewardDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("SEARCH_QUEST_FACTION_REWARD_DBC");
        ipcRenderer.on(
          "SEARCH_QUEST_FACTION_REWARD_DBC",
          (event, questFactionRewards) => {
            commit("SEARCH_QUEST_FACTION_REWARD_DBC", questFactionRewards);
            resolve();
          }
        );
        ipcRenderer.on(
          "SEARCH_QUEST_FACTION_REWARD_DBC_REJECT",
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    searchQuestInfoDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("SEARCH_QUEST_INFO_DBC");
        ipcRenderer.on("SEARCH_QUEST_INFO_DBC", (event, questInfos) => {
          commit("SEARCH_QUEST_INFO_DBC", questInfos);
          resolve();
        });
        ipcRenderer.on("SEARCH_QUEST_INFO_DBC_REJECT", (event, error) => {
          reject(error);
        });
      });
    },
    searchQuestSortDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("SEARCH_QUEST_SORT_DBC");
        ipcRenderer.on("SEARCH_QUEST_SORT_DBC", (event, questSorts) => {
          commit("SEARCH_QUEST_SORT_DBC", questSorts);
          resolve();
        });
        ipcRenderer.on("SEARCH_QUEST_SORT_DBC_REJECT", (event, error) => {
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
    searchSpellItemEnchantmentDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("SEARCH_SPELL_ITEM_ENCHANTMENT_DBC");
        ipcRenderer.on(
          "SEARCH_SPELL_ITEM_ENCHANTMENT_DBC",
          (event, spellItemEnchantments) => {
            commit("SEARCH_SPELL_ITEM_ENCHANTMENT_DBC", spellItemEnchantments);
            resolve();
          }
        );
        ipcRenderer.on(
          "SEARCH_SPELL_ITEM_ENCHANTMENT_DBC_REJECT",
          (event, error) => {
            reject(error);
          }
        );
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
    writeAreaTableDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("WRITE_AREA_TABLE_DBC");
        ipcRenderer.on("WRITE_AREA_TABLE_DBC", (event) => {
          resolve();
        });
        ipcRenderer.on("WRITE_AREA_TABLE_DBC_REJECT", (event, error) => {
          reject(error);
        });
      });
    },
    writeEmotesTextDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("WRITE_EMOTES_TEXT_DBC");
        ipcRenderer.on("WRITE_EMOTES_TEXT_DBC", (event) => {
          resolve();
        });
        ipcRenderer.on("WRITE_EMOTES_TEXT_DBC_REJECT", (event, error) => {
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
    writeQuestFactionRewardDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("WRITE_QUEST_FACTION_REWARD_DBC");
        ipcRenderer.on("WRITE_QUEST_FACTION_REWARD_DBC", (event) => {
          resolve();
        });
        ipcRenderer.on(
          "WRITE_QUEST_FACTION_REWARD_DBC_REJECT",
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    writeQuestInfoDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("WRITE_QUEST_INFO_DBC");
        ipcRenderer.on("WRITE_QUEST_INFO_DBC", (event) => {
          resolve();
        });
        ipcRenderer.on("WRITE_QUEST_INFO_DBC_REJECT", (event, error) => {
          reject(error);
        });
      });
    },
    writeQuestSortDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("WRITE_QUEST_SORT_DBC");
        ipcRenderer.on("WRITE_QUEST_SORT_DBC", (event) => {
          resolve();
        });
        ipcRenderer.on("WRITE_QUEST_SORT_DBC_REJECT", (event, error) => {
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
    writeSpellItemEnchantmentDbc({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send("WRITE_SPELL_ITEM_ENCHANTMENT_DBC");
        ipcRenderer.on("WRITE_SPELL_ITEM_ENCHANTMENT_DBC", (event) => {
          resolve();
        });
        ipcRenderer.on(
          "WRITE_SPELL_ITEM_ENCHANTMENT_DBC_REJECT",
          (event, error) => {
            reject(error);
          }
        );
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
    SEARCH_AREA_TABLE_DBC(state, areaTables) {
      state.areaTables = areaTables;
    },
    SEARCH_EMOTES_TEXT_DBC(state, emotesTexts) {
      state.emotesTexts = emotesTexts;
    },
    SEARCH_ITEM_DBC(state, items) {
      state.items = items;
    },
    SEARCH_ITEM_SET_DBC(state, itemSets) {
      state.itemSets = itemSets;
    },
    SEARCH_QUEST_FACTION_REWARD_DBC(state, questFactionRewards) {
      state.questFactionRewards = questFactionRewards;
    },
    SEARCH_QUEST_INFO_DBC(state, questInfos) {
      state.questInfos = questInfos;
    },
    SEARCH_QUEST_SORT_DBC(state, questSorts) {
      state.questSorts = questSorts;
    },
    SEARCH_SCALING_STAT_DISTRIBUTION_DBC(state, scalingStatDistributions) {
      state.scalingStatDistributions = scalingStatDistributions;
    },
    SEARCH_SCALING_STAT_VALUES_DBC(state, scalingStatValues) {
      state.scalingStatValues = scalingStatValues;
    },
    SEARCH_SPELL_DBC(state, spells) {
      state.spells = spells;
    },
    SEARCH_SPELL_ITEM_ENCHANTMENT_DBC(state, spellItemEnchantments) {
      state.spellItemEnchantments = spellItemEnchantments;
    },
    SEARCH_TALENT_DBC(state, talents) {
      state.talents = talents;
    },
    SEARCH_TALENT_TAB_DBC(state, talentTabs) {
      state.talentTabs = talentTabs;
    },
  },
};
