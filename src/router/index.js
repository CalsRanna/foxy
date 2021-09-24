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
  { path: "/advance", component: () => import("@/views/Advance/Advance") },
  {
    path: "/setting",
    component: () => import("@/views/Setting/Setting"),
    redirect: "/setting/basic",
    children: [
      {
        path: "basic",
        component: () => import("@/views/Setting/components/Basic"),
      },
      {
        path: "developer",
        component: () => import("@/views/Setting/components/Developer"),
      },
      {
        path: "changelog",
        component: () => import("@/views/Setting/components/Changelog"),
      },
    ],
  },
  {
    path: "/condition",
    component: () => import("@/views/Condition/ConditionTable"),
  },
  {
    path: "/condition/create",
    component: () => import("@/views/Condition/ConditionDetail"),
  },
  {
    path: "/condition/:id",
    component: () => import("@/views/Condition/ConditionDetail"),
  },
  {
    path: "/scaling-stat-distribution",
    component: () =>
      import("@/views/ScalingStatDistribution/ScalingStatDistributionTable"),
  },
  {
    path: "/scaling-stat-distribution/create",
    component: () =>
      import("@/views/ScalingStatDistribution/ScalingStatDistributionDetail"),
  },
  {
    path: "/scaling-stat-distribution/:id",
    component: () =>
      import("@/views/ScalingStatDistribution/ScalingStatDistributionDetail"),
  },
  {
    path: "/scaling-stat-value",
    component: () => import("@/views/ScalingStatValue/ScalingStatValueTable"),
  },
  {
    path: "/scaling-stat-value/create",
    component: () => import("@/views/ScalingStatValue/ScalingStatValueDetail"),
  },
  {
    path: "/scaling-stat-value/:id",
    component: () => import("@/views/ScalingStatValue/ScalingStatValueDetail"),
  },
  {
    path: "/spell-item-enchantment",
    component: () =>
      import("@/views/SpellItemEnchantment/SpellItemEnchantmentTable"),
  },
  {
    path: "/spell-item-enchantment/create",
    component: () =>
      import("@/views/SpellItemEnchantment/SpellItemEnchantmentDetail"),
  },
  {
    path: "/spell-item-enchantment/:id",
    component: () =>
      import("@/views/SpellItemEnchantment/SpellItemEnchantmentDetail"),
  },
  {
    path: "/item-set",
    component: () => import("@/views/ItemSet/ItemSetTable"),
  },
  {
    path: "/item-set/create",
    component: () => import("@/views/ItemSet/ItemSetDetail"),
  },
  {
    path: "/item-set/:id",
    component: () => import("@/views/ItemSet/ItemSetDetail"),
  },
  {
    path: "/item-extended-cost",
    component: () => import("@/views/ItemExtendedCost/ItemExtendedCostTable"),
  },
  {
    path: "/item-extended-cost/create",
    component: () => import("@/views/ItemExtendedCost/ItemExtendedCostDetail"),
  },
  {
    path: "/item-extended-cost/:id",
    component: () => import("@/views/ItemExtendedCost/ItemExtendedCostDetail"),
  },
  {
    path: "/page-text",
    component: () => import("@/views/PageText/PageTextTable"),
  },
  {
    path: "/page-text/create",
    component: () => import("@/views/PageText/PageTextDetail"),
  },
  {
    path: "/page-text/:id",
    component: () => import("@/views/PageText/PageTextDetail"),
  },
  {
    path: "/talent",
    component: () => import("@/views/Talent/TalentTable"),
  },
  {
    path: "/talent/create",
    component: () => import("@/views/Talent/TalentDetail"),
  },
  {
    path: "/talent/:id",
    component: () => import("@/views/Talent/TalentDetail"),
  },
  {
    path: "/talent-tab",
    component: () => import("@/views/TalentTab/TalentTabTable"),
  },
  {
    path: "/talent-tab/create",
    component: () => import("@/views/TalentTab/TalentTabDetail"),
  },
  {
    path: "/talent-tab/:id",
    component: () => import("@/views/TalentTab/TalentTabDetail"),
  },
  {
    path: "/reference-loot",
    component: () => import("@/views/ReferenceLoot/ReferenceLootTemplateTable"),
  },
  {
    path: "/reference-loot/create",
    component: () =>
      import("@/views/ReferenceLoot/ReferenceLootTemplateDetail"),
  },
  {
    path: "/reference-loot/:id",
    component: () =>
      import("@/views/ReferenceLoot/ReferenceLootTemplateDetail"),
  },
  {
    path: "/emote-text",
    component: () => import("@/views/EmoteText/EmoteTextTable"),
  },
  {
    path: "/emote-text/create",
    component: () => import("@/views/EmoteText/EmoteTextDetail"),
  },
  {
    path: "/emote-text/:id",
    component: () => import("@/views/EmoteText/EmoteTextDetail"),
  },
  {
    path: "/quest-faction-reward",
    component: () =>
      import("@/views/QuestFactionReward/QuestFactionRewardTable"),
  },
  {
    path: "/quest-faction-reward/create",
    component: () =>
      import("@/views/QuestFactionReward/QuestFactionRewardDetail"),
  },
  {
    path: "/quest-faction-reward/:id",
    component: () =>
      import("@/views/QuestFactionReward/QuestFactionRewardDetail"),
  },
  {
    path: "/quest-info",
    component: () => import("@/views/QuestInfo/QuestInfoTable"),
  },
  {
    path: "/quest-info/create",
    component: () => import("@/views/QuestInfo/QuestInfoDetail"),
  },
  {
    path: "/quest-info/:id",
    component: () => import("@/views/QuestInfo/QuestInfoDetail"),
  },
  {
    path: "/achievement",
    component: () => import("@/views/Achievement/AchievementTable"),
  },
  {
    path: "/achievement/create",
    component: () => import("@/views/Achievement/AchievementDetail"),
  },
  {
    path: "/achievement/:id",
    component: () => import("@/views/Achievement/AchievementDetail"),
  },
  {
    path: "/area-table",
    component: () => import("@/views/AreaTable/AreaTableTable"),
  },
  {
    path: "/area-table/create",
    component: () => import("@/views/AreaTable/AreaTableDetail"),
  },
  {
    path: "/area-table/:id",
    component: () => import("@/views/AreaTable/AreaTableDetail"),
  },
  {
    path: "/currency",
    component: () => import("@/views/Currency/CurrencyTypeTable"),
  },
  {
    path: "/currency/create",
    component: () => import("@/views/Currency/CurrencyTypeDetail"),
  },
  {
    path: "/currency/:id",
    component: () => import("@/views/Currency/CurrencyTypeDetail"),
  },
  {
    path: "/quest-sort",
    component: () => import("@/views/QuestSort/QuestSortTable"),
  },
  {
    path: "/quest-sort/create",
    component: () => import("@/views/QuestSort/QuestSortDetail"),
  },
  {
    path: "/quest-sort/:id",
    component: () => import("@/views/QuestSort/QuestSortDetail"),
  },
];

const router = new VueRouter({
  routes,
});

export default router;
