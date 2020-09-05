import { UPDATE_MESSAGE, SET_ACTIVE } from "./MUTATION_TYPES";

export default {
  namespaced: true,
  state: () => ({
    debug: true,
    active: "dashboard",
    isAuth: false,
    message: {
      count: 0,
      type: undefined,
      title: undefined,
      content: undefined
    }
  }),
  mutations: {
    [UPDATE_MESSAGE](state, message) {
      state.message = {
        count: this.message.count + 1,
        type: message.type,
        title: message.title,
        content: message.contet
      };
    },
    [SET_ACTIVE](state, active) {
      state.active = active;
    }
  }
};
