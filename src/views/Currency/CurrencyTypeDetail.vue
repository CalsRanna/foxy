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
        <el-breadcrumb-item :to="{ path: '/currency' }">
          货币管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>货币详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="currency-type" style="margin-top: 16px">
      <el-tab-pane label="货币" name="currency-type" lazy>
        <currency-type-tab-pane></currency-type-tab-pane>
      </el-tab-pane>
      <el-tab-pane label="分类" name="currency-category" lazy>
        <currency-category-tab-pane></currency-category-tab-pane>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import CurrencyTypeTabPane from "@/views/Currency/components/CurrencyTypeTabPane";
import CurrencyCategoryTabPane from "@/views/Currency/components/CurrencyCategoryTabPane";

import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("currencyType", ["currencyType"]),
    localeName() {
      return this.currencyType.ID;
    },
    localeDescription() {
      return null;
    },
  },
  components: {
    CurrencyTypeTabPane,
    CurrencyCategoryTabPane,
  },
};
</script>
