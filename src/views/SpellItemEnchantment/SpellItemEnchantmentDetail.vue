<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">
          首页
        </el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/advance' }">
          高级
        </el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/spell-item-enchantment' }">
          附魔技能管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>附魔技能详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="spell_item_enchantment" style="margin-top: 16px">
      <el-tab-pane label="附魔技能" name="spell_item_enchantment" lazy>
        <spell-item-enchantment-tab-pane></spell-item-enchantment-tab-pane>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import SpellItemEnchantmentTabPane from "@/views/SpellItemEnchantment/components/SpellItemEnchantmentTabPane";

import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("spellItemEnchantment", ["spellItemEnchantment"]),
    localeName() {
      return this.spellItemEnchantment.Name_Lang_zhCN;
    },
    localeDescription() {
      return null;
    },
  },
  components: {
    SpellItemEnchantmentTabPane,
  },
};
</script>
