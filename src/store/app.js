import { SET_ACTIVE } from "../constants";

export default {
  namespaced: true,
  state: () => ({
    version: "0.1.7",
    active: "dashboard",
    error: {
      timestamp: 0,
      title: "",
      content: "",
    },
  }),
  actions: {
    setActive({ commit }, payload) {
      return new Promise((resolve) => {
        commit(SET_ACTIVE, payload);
        resolve();
      });
    },
    updateError({ commit }, payload) {
      return new Promise((resolve) => {
        commit("UPDATE_ERROR", payload);
        resolve();
      });
    },
  },
  mutations: {
    [SET_ACTIVE](state, active) {
      state.active = active;
    },
    UPDATE_ERROR(state, error) {
      state.error = error;
    },
  },
};
