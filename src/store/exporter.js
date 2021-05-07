// const ipcRenderer = window.ipcRenderer;

import { UPDATE_CHECKED_DBCS } from "../constants";
import itemDbcRepository from "@/repository/itemDbc";

export default {
  namespaced: true,
  state: () => ({
    checkedDbcs: ["Item", "Spell", "ScalingStatDistribution"],
    preparation: [],
  }),
  actions: {
    updateCheckedDbcs({ commit }, payload) {
      commit(UPDATE_CHECKED_DBCS, payload.checkedDbcs);
    },
    searchItemDbc({ commit }) {
      return Promise((resolve, reject) => {
        itemDbcRepository
          .search()
          .then((rows) => {
            resolve(rows);
          })
          .catch((error) => {
            reject(error);
          });
      });
    },
    // searchSpellDbc({ commit }) {
    //   return Promise((resolve, reject) => {
    //     let queryBuilder = knex().select().from("foxy.dbc_item");

    //     commit("UPDATE_PREPARATION", {});
    //     queryBuilder
    //       .then((rows) => {
    //         resolve(rows);
    //       })
    //       .catch((error) => {
    //         reject(error);
    //       });
    //   });
    // },
    // searchScalingStatDistributionDbc({ commit }) {
    //   return Promise((resolve, reject) => {
    //     let queryBuilder = knex().select().from("foxy.dbc_item");

    //     commit("UPDATE_PREPARATION", {});
    //     queryBuilder
    //       .then((rows) => {
    //         resolve(rows);
    //       })
    //       .catch((error) => {
    //         reject(error);
    //       });
    //   });
    // },
  },
  mutations: {
    [UPDATE_CHECKED_DBCS](state, checkedDbcs) {
      state.checkedDbcs = checkedDbcs;
    },
  },
};
