import {
  SEARCH_SPELLS,
  COUNT_SPELLS,
  PAGINATE_SPELLS,
  FIND_SPELL,
} from "@/constants";

export default {
  namespaced: true,
  state() {
    return {
      refresh: true,
      credential: {
        id: undefined,
        name: undefined,
      },
      pagination: {
        page: 1,
        size: 50,
        total: 0,
      },
      spells: [],
      spell: {},
    };
  },
  actions: {
    searchSpells({ commit, rootState }, payload) {
      return new Promise((resolve) => {
        let spells = [];
        if (rootState.dbc.spells.records == undefined) {
          commit(SEARCH_SPELLS, spells);
        } else {
          for (let spell of rootState.dbc.spells.records) {
            if (payload.id !== undefined || payload.name !== undefined) {
              if (
                payload.id == spell.id ||
                spell.nameLangZhCN.indexOf(payload.name) > -1
              ) {
                spells.push(spell);
              }
            } else {
              spells.push(spell);
            }
          }
          let start = (payload.page - 1) * 50;
          let end = payload.page * 50;
          if (end < spells.length) {
            commit(SEARCH_SPELLS, spells.slice(start, end));
          } else {
            commit(SEARCH_SPELLS, spells.slice(start));
          }
        }
        resolve();
      });
    },
    countSpells({ commit, rootState }, payload) {
      return new Promise((resolve) => {
        let spells = [];
        if (rootState.dbc.spells.records != undefined) {
          for (let spell of rootState.dbc.spells.records) {
            if (payload.id !== undefined || payload.name !== undefined) {
              if (
                payload.id == spell.id ||
                spell.nameLangZhCN.indexOf(payload.name) > -1
              ) {
                spells.push(spell);
              }
            } else {
              spells.push(spell);
            }
          }
        }
        commit(COUNT_SPELLS, spells.length);
        resolve();
      });
    },
    paginateSpells({ commit }, payload) {
      return new Promise((resolve) => {
        commit(PAGINATE_SPELLS, payload.page);
        resolve();
      });
    },
    storeSpell() {
      return new Promise((resolve) => {
        resolve();
      });
    },
    findSpell({ commit, rootState }, payload) {
      for (let spell of rootState.dbc.spells.records) {
        if (payload.id == spell.id) {
          commit(FIND_SPELL, spell);
        }
      }
    },
    updateSpell() {
      return new Promise((resolve) => {
        resolve();
      });
    },
    createSpell() {
      return new Promise((resolve) => {
        resolve();
      });
    },
    resetCredential({ commit }) {
      return new Promise((resolve) => {
        commit("RESET_CREDENTIAL_OF_SPELL");
        resolve();
      });
    },
  },
  mutations: {
    [SEARCH_SPELLS](state, spells) {
      state.spells = spells;
    },
    [COUNT_SPELLS](state, total) {
      state.pagination.total = total;
    },
    [PAGINATE_SPELLS](state, page) {
      state.pagination.page = page;
    },
    [FIND_SPELL](state, spell) {
      state.spell = spell;
    },
    RESET_CREDENTIAL_OF_SPELL(state) {
      state.credential = {
        id: undefined,
        name: undefined,
      };
    },
  },
};
