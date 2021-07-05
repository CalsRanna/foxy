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
        <el-breadcrumb-item :to="{ path: '/reference-loot' }">
          关联掉落管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>关联掉落详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="reference-loot" style="margin-top: 16px">
      <el-tab-pane label="关联掉落" name="reference-loot" lazy>
        <reference-loot-template-tab-pane></reference-loot-template-tab-pane>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import ReferenceLootTemplateTabPane from "@/views/ReferenceLoot/components/ReferenceLootTemplateTabPane";

import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("referenceLootTemplate", ["referenceLootTemplate"]),
    localeName() {
      return this.referenceLootTemplate.Entry;
    },
    localeDescription() {
      return null;
    },
  },
  components: {
    ReferenceLootTemplateTabPane,
  },
};
</script>
