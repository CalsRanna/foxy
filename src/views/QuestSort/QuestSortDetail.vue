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
        <el-breadcrumb-item :to="{ path: '/quest-sort' }">
          任务排序管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>任务排序详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="quest-sort" style="margin-top: 16px">
      <el-tab-pane label="任务排序" name="quest-sort" lazy>
        <quest-sort-tab-pane></quest-sort-tab-pane>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import QuestSortTabPane from "@/views/QuestSort/components/QuestSortTabPane";

import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("questSort", ["questSort"]),
    localeName() {
      return this.questSort.SortName_Lang_zhCN;
    },
    localeDescription() {
      return null;
    },
  },
  components: {
    QuestSortTabPane,
  },
};
</script>
