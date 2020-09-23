import {
  SEARCH_DBC_FACTIONS,
  SEARCH_DBC_FACTION_TEMPLATES,
  SEARCH_DBC_ITEM_DISPLAY_INFOS,
  SEARCH_DBC_SPELLS
} from "./MUTATION_TYPES";
const ipcRenderer = window.require("electron").ipcRenderer;

export default {
  namespaced: true,
  state: () => ({
    factions: [],
    factionTemplates: [],
    itemDisplayInfos: [],
    spells: {}
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
      ipcRenderer.send("SEARCH_DBC_FACTIONS");
      ipcRenderer.on("SEARCH_DBC_FACTIONS_REPLY", (event, response) => {
        commit(SEARCH_DBC_FACTIONS, response);
      });
    },
    searchDbcFactionTemplates({ commit }) {
      ipcRenderer.send("SEARCH_DBC_FACTION_TEMPLATES");
      ipcRenderer.on("SEARCH_DBC_FACTION_TEMPLATES_REPLY", (event, response) => {
        commit(SEARCH_DBC_FACTION_TEMPLATES, response);
      });
    },
    searchDbcItemDisplayInfos({ commit }) {
      ipcRenderer.send("SEARCH_DBC_ITEM_DISPLAY_INFOS");
      ipcRenderer.on("SEARCH_DBC_ITEM_DISPLAY_INFOS_REPLY", (event, response) => {
        commit(SEARCH_DBC_ITEM_DISPLAY_INFOS, response);
      });
    },
    searchDbcSpells({ commit }) {
      ipcRenderer.send("SEARCH_DBC_SPELLS");
      ipcRenderer.on("SEARCH_DBC_SPELLS_REPLY", (event, response) => {
        commit(SEARCH_DBC_SPELLS, response);
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
      console.log(spells);
      if (Object.keys(state.spells).length === 0) {
        state.spells = spells;
      } else {
        state.spells.records = state.spells.records.concat(spells.records);
      }
    }
  }
};
