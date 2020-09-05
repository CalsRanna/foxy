import Vue from "vue";
import Vuex from "vuex";
import global from "./global";
import creatureTemplate from "./creature";
import itemTemplate from "./item";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    isAuth: false,
    message: {
      count: 0,
      type: "info",
      title: "",
      content: ""
    }
  },
  mutations: {},
  actions: {},
  modules: {
    global,
    creatureTemplate,
    itemTemplate
  }
});
