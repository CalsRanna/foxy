import { SET_ACTIVE } from "../constants";

export default {
  namespaced: true,
  state: () => ({
    version: "0.1.6",
    active: "dashboard",
  }),
  actions: {
    setActive({ commit }, payload) {
      return new Promise((resolve) => {
        commit(SET_ACTIVE, payload);
        resolve();
      });
    },
  },
  mutations: {
    [SET_ACTIVE](state, active) {
      state.active = active;
    },
  },
};
