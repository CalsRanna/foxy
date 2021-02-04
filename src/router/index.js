import Vue from "vue";
import VueRouter from "vue-router";

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
  {
    path: "/smart-script",
    component: () => import("@/views/SmartScript/SmartScriptTable"),
  },
  {
    path: "/smart-script/create",
    component: () => import("@/views/SmartScript/SmartScriptDetail"),
  },
  {
    path: "/smart-script/:id",
    component: () => import("@/views/SmartScript/SmartScriptDetail"),
  },
  { path: "/spell", component: () => import("@/views/Spell/SpellTable") },
  {
    path: "/spell/create",
    component: () => import("@/views/Spell/SpellDetail"),
  },
  { path: "/spell/:id", component: () => import("@/views/Spell/SpellDetail") },
  {
    path: "/setting",
    component: () => import("@/views/Setting/Setting"),
    redirect: "/setting/mysql",
    children: [
      {
        path: "mysql",
        component: () => import("@/views/Setting/components/Mysql"),
      },
      {
        path: "dbc",
        component: () => import("@/views/Setting/components/Dbc"),
      },
      {
        path: "developer",
        component: () => import("@/views/Setting/components/Developer"),
      },
    ],
  },
];

const router = new VueRouter({
  routes,
});

export default router;
