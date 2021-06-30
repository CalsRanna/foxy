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
        <el-breadcrumb-item :to="{ path: '/area-table' }">
          区域管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>区域详情</el-breadcrumb-item>
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
        <el-tab-pane label="区域" name="smart_script" lazy>
          <area-table-tab-pane></area-table-tab-pane>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
import AreaTableTabPane from "@/views/AreaTable/components/AreaTableTabPane";

import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("areaTable", ["areaTable"]),
    localeName() {
      return this.areaTable.AreaName_Lang_zhCN;
    },
    localeDescription() {
      return null;
    },
  },
  components: {
    AreaTableTabPane,
  },
};
</script>
