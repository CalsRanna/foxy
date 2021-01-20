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
    <el-tabs
      value="item_template"
      @tab-click="switchover"
      style="margin-top: 16px"
    >
      <el-tab-pane label="物品模版" name="item_template">
        <item-template-tab-pane></item-template-tab-pane>
      </el-tab-pane>
      <el-tab-pane
        label="附魔模版"
        name="item_enchantment_template"
        :disabled="
          !(itemTemplate.RandomProperty != 0 || itemTemplate.RandomSuffix != 0)
        "
      >
        <item-enchantment-template-tab-pane></item-enchantment-template-tab-pane>
      </el-tab-pane>
      <el-tab-pane label="物品掉落" name="item_loot_template">
        <item-loot-template-tab-pane></item-loot-template-tab-pane>
      </el-tab-pane>
      <el-tab-pane
        label="分解掉落"
        name="disenchant_loot_template"
        :disabled="itemTemplate.DisenchantID == 0"
      >
        <disenchant-loot-template-tab-pane></disenchant-loot-template-tab-pane>
      </el-tab-pane>
      <el-tab-pane label="选矿掉落" name="prospecting_loot_template">
        <prospecting-loot-template-tab-pane></prospecting-loot-template-tab-pane>
      </el-tab-pane>
      <el-tab-pane label="研磨掉落" name="milling_loot_template">
        <milling-loot-template-tab-pane></milling-loot-template-tab-pane>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import ItemTemplateTabPane from "@/views/Item/components/ItemTemplateTabPane";

import {
  // colors,
  localeClasses,
  localeSubclasses,
  localeInventoryTypes,
  localeQualities,
  localeMaterials,
  localeStatTypes,
  bondings,
} from "../locales/item.js";

import { mapState, mapActions } from "vuex";
// import * as types from "@/store/MUTATION_TYPES";

import SpellSelector from "@/components/SpellSelector";

export default {
  data() {
    return {
      isCreating: true,
      loading: false,
      localeClasses: localeClasses,
      localeSubclasses: localeSubclasses,
      localeInventoryTypes: localeInventoryTypes,
      localeQualities: localeQualities,
      localeMaterials: localeMaterials,
      localeStatTypes: localeStatTypes,
      bondings: bondings,
      localeDialogVisible: false,
    };
  },
  computed: {
    ...mapState("item", [
      "itemTemplate",
      "itemTemplateLocales",
      "itemEnchantmentTemplates",
      "itemLootTemplates",
      "disenchantLootTemplates",
      "prospectingLootTemplates",
      "millingLootTemplates",
    ]),
    localeName() {
      if (this.itemTemplateLocales.length > 0) {
        let name = undefined;
        for (let itemTemplateLocale of this.itemTemplateLocales) {
          if (itemTemplateLocale.locale === "zhCN") {
            name = itemTemplateLocale.Name;
          }
        }
        return name !== undefined ? name : this.itemTemplate.name;
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
        return description !== undefined
          ? description
          : this.itemTemplate.description;
      } else {
        return this.itemTemplate.description;
      }
    },
  },
  methods: {
    ...mapActions("item", [
      "storeItemTemplate",
      "findItemTemplate",
      "updateItemTemplate",
      "createItemTemplate",
      "searchItemTemplateLocales",
      "storeItemTemplateLocales",
      "searchItemEnchantmentTemplates",
      "searchItemLootTemplates",
      "searchDisenchantTemplates",
      "searchProspectingTemplates",
      "searchMillingLootTemplates",
    ]),
    async switchover(tab) {
      this.loading = true;
      switch (tab.name) {
        case "item_enchantment_template":
          if (this.itemTemplate.RandomProperty != 0) {
            await this.searchItemEnchantmentTemplates({
              entry: this.itemTemplate.RandomProperty,
            });
          } else if (this.itemTemplate.RandomSuffix != 0) {
            await this.searchItemEnchantmentTemplates({
              entry: this.itemTemplate.RandomSuffix,
            });
          }
          break;
        case "item_loot_template":
          await this.searchItemLootTemplates({
            Entry: this.itemTemplate.entry,
          });
          break;
        case "disenchant_loot_template":
          await this.searchDisenchantTemplates({
            Entry: this.itemTemplate.DisenchantID,
          });
          break;
        case "prospecting_loot_template":
          await this.searchProspectingTemplates({
            Entry: this.itemTemplate.entry,
          });
          break;
        case "milling_loot_template":
          await this.searchMillingLootTemplates({
            Entry: this.itemTemplate.entry,
          });
          break;
        default:
          break;
      }
      this.loading = false;
    },
    showDialog() {
      this.localeDialogVisible = true;
    },
    closeDialog() {
      this.localeDialogVisible = false;
    },
    addItemTemplateLocale() {
      this.itemTemplateLocales.push({
        ID: this.itemTemplate.entry,
        VerifiedBuild: 0,
      });
    },
    deleteItemTemplateLocale(index) {
      this.itemTemplateLocales.splice(index, 1);
    },
    store(module) {
      this.loading = true;
      switch (module) {
        case "item_template":
          if (this.isCreating) {
            this.storeItemTemplate(this.itemTemplate);
          } else {
            this.updateItemTemplate(this.itemTemplate);
          }
          break;
        case "item_template_locales":
          this.storeItemTemplateLocales(this.itemTemplateLocales).then(() => {
            this.localeDialogVisible = false;
          });
          break;
        default:
          break;
      }
      this.loading = false;
    },
    cancel() {
      this.$router.go(-1);
    },
    async init() {
      this.loading = true;
      let path = this.$route.path;
      if (path === "/item/create") {
        await this.createItemTemplate();
      } else {
        this.isCreating = false;
        let id = this.$route.params.id;
        await Promise.all([
          this.findItemTemplate({ entry: id }),
          this.searchItemTemplateLocales({ id: id }),
        ]);
      }
      this.loading = false;
    },
  },
  created() {
    this.init();
  },
  components: {
    SpellSelector,
    ItemTemplateTabPane,
  },
};
</script>
