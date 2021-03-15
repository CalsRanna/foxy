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
      <el-tab-pane label="基本信息" name="basic">
        <spell-tab-pane></spell-tab-pane>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import SpellTabPane from "@/views/Spell/components/SpellTabPane";

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
  },
};
</script>
