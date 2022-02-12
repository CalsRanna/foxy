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
        <el-breadcrumb-item :to="{ path: '/glyph_property' }">
          雕文属性管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>雕文属性详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="glyph_property" style="margin-top: 16px">
      <el-tab-pane label="雕文属性" name="glyph_property" lazy>
        <glyph-property-tab-pane />
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import GlyphPropertyTabPane from "@/views/GlyphProperty/components/GlyphPropertyTabPane";

import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("glyphProperty", ["glyphProperty"]),
    localeName() {
      return this.glyphProperty.Name;
    },
    localeDescription() {
      return null;
    },
  },
  components: {
    GlyphPropertyTabPane,
  },
};
</script>
