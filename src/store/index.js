import Vue from "vue";
import Vuex from "vuex";

import global from "./global";
import creature from "./creature";
import gameObject from "./gameObject";
import item from "./item";
import quest from "./quest";
import smartScript from "./smartScript";

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    global,
    creature,
    gameObject,
    item,
    quest,
    smartScript
  }
});
