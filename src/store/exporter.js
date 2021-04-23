// const ipcRenderer = window.ipcRenderer;

import { UPDATE_CHECKED_DBCS } from "../constants";

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
    // searchItemDbc({ commit }) {
    //   return Promise((resolve, reject) => {
    //     let queryBuilder = knex()
    //       .select()
    //       .from("foxy.dbc_item");

    //     commit("UPDATE_PREPARATION", {});
    //     console.log(queryBuilder);
    //     queryBuilder
    //       .then((rows) => {
    //         resolve(rows);
    //         // event.reply(
    //         //   `${EXPORT_ITEM_DBC}_PROGRESS`,
    //         //   `Writing ${path}/Item.dbc`
    //         // );
    //         // DBC.write(`${path}/Item.dbc`, rows)
    //         //   .then(() => {
    //         //     event.reply(EXPORT_ITEM_DBC);
    //         //   })
    //         //   .catch((error) => {
    //         //     event.reply(`${EXPORT_ITEM_DBC}_REJECT`, error);
    //         //     event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    //         //   });
    //       })
    //       .catch((error) => {
    //         reject(error);
    //         // event.reply(`${EXPORT_ITEM_DBC}_REJECT`, error);
    //         // event.reply(GLOBAL_MESSAGE_BOX, JSON.stringify(error));
    //       });
    //   });
    // },
    // searchSpellDbc({ commit }) {
    //   return Promise((resolve, reject) => {
    //     let queryBuilder = knex()
    //       .select()
    //       .from("foxy.dbc_item");

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
    //     let queryBuilder = knex()
    //       .select()
    //       .from("foxy.dbc_item");

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
