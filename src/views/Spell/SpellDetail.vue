<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">
          首页
        </el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/spell' }">
          技能管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>技能详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="basic" style="margin-top: 16px">
      <el-tab-pane label="基本信息" name="basic" lazy>
        <spell-tab-pane></spell-tab-pane>
      </el-tab-pane>
      <el-tab-pane label="奖励系数" name="spell_bonus_data" lazy>
        <spell-bonus-data-tab-pane></spell-bonus-data-tab-pane>
      </el-tab-pane>
      <el-tab-pane label="自定义属性" name="spell_custom_attr" lazy>
        <spell-custom-attr-tab-pane></spell-custom-attr-tab-pane>
      </el-tab-pane>
      <el-tab-pane label="区域技能" name="spell_area" lazy>
        <spell-area-tab-pane></spell-area-tab-pane>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import SpellTabPane from "@/views/Spell/components/SpellTabPane";
import SpellBonusDataTabPane from "@/views/Spell/components/SpellBonusDataTabPane";
import SpellCustomAttrTabPane from "@/views/Spell/components/SpellCustomAttrTabPane";
import SpellAreaTabPane from "@/views/Spell/components/SpellAreaTabPane";

import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("spell", ["spell"]),
    localeName() {
      return this.spell.Name_Lang_zhCN;
    },
    localeDescription() {
      return this.spell.Description_Lang_zhCN;
    },
  },
  components: {
    SpellTabPane,
    SpellBonusDataTabPane,
    SpellCustomAttrTabPane,
    SpellAreaTabPane,
  },
};
</script>
