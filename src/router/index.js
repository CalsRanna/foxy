import Vue from "vue";
import VueRouter from "vue-router";

import Login from "@/views/Login";
import Dashboard from '@/views/Dashboard';
import CreatureTable from "@/views/CreatureTable";
import CreatureTemplateDetail from "@/views/CreatureTemplateDetail";
import GameObjectTable from "@/views/GameObjectTable";
import ItemTable from "@/views/ItemTable";
import ItemTemplateDetail from "@/views/ItemTemplateDetail";
import QuestTable from "@/views/QuestTable";


Vue.use(VueRouter);

const routes = [
  { path: "/login", Component: Login },
  { path: "/dashboard", Component: Dashboard },
  { path: "/creature", component: CreatureTable },
  // { path: "/creature/create", component: CreatureTemplateDetail },
  { path: "/creature/:id", component: CreatureTemplateDetail },
  { path: "/game-object", component: GameObjectTable },
  { path: "/item", component: ItemTable },
  { path: "/item/:id", component: ItemTemplateDetail },
  { path: "/quest", component: QuestTable },
];

const router = new VueRouter({
  routes,
});

export default router;
