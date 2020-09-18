import { SET_SETTING_ACTIVE } from "./MUTATION_TYPES";

export default {
  namespaced: true,
  state() {
    return {
      active: "mysql"
    };
  },
  mutations: {
    [SET_SETTING_ACTIVE](state, active) {
      state.active = active;
    }
  }
};
