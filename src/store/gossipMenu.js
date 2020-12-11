import { SEARCH_GOSSIP_MENUS, COUNT_GOSSIP_MENUS, PAGINATE_GOSSIP_MENUS } from "./MUTATION_TYPES";
const ipcRenderer = window.require("electron").ipcRenderer;

export default {
  namespaced: true,
  state() {
    return {
      page: 1,
      total: 0,
      gossipMenus: []
    };
  },
  actions: {
    search({ commit }, payload) {
      ipcRenderer.on("SEARCH_GOSSIP_MENUS_REPLY", (event, response) => {
        commit(SEARCH_GOSSIP_MENUS, response);
      });
      ipcRenderer.send("SEARCH_GOSSIP_MENUS", payload);
    },
    count({ commit }, payload) {
      ipcRenderer.on("COUNT_GOSSIP_MENUS_REPLY", (event, response) => {
        commit(COUNT_GOSSIP_MENUS, response);
      });
      ipcRenderer.send("COUNT_GOSSIP_MENUS", payload);
    }
  },
  mutations: {
    [SEARCH_GOSSIP_MENUS](state, gossipMenus) {
      state.gossipMenus = gossipMenus;
    },
    [COUNT_GOSSIP_MENUS](state, total) {
      state.total = total;
    },
    [PAGINATE_GOSSIP_MENUS](state, page) {
      state.page = page;
    }
  }
};
