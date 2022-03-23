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
        <el-breadcrumb-item :to="{ path: '/gem-property' }">
          宝石属性管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>宝石属性详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="gem_property" style="margin-top: 16px">
      <el-tab-pane label="宝石属性" name="gem_property" lazy>
        <gem-property-tab-pane />
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import GemPropertyTabPane from "@/views/GemProperty/components/GemPropertyTabPane";

import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("gemProperty", ["gemProperty"]),
    localeName() {
      return this.gemProperty.Name;
    },
    localeDescription() {
      return null;
    },
  },
  components: {
    GemPropertyTabPane,
  },
};
</script>
