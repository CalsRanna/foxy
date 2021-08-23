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
        <el-breadcrumb-item :to="{ path: '/item-extended-cost' }">
          扩展价格管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>扩展价格详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="item_extended_cost" style="margin-top: 16px">
      <el-tab-pane label="扩展价格" name="item_extended_cost" lazy>
        <item-extended-cost-tab-pane></item-extended-cost-tab-pane>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import ItemExtendedCostTabPane from "@/views/ItemExtendedCost/components/ItemExtendedCostTabPane";

import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("itemExtendedCost", ["itemExtendedCost"]),
    localeName() {
      return this.itemExtendedCost.ID;
    },
    localeDescription() {
      return null;
    },
  },
  components: {
    ItemExtendedCostTabPane,
  },
};
</script>
