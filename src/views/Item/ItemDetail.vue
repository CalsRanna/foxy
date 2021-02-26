<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }"
          >首页</el-breadcrumb-item
        >
        <el-breadcrumb-item :to="{ path: '/item' }"
          >物品管理</el-breadcrumb-item
        >
        <el-breadcrumb-item>物品详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="item_template" style="margin-top: 16px">
      <el-tab-pane label="物品模版" name="item_template" lazy>
        <item-template-tab-pane></item-template-tab-pane>
      </el-tab-pane>
      <el-tab-pane
        label="附魔模版"
        name="item_enchantment_template"
        lazy
        :disabled="
          itemTemplate.RandomProperty == 0 && itemTemplate.RandomSuffix == 0
        "
      >
        <item-enchantment-template-tab-pane></item-enchantment-template-tab-pane>
      </el-tab-pane>
      <el-tab-pane
        label="物品掉落"
        name="item_loot_template"
        lazy
        :disabled="(itemTemplate.Flags & 4) == 0"
      >
        <item-loot-template-tab-pane></item-loot-template-tab-pane>
      </el-tab-pane>
      <el-tab-pane
        label="分解掉落"
        lazy
        name="disenchant_loot_template"
        :disabled="itemTemplate.DisenchantID == 0"
      >
        <disenchant-loot-template-tab-pane></disenchant-loot-template-tab-pane>
      </el-tab-pane>
      <el-tab-pane
        label="选矿掉落"
        name="prospecting_loot_template"
        lazy
        :disabled="(itemTemplate.Flags & 262144) == 0"
      >
        <prospecting-loot-template-tab-pane></prospecting-loot-template-tab-pane>
      </el-tab-pane>
      <el-tab-pane
        label="研磨掉落"
        name="milling_loot_template"
        lazy
        :disabled="(itemTemplate.Flags & 536870912) == 0"
      >
        <milling-loot-template-tab-pane></milling-loot-template-tab-pane>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import ItemTemplateTabPane from "@/views/Item/components/ItemTemplateTabPane";
import ItemEnchantmentTemplateTabPane from "@/views/Item/components/ItemEnchantmentTemplateTabPane";
import ItemLootTemplateTabPane from "@/views/Item/components/ItemLootTemplateTabPane";
import DisenchantLootTemplateTabPane from "@/views/Item/components/DisenchantLootTemplateTabPane";
import ProspectingLootTemplateTabPane from "@/views/Item/components/ProspectingLootTemplateTabPane";
import MillingLootTemplateTabPane from "@/views/Item/components/MillingLootTemplateTabPane";

import { mapState } from "vuex";

export default {
  data() {
    return {
      loading: false,
    };
  },
  computed: {
    ...mapState("itemTemplate", ["itemTemplate"]),
    ...mapState("itemTemplateLocale", ["itemTemplateLocales"]),
    localeName() {
      if (this.itemTemplateLocales.length > 0) {
        let name = undefined;
        for (let itemTemplateLocale of this.itemTemplateLocales) {
          if (itemTemplateLocale.locale === "zhCN") {
            name = itemTemplateLocale.Name;
          }
        }
        return name ? name : this.itemTemplate.name;
      } else {
        return this.itemTemplate.name;
      }
    },
    localeDescription() {
      if (this.itemTemplateLocales.length > 0) {
        let description = undefined;
        for (let itemTemplateLocale of this.itemTemplateLocales) {
          if (itemTemplateLocale.locale === "zhCN") {
            description = itemTemplateLocale.Description;
          }
        }
        return description ? description : this.itemTemplate.description;
      } else {
        return this.itemTemplate.description;
      }
    },
  },
  components: {
    ItemTemplateTabPane,
    ItemEnchantmentTemplateTabPane,
    ItemLootTemplateTabPane,
    DisenchantLootTemplateTabPane,
    ProspectingLootTemplateTabPane,
    MillingLootTemplateTabPane,
  },
};
</script>
