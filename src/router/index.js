import Vue from "vue";
import VueRouter from "vue-router";

import Dashboard from "@/views/Dashboard";
import CreatureTable from "@/views/CreatureTable";
import CreatureTemplateDetail from "@/views/CreatureTemplateDetail";
import GameObjectTable from "@/views/GameObjectTable";
import GameObjectDetail from "@/views/GameObjectDetail";
import ItemTable from "@/views/ItemTable";
import ItemTemplateDetail from "@/views/ItemTemplateDetail";
import QuestTable from "@/views/QuestTable";
import QuestDetail from "@/views/QuestDetail";
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
  { path: "/dashboard", component: Dashboard },
  { path: "/creature", component: CreatureTable },
  { path: "/creature/create", component: CreatureTemplateDetail },
  { path: "/creature/:id", component: CreatureTemplateDetail },
  { path: "/game-object", component: GameObjectTable },
  { path: "/game-object/create", component: GameObjectDetail },
  { path: "/game-object/:id", component: GameObjectDetail },
  { path: "/item", component: ItemTable },
  { path: "/item/create", component: ItemTemplateDetail },
  { path: "/item/:id", component: ItemTemplateDetail },
  { path: "/quest", component: QuestTable },
  { path: "/quest/create", component: QuestDetail },
  { path: "/quest/:id", component: QuestDetail },
  { path: "/spell", component: SpellTable },
  { path: "/spell/create", component: SpellDetail },
  { path: "/spell/:id", component: SpellDetail },
  { path: "/smart-script", component: SmartScriptTable },
  { path: "/smart-script/create", component: SmartScriptDetail },
  { path: "/smart-script/:id", component: SmartScriptDetail },
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
