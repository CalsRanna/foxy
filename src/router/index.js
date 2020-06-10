import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../views/Home.vue";
import CreatureTable from '@/views/CreatureTable';
import CreatureTemplateDetail from '@/views/CreatureTemplateDetail';

Vue.use(VueRouter);

const routes = [
  {
    path: "/",
    name: "Home",
    component: Home,
  },
  {
    path: "/dashboard",
    Component: Home,
  },
  {
    path: "/about",
    name: "About",
    // route level code-splitting
    // this generates a separate chunk (about.[hash].js) for this route
    // which is lazy-loaded when the route is visited.
    component: () =>
      import(/* webpackChunkName: "about" */ "../views/About.vue"),
  },
  { path: "/creature", component: CreatureTable },
  { path: "/creature/:id", component: CreatureTemplateDetail },
];

const router = new VueRouter({
  routes,
});

export default router;
