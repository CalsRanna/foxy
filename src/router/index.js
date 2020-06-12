import Vue from "vue";
import VueRouter from "vue-router";
import Home from "../views/Home.vue";
import CreatureTable from "@/views/CreatureTable";
import CreatureTemplateDetail from "@/views/CreatureTemplateDetail";
import GameObjectTable from "@/views/GameObjectTable";
import ItemTable from "@/views/ItemTable";
import ItemTemplateDetail from "@/views/ItemTemplateDetail";
import QuestTable from "@/views/QuestTable";
import GossipTable from "@/views/GossipTable";

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
  { path: "/creature", component: CreatureTable },
  { path: "/creature/:id", component: CreatureTemplateDetail },
  { path: "/game-object", component: GameObjectTable },
  { path: "/item", component: ItemTable },
  { path: "/item/:id", component: ItemTemplateDetail },
  { path: "/quest", component: QuestTable },
  { path: "/gossip", component: GossipTable },
];

const router = new VueRouter({
  routes,
});

export default router;
