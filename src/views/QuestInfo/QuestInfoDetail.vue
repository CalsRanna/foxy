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
        <el-breadcrumb-item :to="{ path: '/quest-info' }">
          任务信息管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>任务信息详情</el-breadcrumb-item>
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
        <el-tab-pane label="任务信息" name="smart_script" lazy>
          <quest-info-tab-pane></quest-info-tab-pane>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
import QuestInfoTabPane from "@/views/QuestInfo/components/QuestInfoTabPane";

import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("questInfo", ["questInfo"]),
    localeName() {
      return this.questInfo.InfoName_Lang_zhCN;
    },
    localeDescription() {
      return null;
    },
  },
  components: {
    QuestInfoTabPane,
  },
};
</script>
