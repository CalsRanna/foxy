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
      page: 1,
      total: 0,
      spells: [],
      spell: {},
    };
  },
  actions: {
    search({ commit, rootState }, payload) {
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
    count({ commit, rootState }, payload) {
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
    find({ commit, rootState }, payload) {
      for (let spell of rootState.dbc.spells.records) {
        if (payload.id == spell.id) {
          commit(FIND_SPELL, spell);
        }
      }
    },
  },
  mutations: {
    [SEARCH_SPELLS](state, spells) {
      state.spells = spells;
    },
    [COUNT_SPELLS](state, total) {
      state.total = total;
    },
    [PAGINATE_SPELLS](state, page) {
      state.page = page;
    },
    [FIND_SPELL](state, spell) {
      state.spell = spell;
    },
  },
};
