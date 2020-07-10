import Vue from "vue";
// import App from "./App.vue";
import Setting from "./Setting.vue";
import router from "./router";
import store from "./store";
import "./plugins/element.js";

Vue.config.productionTip = false;

new Vue({
  router,
  store,
  render: (h) => h(Setting),
}).$mount("#app");
