import {
  SEARCH_DBC_FACTIONS,
  SEARCH_DBC_FACTION_TEMPLATES,
  SEARCH_DBC_ITEM_DISPLAY_INFOS,
  SEARCH_DBC_SPELLS,
  SEARCH_DBC_SPELL_DURATIONS,
  SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS,
  SEARCH_DBC_SCALING_STAT_VALUES
} from "../constants";

const ipcRenderer = window.require("electron").ipcRenderer;

export default {
  namespaced: true,
  state: () => ({
    factions: {},
    factionTemplates: {},
    itemDisplayInfos: {},
    spells: {},
    spellDurations: {},
    scalingStatDistributions: {},
    scalingStatValues: {}
  }),
  getters: {
    itemIcons: state => {
      let icons = {};
      for (let record of state.itemDisplayInfos.records) {
        icons[record["id"]] = record["inventoryIcon1"];
      }
      return icons;
    }
  },
  actions: {
    searchDbcFactions({ commit }) {
      return new Promise(resolve => {
        ipcRenderer.send("SEARCH_DBC_FACTIONS");
        ipcRenderer.on("SEARCH_DBC_FACTIONS_REPLY", (event, response) => {
          commit(SEARCH_DBC_FACTIONS, response);
          resolve();
        });
      });
    },
    searchDbcFactionTemplates({ commit }) {
      return new Promise(resolve => {
        ipcRenderer.send("SEARCH_DBC_FACTION_TEMPLATES");
        ipcRenderer.on("SEARCH_DBC_FACTION_TEMPLATES_REPLY", (event, response) => {
          commit(SEARCH_DBC_FACTION_TEMPLATES, response);
          resolve();
        });
      });
    },
    searchDbcItemDisplayInfos({ commit }) {
      return new Promise(resolve => {
        ipcRenderer.send("SEARCH_DBC_ITEM_DISPLAY_INFOS");
        ipcRenderer.on("SEARCH_DBC_ITEM_DISPLAY_INFOS_REPLY", (event, response) => {
          commit(SEARCH_DBC_ITEM_DISPLAY_INFOS, response);
          resolve();
        });
      });
    },
    searchDbcSpells({ commit }) {
      return new Promise(resolve => {
        ipcRenderer.send("SEARCH_DBC_SPELLS");
        ipcRenderer.on("SEARCH_DBC_SPELLS_REPLY", (event, response) => {
          commit(SEARCH_DBC_SPELLS, response);
          resolve();
        });
      });
    },
    searchDbcSpellDurations({ commit }) {
      return new Promise(resolve => {
        ipcRenderer.send("SEARCH_DBC_SPELL_DURATIONS");
        ipcRenderer.on("SEARCH_DBC_SPELL_DURATIONS_REPLY", (event, response) => {
          commit(SEARCH_DBC_SPELL_DURATIONS, response);
          resolve();
        });
      });
    },
    searchDbcScalingStatDistributions({ commit }) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS);
        ipcRenderer.on(SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS, (event, response) => {
          commit(SEARCH_DBC_SCALING_STAT_DISTRIBUTIONS, response);
          resolve();
        });
      });
    },
    searchDbcScalingStatValues({ commit }) {
      return new Promise(resolve => {
        ipcRenderer.send(SEARCH_DBC_SCALING_STAT_VALUES);
        ipcRenderer.on(SEARCH_DBC_SCALING_STAT_VALUES, (event, response) => {
          commit(SEARCH_DBC_SCALING_STAT_VALUES, response);
          resolve();
        });
      });
    }
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
    }
  }
};
