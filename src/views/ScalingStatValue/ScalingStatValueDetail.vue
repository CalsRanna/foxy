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
        <el-breadcrumb-item :to="{ path: '/scaling-stat-value' }">
          缩放属性值管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>缩放属性值详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="smart_script" style="margin-top: 16px">
      <el-tab-pane label="缩放属性值" name="smart_script" lazy>
        <scaling-stat-value-tab-pane></scaling-stat-value-tab-pane>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import ScalingStatValueTabPane from "@/views/ScalingStatValue/components/ScalingStatValueTabPane";

import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("scalingStatValue", ["scalingStatValue"]),
    localeName() {
      return this.scalingStatValue.ID;
    },
    localeDescription() {
      return null;
    },
  },
  components: {
    ScalingStatValueTabPane,
  },
};
</script>
