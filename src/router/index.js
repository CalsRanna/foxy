import Vue from "vue";
import VueRouter from "vue-router";

import SpellTable from "@/views/SpellTable";
import SpellDetail from "@/views/SpellDetail";
import SmartScriptTable from "@/views/SmartScriptTable";
import SmartScriptDetail from "@/views/SmartScriptDetail";
import Setting from "@/views/setting/Setting";
import Mysql from "@/views/setting/components/Mysql";
import Dbc from "@/views/setting/components/Dbc";
import Config from "@/views/setting/components/Config";
import Developer from "@/views/setting/components/Developer";

Vue.use(VueRouter);

const routes = [
  { path: "/", redirect: "/dashboard" },
  { path: "/dashboard", component: () => import("@/views/Dashboard") },
  {
    path: "/creature",
    component: () => import("@/views/Creature/CreatureTable"),
  },
  {
    path: "/creature/create",
    component: () => import("@/views/Creature/CreatureDetail"),
  },
  {
    path: "/creature/:id",
    component: () => import("@/views/Creature/CreatureDetail"),
  },
  { path: "/item", component: () => import("@/views/Item/ItemTable") },
  { path: "/item/create", component: () => import("@/views/Item/ItemDetail") },
  { path: "/item/:id", component: () => import("@/views/Item/ItemDetail") },
  {
    path: "/game-object",
    component: () => import("@/views/GameObject/GameObjectTable"),
  },
  {
    path: "/game-object/create",
    component: () => import("@/views/GameObject/GameObjectDetail"),
  },
  {
    path: "/game-object/:id",
    component: () => import("@/views/GameObject/GameObjectDetail"),
  },
  { path: "/quest", component: () => import("@/views/Quest/QuestTable") },
  {
    path: "/quest/create",
    component: () => import("@/views/Quest/QuestDetail"),
  },
  { path: "/quest/:id", component: () => import("@/views/Quest/QuestDetail") },
  {
    path: "/gossip-menu",
    component: () => import("@/views/GossipMenu/GossipMenuTable"),
  },
  {
    path: "/gossip-menu/create",
    component: () => import("@/views/GossipMenu/GossipMenuDetail"),
  },
  {
    path: "/gossip-menu/:id",
    component: () => import("@/views/GossipMenu/GossipMenuDetail"),
  },
  { path: "/spell", component: SpellTable },
  { path: "/spell/create", component: SpellDetail },
  { path: "/spell/:id", component: SpellDetail },
  { path: "/smart-script", component: SmartScriptTable },
  { path: "/smart-script/create", component: SmartScriptDetail },
  { path: "/smart-script/:id", component: SmartScriptDetail },
  { path: "/developer", component: () => import("@/views/DeveloperTable") },
  {
    path: "/setting",
    component: Setting,
    redirect: "/setting/mysql",
    children: [
      { path: "mysql", component: Mysql },
      { path: "dbc", component: Dbc },
      { path: "config", component: Config },
      { path: "developer", component: Developer },
    ],
  },
];

const router = new VueRouter({
  routes,
});

export default router;
