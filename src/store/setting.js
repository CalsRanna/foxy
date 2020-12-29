import { SET_SETTING_ACTIVE } from "../constants";

export default {
  namespaced: true,
  state() {
    return {
      active: "mysql"
    };
  },
  actions: {
    setSettingActive({commit}, payload) {
      return new Promise(resolve => {
        commit(SET_SETTING_ACTIVE, payload);
        resolve();
      })
    }
  },
  mutations: {
    [SET_SETTING_ACTIVE](state, active) {
      state.active = active;
    }
  }
};
