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
        <el-breadcrumb-item :to="{ path: '/talent-tab' }">
          天赋页管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>天赋页详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="talent-tab" style="margin-top: 16px">
      <el-tab-pane label="天赋页" name="talent-tab" lazy>
        <talent-tab-tab-pane></talent-tab-tab-pane>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import TalentTabTabPane from "@/views/TalentTab/components/TalentTabTabPane";

import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("talentTab", ["talentTab"]),
    localeName() {
      return this.talentTab.Name_Lang_zhCN;
    },
    localeDescription() {
      return null;
    },
  },
  components: {
    TalentTabTabPane,
  },
};
</script>
