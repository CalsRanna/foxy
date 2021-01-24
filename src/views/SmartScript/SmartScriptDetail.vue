<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">
          首页
        </el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/smart-script' }">
          内建脚本管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>内建脚本详情</el-breadcrumb-item>
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
        <el-tab-pane label="脚本模板" name="smart_script" lazy>
          <smart-script-tab-pane></smart-script-tab-pane>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
import SmartScriptTabPane from "@/views/SmartScript/components/SmartScriptTabPane";

import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("smartScript", ["smartScript"]),
    localeName() {
      return this.smartScript.comment;
    },
    localeDescription() {
      return null;
    },
  },
  components: {
    SmartScriptTabPane,
  },
};
</script>
