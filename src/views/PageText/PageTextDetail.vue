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
        <el-breadcrumb-item :to="{ path: '/page-text' }">
          页面文本管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>页面文本详情</el-breadcrumb-item>
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
    <el-tabs value="smart_script" style="margin-top: 16px">
      <el-tab-pane label="页面文本" name="smart_script" lazy>
        <page-text-tab-pane></page-text-tab-pane>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import PageTextTabPane from "@/views/PageText/components/PageTextTabPane";

import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("pageText", ["pageText"]),
    ...mapState("pageTextLocale", ["pageTextLocales"]),
    localeText() {
      if (this.pageTextLocales.length > 0) {
        let text = undefined;
        for (let pageTextLocale of this.pageTextLocales) {
          if (pageTextLocale.locale === "zhCN") {
            text = pageTextLocale.Text;
          }
        }
        return text ? text : this.pageText.Text;
      } else {
        return this.pageText.Text;
      }
    },
    localeDescription() {
      return null;
    },
  },
  components: {
    PageTextTabPane,
  },
};
</script>
