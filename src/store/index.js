import Vue from "vue";
import Vuex from "vuex";

import global from "./global";
import dbc from "./dbc";
import creature from "./creature";
import gameObject from "./gameObject";
import item from "./item";
import quest from "./quest";
import spell from "./spell";
import smartScript from "./smartScript";
import setting from "./setting";
import gossipMenu from "./gossipMenu";

Vue.use(Vuex);

export default new Vuex.Store({
  modules: {
    global,
    dbc,
    creature,
    gameObject,
    item,
    quest,
    spell,
    smartScript,
    setting,
    gossipMenu,
  },
});
