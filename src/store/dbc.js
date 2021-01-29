const ipcRenderer = window.require("electron").ipcRenderer;

import {
  SEARCH_DBC_FACTIONS,
  SEARCH_DBC_FACTION_TEMPLATES,
  SEARCH_DBC_ITEM_DISPLAY_INFOS,
  SEARCH_DBC_ITEMS,
  SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS,
  SEARCH_DBC_SCALING_STAT_VALUES,
  SEARCH_DBC_SPELLS,
  EXPORT_SPELL_DBC,
  SEARCH_DBC_SPELL_DURATIONS,
} from "../constants";

export default {
  namespaced: true,
  state: () => ({
    factions: {},
    factionTemplates: {},
    items: {},
    itemDisplayInfos: {},
    spells: {},
    spellDurations: {},
    scalingStatDistributions: {},
    scalingStatValues: {},
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
      return new Promise((resolve) => {
        ipcRenderer.send(SEARCH_DBC_FACTIONS);
        ipcRenderer.on(SEARCH_DBC_FACTIONS, (event, response) => {
          commit(SEARCH_DBC_FACTIONS, response);
          resolve();
        });
      });
    },
    searchDbcFactionTemplates({ commit }) {
      return new Promise((resolve) => {
        ipcRenderer.send(SEARCH_DBC_FACTION_TEMPLATES);
        ipcRenderer.on(SEARCH_DBC_FACTION_TEMPLATES, (event, response) => {
          commit(SEARCH_DBC_FACTION_TEMPLATES, response);
          resolve();
        });
      });
    },
    searchDbcItems({ commit }) {
      return new Promise((resolve) => {
        ipcRenderer.send(SEARCH_DBC_ITEMS);
        ipcRenderer.on(SEARCH_DBC_ITEMS, (event, response) => {
          commit(SEARCH_DBC_ITEMS, response);
          resolve();
        });
      });
    },
    searchDbcItemDisplayInfos({ commit }) {
      return new Promise((resolve) => {
        ipcRenderer.send(SEARCH_DBC_ITEM_DISPLAY_INFOS);
        ipcRenderer.on(SEARCH_DBC_ITEM_DISPLAY_INFOS, (event, response) => {
          commit(SEARCH_DBC_ITEM_DISPLAY_INFOS, response);
          resolve();
        });
      });
    },
    searchDbcSpells({ commit }) {
      return new Promise((resolve) => {
        ipcRenderer.send(SEARCH_DBC_SPELLS);
        // ipcRenderer.on(SEARCH_DBC_SPELLS, (event, response) => {
        //   commit(SEARCH_DBC_SPELLS, response);
        //   resolve();
        // });
        ipcRenderer.on(SEARCH_DBC_SPELLS, () => {
          commit(SEARCH_DBC_SPELLS, {});
          resolve();
        });
      });
    },
    searchDbcSpellDurations({ commit }) {
      return new Promise((resolve) => {
        ipcRenderer.send(SEARCH_DBC_SPELL_DURATIONS);
        ipcRenderer.on(SEARCH_DBC_SPELL_DURATIONS, (event, response) => {
          commit(SEARCH_DBC_SPELL_DURATIONS, response);
          resolve();
        });
      });
    },
    searchDbcScalingStatDistributions({ commit }) {
      return new Promise((resolve) => {
        ipcRenderer.send(SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS);
        ipcRenderer.on(
          SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS,
          (event, response) => {
            commit(SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS, response);
            resolve();
          }
        );
      });
    },
    searchDbcScalingStatValues({ commit }) {
      return new Promise((resolve) => {
        ipcRenderer.send(SEARCH_DBC_SCALING_STAT_VALUES);
        ipcRenderer.on(SEARCH_DBC_SCALING_STAT_VALUES, (event, response) => {
          commit(SEARCH_DBC_SCALING_STAT_VALUES, response);
          resolve();
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
  },
  mutations: {
    [SEARCH_DBC_FACTIONS](state, factions) {
      state.factions = factions;
    },
    [SEARCH_DBC_FACTION_TEMPLATES](state, factionTemplates) {
      state.factionTemplates = factionTemplates;
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
  },
};
