import Vue from "vue";
import VueRouter from "vue-router";

import Login from "@/views/Login";
import Dashboard from "@/views/Dashboard";
import CreatureTable from "@/views/CreatureTable";
import CreatureTemplateDetail from "@/views/CreatureTemplateDetail";
import GameObjectTable from "@/views/GameObjectTable";
import ItemTable from "@/views/ItemTable";
import ItemTemplateDetail from "@/views/ItemTemplateDetail";
import QuestTable from "@/views/QuestTable";
import SpellTable from "@/views/SpellTable";
import SmartScriptTable from "@/views/SmartScriptTable";
import Setting from "@/views/setting/Setting";
import Mysql from "@/views/setting/components/Mysql";
import Dbc from "@/views/setting/components/Dbc";
import Config from "@/views/setting/components/Config";
import Developer from "@/views/setting/components/Developer";

Vue.use(VueRouter);

const routes = [
  { path: "/", redirect: "/dashboard" },
  { path: "/login", component: Login },
  { path: "/dashboard", component: Dashboard },
  { path: "/creature", component: CreatureTable },
  { path: "/creature/:id", component: CreatureTemplateDetail },
  { path: "/game-object", component: GameObjectTable },
  { path: "/item", component: ItemTable },
  { path: "/item/:id", component: ItemTemplateDetail },
  { path: "/quest", component: QuestTable },
  { path: "/spell", component: SpellTable },
  { path: "/smart-script", component: SmartScriptTable },
  {
    path: "/setting",
    component: Setting,
    redirect: "/setting/mysql",
    children: [
      { path: "mysql", component: Mysql },
      { path: "dbc", component: Dbc },
      { path: "config", component: Config },
      { path: "developer", component: Developer }
    ]
  }
];

const router = new VueRouter({
  routes
});

export default router;
