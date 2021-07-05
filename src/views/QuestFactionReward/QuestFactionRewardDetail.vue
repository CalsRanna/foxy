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
        <el-breadcrumb-item :to="{ path: '/quest-faction-reward' }">
          任务声望管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>任务声望详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="smart_script" style="margin-top: 16px">
      <el-tab-pane label="任务声望" name="smart_script" lazy>
        <quest-faction-reward-tab-pane></quest-faction-reward-tab-pane>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import QuestFactionRewardTabPane from "@/views/QuestFactionReward/components/QuestFactionRewardTabPane";

import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("questFactionReward", ["questFactionReward"]),
    localeName() {
      return null;
    },
    localeDescription() {
      return null;
    },
  },
  components: {
    QuestFactionRewardTabPane,
  },
};
</script>
