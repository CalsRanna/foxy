<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">
          首页
        </el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/scaling-stat-distribution' }">
          缩放属性分配管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>缩放属性分配详情</el-breadcrumb-item>
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
        <el-tab-pane label="缩放属性分配" name="smart_script" lazy>
          <scaling-stat-distribution-tab-pane></scaling-stat-distribution-tab-pane>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
import ScalingStatDistributionTabPane from "@/views/ScalingStatDistribution/components/ScalingStatDistributionTabPane";

import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("scalingStatDistribution", ["scalingStatDistribution"]),
    localeName() {
      return this.scalingStatDistribution.ID;
    },
    localeDescription() {
      return null;
    },
  },
  components: {
    ScalingStatDistributionTabPane,
  },
};
</script>
