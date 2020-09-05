import { UPDATE_MESSAGE } from "./MUTATION_TYPES";

export default {
  state: () => ({
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
      this.message = {
        count: this.message.count + 1,
        type: message.type,
        title: message.title,
        content: message.contet
      };
    }
  }
};
