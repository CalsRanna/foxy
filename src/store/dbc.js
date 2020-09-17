import { SEARCH_DBC_FACTIONS, SEARCH_DBC_FACTION_TEMPLATES, SEARCH_DBC_ITEM_DISPLAY_INFOS } from "./MUTATION_TYPES";
const ipcRenderer = window.require("electron").ipcRenderer;

export default {
  namespaced: true,
  state: () => ({
    factions: [],
    factionTemplates: [],
    itemDisplayInfos: []
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
      ipcRenderer.on("SEARCH_DBC_FACTIONS_REPLY", (event, response) => {
        commit(SEARCH_DBC_FACTIONS, response);
        console.log(response);
      });
      ipcRenderer.send("SEARCH_DBC_FACTIONS");
    },
    searchDbcFactionTemplates({ commit }) {
      ipcRenderer.on("SEARCH_DBC_FACTION_TEMPLATES_REPLY", (event, response) => {
        commit(SEARCH_DBC_FACTION_TEMPLATES, response);
        console.log(response);
      });
      ipcRenderer.send("SEARCH_DBC_FACTION_TEMPLATES");
    },
    searchDbcItemDisplayInfos({ commit }) {
      ipcRenderer.on("SEARCH_DBC_ITEM_DISPLAY_INFOS_REPLY", (event, response) => {
        commit(SEARCH_DBC_ITEM_DISPLAY_INFOS, response);
        console.log(response);
      });
      ipcRenderer.send("SEARCH_DBC_ITEM_DISPLAY_INFOS");
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
    }
  }
};
