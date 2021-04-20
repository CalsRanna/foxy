const ipcRenderer = window.ipcRenderer;

import {
  SEARCH_DBC_FACTIONS,
  SEARCH_DBC_FACTION_TEMPLATES,
  SEARCH_DBC_CREATURE_SPELL_DATAS,
  SEARCH_DBC_CREATURE_DISPLAY_INFOS,
  SEARCH_DBC_CREATURE_MODEL_DATAS,
  SEARCH_DBC_ITEM_DISPLAY_INFOS,
  SEARCH_DBC_ITEMS,
  SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS,
  SEARCH_DBC_SCALING_STAT_VALUES,
  SEARCH_DBC_SPELLS,
  EXPORT_SPELL_DBC,
  SEARCH_DBC_SPELL_DURATIONS,
  SEARCH_DBC_ITEM_SETS,
  SEARCH_DBC_SPELL_ITEM_ENCHANTMENTS,
  SEARCH_DBC_ITEM_RANDOM_PROPERTITIES,
  SEARCH_DBC_ITEM_RANDOM_SUFFIXES,
  SEARCH_DBC_SPELL_CAST_TIMES,
  SEARCH_DBC_SPELL_RANGES,
  SEARCH_DBC_TALENTS,
  EXPORT_ITEM_DBC,
  EXPORT_SCALING_STAT_DISTRIBUTION_DBC,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    factions: {},
    factionTemplates: {},
    creatureSpellDatas: {},
    creatureDisplayInfos: {},
    creatureModelDatas: {},
    items: {},
    itemDisplayInfos: {},
    spells: {},
    spellDurations: {},
    scalingStatDistributions: {},
    scalingStatValues: {},
    itemSets: {},
    spellItemEnchantments: {},
    itemRandomProperties: {},
    itemRandomSuffixes: {},
    spellCastTimes: {},
    spellRanges: {},
    talents: {},
  }),
  getters: {
    itemIcons: (state) => {
      let icons = {};
      for (let record of state.itemDisplayInfos.records) {
        icons[record["id"]] = record["inventoryIcon1"];
      }
      return icons;
    },
  },
  actions: {
    searchDbcFactions({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_DBC_FACTIONS);
        ipcRenderer.on(SEARCH_DBC_FACTIONS, (event, response) => {
          commit(SEARCH_DBC_FACTIONS, response);
          resolve();
        });
        ipcRenderer.on(`${SEARCH_DBC_FACTIONS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    searchDbcFactionTemplates({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_DBC_FACTION_TEMPLATES);
        ipcRenderer.on(SEARCH_DBC_FACTION_TEMPLATES, (event, response) => {
          commit(SEARCH_DBC_FACTION_TEMPLATES, response);
          resolve();
        });
        ipcRenderer.on(
          `${SEARCH_DBC_FACTION_TEMPLATES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    searchDbcCreatureSpellDatas({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_DBC_CREATURE_SPELL_DATAS);
        ipcRenderer.on(SEARCH_DBC_CREATURE_SPELL_DATAS, (event, response) => {
          commit(SEARCH_DBC_CREATURE_SPELL_DATAS, response);
          resolve();
        });
        ipcRenderer.on(
          `${SEARCH_DBC_CREATURE_SPELL_DATAS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    searchDbcCreatureDisplayInfos({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_DBC_CREATURE_DISPLAY_INFOS);
        ipcRenderer.on(SEARCH_DBC_CREATURE_DISPLAY_INFOS, (event, response) => {
          commit(SEARCH_DBC_CREATURE_DISPLAY_INFOS, response);
          resolve();
        });
        ipcRenderer.on(
          `${SEARCH_DBC_CREATURE_DISPLAY_INFOS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    searchDbcCreatureModelDatas({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_DBC_CREATURE_MODEL_DATAS);
        ipcRenderer.on(SEARCH_DBC_CREATURE_MODEL_DATAS, (event, response) => {
          commit(SEARCH_DBC_CREATURE_MODEL_DATAS, response);
          resolve();
        });
        ipcRenderer.on(
          `${SEARCH_DBC_CREATURE_MODEL_DATAS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    searchDbcItems({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_DBC_ITEMS);
        ipcRenderer.on(SEARCH_DBC_ITEMS, (event, response) => {
          commit(SEARCH_DBC_ITEMS, response);
          resolve();
        });
        ipcRenderer.on(`${SEARCH_DBC_ITEMS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    searchDbcItemDisplayInfos({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_DBC_ITEM_DISPLAY_INFOS);
        ipcRenderer.on(SEARCH_DBC_ITEM_DISPLAY_INFOS, (event, response) => {
          commit(SEARCH_DBC_ITEM_DISPLAY_INFOS, response);
          resolve();
        });
        ipcRenderer.on(
          `${SEARCH_DBC_ITEM_DISPLAY_INFOS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    searchDbcSpells({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_DBC_SPELLS);
        ipcRenderer.on(SEARCH_DBC_SPELLS, () => {
          commit(SEARCH_DBC_SPELLS, {});
          resolve();
        });
        ipcRenderer.on(`${SEARCH_DBC_SPELLS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    searchDbcSpellDurations({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_DBC_SPELL_DURATIONS);
        ipcRenderer.on(SEARCH_DBC_SPELL_DURATIONS, (event, response) => {
          commit(SEARCH_DBC_SPELL_DURATIONS, response);
          resolve();
        });
        ipcRenderer.on(
          `${SEARCH_DBC_SPELL_DURATIONS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    searchDbcScalingStatDistributions({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS);
        ipcRenderer.on(
          SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS,
          (event, response) => {
            commit(SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    searchDbcScalingStatValues({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_DBC_SCALING_STAT_VALUES);
        ipcRenderer.on(SEARCH_DBC_SCALING_STAT_VALUES, (event, response) => {
          commit(SEARCH_DBC_SCALING_STAT_VALUES, response);
          resolve();
        });
        ipcRenderer.on(
          `${SEARCH_DBC_SCALING_STAT_VALUES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    searchDbcItemSets({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_DBC_ITEM_SETS);
        ipcRenderer.on(SEARCH_DBC_ITEM_SETS, (event, response) => {
          commit(SEARCH_DBC_ITEM_SETS, response);
          resolve();
        });
        ipcRenderer.on(`${SEARCH_DBC_ITEM_SETS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    searchDbcSpellItemEnchantments({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_DBC_SPELL_ITEM_ENCHANTMENTS);
        ipcRenderer.on(
          SEARCH_DBC_SPELL_ITEM_ENCHANTMENTS,
          (event, response) => {
            commit(SEARCH_DBC_SPELL_ITEM_ENCHANTMENTS, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${SEARCH_DBC_SPELL_ITEM_ENCHANTMENTS}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    searchDbcItemRandomProperties({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_DBC_ITEM_RANDOM_PROPERTITIES);
        ipcRenderer.on(
          SEARCH_DBC_ITEM_RANDOM_PROPERTITIES,
          (event, response) => {
            commit(SEARCH_DBC_ITEM_RANDOM_PROPERTITIES, response);
            resolve();
          }
        );
        ipcRenderer.on(
          `${SEARCH_DBC_ITEM_RANDOM_PROPERTITIES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    searchDbcItemRandomSuffixes({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_DBC_ITEM_RANDOM_SUFFIXES);
        ipcRenderer.on(SEARCH_DBC_ITEM_RANDOM_SUFFIXES, (event, response) => {
          commit(SEARCH_DBC_ITEM_RANDOM_SUFFIXES, response);
          resolve();
        });
        ipcRenderer.on(
          `${SEARCH_DBC_ITEM_RANDOM_SUFFIXES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    searchDbcSpellCastTimes({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_DBC_SPELL_CAST_TIMES);
        ipcRenderer.on(SEARCH_DBC_SPELL_CAST_TIMES, (event, response) => {
          commit(SEARCH_DBC_SPELL_CAST_TIMES, response);
          resolve();
        });
        ipcRenderer.on(
          `${SEARCH_DBC_SPELL_CAST_TIMES}_REJECT`,
          (event, error) => {
            reject(error);
          }
        );
      });
    },
    searchDbcSpellRanges({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_DBC_SPELL_RANGES);
        ipcRenderer.on(SEARCH_DBC_SPELL_RANGES, (event, response) => {
          commit(SEARCH_DBC_SPELL_RANGES, response);
          resolve();
        });
        ipcRenderer.on(`${SEARCH_DBC_SPELL_RANGES}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    searchDbcTalents({ commit }) {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(SEARCH_DBC_TALENTS);
        ipcRenderer.on(SEARCH_DBC_TALENTS, (event, response) => {
          commit(SEARCH_DBC_TALENTS, response);
          resolve();
        });
        ipcRenderer.on(`${SEARCH_DBC_TALENTS}_REJECT`, (event, error) => {
          reject(error);
        });
      });
    },
    exportItemDbc() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(EXPORT_ITEM_DBC);
        ipcRenderer.on(EXPORT_ITEM_DBC, () => {
          resolve();
        });
        ipcRenderer.on(`${EXPORT_ITEM_DBC}_REJECT`, (error) => {
          reject(error);
        });
      });
    },
    exportSpellDbc() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(EXPORT_SPELL_DBC);
        ipcRenderer.on(EXPORT_SPELL_DBC, () => {
          resolve();
        });
        ipcRenderer.on(`${EXPORT_SPELL_DBC}_REJECT`, (error) => {
          reject(error);
        });
      });
    },
    exportScalingStatDistributionDbc() {
      return new Promise((resolve, reject) => {
        ipcRenderer.send(EXPORT_SCALING_STAT_DISTRIBUTION_DBC);
        ipcRenderer.on(EXPORT_SCALING_STAT_DISTRIBUTION_DBC, () => {
          resolve();
        });
        ipcRenderer.on(
          `${EXPORT_SCALING_STAT_DISTRIBUTION_DBC}_REJECT`,
          (error) => {
            reject(error);
          }
        );
      });
    },
  },
  mutations: {
    [SEARCH_DBC_FACTIONS](state, factions) {
      state.factions = factions;
    },
    [SEARCH_DBC_FACTION_TEMPLATES](state, factionTemplates) {
      state.factionTemplates = factionTemplates;
    },
    [SEARCH_DBC_CREATURE_SPELL_DATAS](state, creatureSpellDatas) {
      state.creatureSpellDatas = creatureSpellDatas;
    },
    [SEARCH_DBC_CREATURE_DISPLAY_INFOS](state, creatureDisplayInfos) {
      state.creatureDisplayInfos = creatureDisplayInfos;
    },
    [SEARCH_DBC_CREATURE_MODEL_DATAS](state, creatureModelDatas) {
      state.creatureModelDatas = creatureModelDatas;
    },
    [SEARCH_DBC_ITEM_DISPLAY_INFOS](state, itemDisplayInfos) {
      state.itemDisplayInfos = itemDisplayInfos;
    },
    [SEARCH_DBC_ITEMS](state, items) {
      state.items = items;
    },
    [SEARCH_DBC_SPELLS](state, spells) {
      if (Object.keys(state.spells).length === 0) {
        state.spells = spells;
      } else {
        state.spells.records = state.spells.records.concat(spells.records);
      }
    },
    [SEARCH_DBC_SPELL_DURATIONS](state, spellDurations) {
      state.spellDurations = spellDurations;
    },
    [SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS](state, scalingStatDistributions) {
      state.scalingStatDistributions = scalingStatDistributions;
    },
    [SEARCH_DBC_SCALING_STAT_VALUES](state, scalingStatValues) {
      state.scalingStatValues = scalingStatValues;
    },
    [SEARCH_DBC_ITEM_SETS](state, itemSets) {
      state.itemSets = itemSets;
    },
    [SEARCH_DBC_SPELL_ITEM_ENCHANTMENTS](state, spellItemEnchantments) {
      state.spellItemEnchantments = spellItemEnchantments;
    },
    [SEARCH_DBC_ITEM_RANDOM_PROPERTITIES](state, itemRandomProperties) {
      state.itemRandomProperties = itemRandomProperties;
    },
    [SEARCH_DBC_ITEM_RANDOM_SUFFIXES](state, itemRandomSuffixes) {
      state.itemRandomSuffixes = itemRandomSuffixes;
    },
    [SEARCH_DBC_SPELL_CAST_TIMES](state, spellCastTimes) {
      state.spellCastTimes = spellCastTimes;
    },
    [SEARCH_DBC_SPELL_RANGES](state, spellRanges) {
      state.spellRanges = spellRanges;
    },
    [SEARCH_DBC_TALENTS](state, talents) {
      state.talents = talents;
    },
  },
};
