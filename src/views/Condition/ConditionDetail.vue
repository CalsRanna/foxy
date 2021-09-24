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
        <el-breadcrumb-item :to="{ path: '/condition' }">
          条件管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>条件详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3
        style="
          margin: 16px 0 0 0;
          white-space: nowrap;
          overflow: hidden;
          text-overflow: ellipsis;
        "
      >
        {{ localeText }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="condition" style="margin-top: 16px">
      <el-tab-pane label="条件" name="condition" lazy>
        <condition-tab-pane></condition-tab-pane>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import ConditionTabPane from "@/views/Condition/components/ConditionTabPane";

import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("condition", ["condition"]),
    localeText() {
      return null;
    },
    localeDescription() {
      return null;
    },
  },
  components: {
    ConditionTabPane,
  },
};
</script>
