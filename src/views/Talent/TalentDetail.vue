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
        <el-breadcrumb-item :to="{ path: '/talent' }">
          天赋管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>天赋详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-tabs value="smart_script" style="margin-top: 16px">
        <el-tab-pane label="天赋" name="smart_script" lazy>
          <talent-tab-pane></talent-tab-pane>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
import TalentTabPane from "@/views/Talent/components/TalentTabPane";

import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("talent", ["talent"]),
    localeName() {
      return this.talent.Name_Lang_zhCN;
    },
    localeDescription() {
      return null;
    },
  },
  components: {
    TalentTabPane,
  },
};
</script>
