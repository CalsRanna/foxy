import Vue from 'vue'
import Vuex from 'vuex'
import creatureTemplate from './creature';

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    isAuth:false
  },
  mutations: {
  },
  actions: {
  },
  modules: {
    creatureTemplate,
  }
})
