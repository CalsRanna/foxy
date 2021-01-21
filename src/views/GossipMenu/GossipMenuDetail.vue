<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">
          首页
        </el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/gossip-menu' }">
          对话管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>对话详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeSubname }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="gossip_menu" style="margin-top: 16px">
      <el-tab-pane label="对话" name="gossip_menu" lazy>
        <gossip-menu-tab-pane></gossip-menu-tab-pane>
      </el-tab-pane>
      <el-tab-pane label="文本" name="npc_text" lazy>
        <npc-text-tab-pane></npc-text-tab-pane>
      </el-tab-pane>
      <el-tab-pane label="选项" name="gossip_menu_option" lazy>
        <gossip-menu-option-tab-pane></gossip-menu-option-tab-pane>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import GossipMenuTabPane from "@/views/GossipMenu/components/GossipMenuTabPane";
import NpcTextTabPane from "@/views/GossipMenu/components/NpcTextTabPane";
import GossipMenuOptionTabPane from "@/views/GossipMenu/components/GossipMenuOptionTabPane";

export default {
  computed: {
    localeName() {
      return null;
    },
    localeSubname() {
      return null;
    },
  },
  components: {
    GossipMenuTabPane,
    NpcTextTabPane,
    GossipMenuOptionTabPane,
  },
};
</script>
