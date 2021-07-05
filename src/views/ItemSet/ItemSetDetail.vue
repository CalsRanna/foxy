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
        <el-breadcrumb-item :to="{ path: '/item-set' }">
          套装管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>套装详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="smart_script" style="margin-top: 16px">
      <el-tab-pane label="套装" name="smart_script" lazy>
        <item-set-tab-pane></item-set-tab-pane>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import ItemSetTabPane from "@/views/ItemSet/components/ItemSetTabPane";

import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("itemSet", ["itemSet"]),
    localeName() {
      return this.itemSet.Name_Lang_zhCN;
    },
    localeDescription() {
      return null;
    },
  },
  components: {
    ItemSetTabPane,
  },
};
</script>
