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
        <el-breadcrumb-item :to="{ path: '/emote-text' }">
          表情文本管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>表情文本详情</el-breadcrumb-item>
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
        <el-tab-pane label="表情文本" name="smart_script" lazy>
          <emote-text-tab-pane></emote-text-tab-pane>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
import EmoteTextTabPane from "@/views/EmoteText/components/EmoteTextTabPane";

import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("emoteText", ["emoteText"]),
    localeName() {
      return this.emoteText.Name;
    },
    localeDescription() {
      return null;
    },
  },
  components: {
    EmoteTextTabPane,
  },
};
</script>
