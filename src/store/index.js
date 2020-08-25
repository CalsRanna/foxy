import Vue from "vue";
import Vuex from "vuex";
import creatureTemplate from "./creature";
import itemTemplate from "./item";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    isAuth: false,
  },
  mutations: {},
  actions: {},
  modules: {
    creatureTemplate,
    itemTemplate,
  },
});
