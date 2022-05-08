import { SET_ACTIVE } from "../constants";

export default {
  namespaced: true,
  state: () => ({
    version: "0.3.1",
    clientHeight: 768,
    active: "dashboard",
    error: {
      timestamp: 0,
      title: "",
      content: "",
    },
  }),
  actions: {
    setClientHeight({ commit }, payload) {
      return new Promise((resolve) => {
        commit("SET_CLIENT_HEIGHT", payload);
        resolve();
      });
    },
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
    SET_CLIENT_HEIGHT(state, clientHeight) {
      state.clientHeight = clientHeight;
    },
    [SET_ACTIVE](state, active) {
      state.active = active;
    },
    UPDATE_ERROR(state, error) {
      state.error = error;
    },
  },
};
