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
      <h3
        style="margin: 16px 0 0 0; white-space: nowrap; overflow: hidden; text-overflow: ellipsis"
      >
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
import { mapState } from "vuex";

import GossipMenuTabPane from "@/views/GossipMenu/components/GossipMenuTabPane";
import NpcTextTabPane from "@/views/GossipMenu/components/NpcTextTabPane";
import GossipMenuOptionTabPane from "@/views/GossipMenu/components/GossipMenuOptionTabPane";

export default {
  computed: {
    ...mapState("npcText", ["npcText"]),
    ...mapState("npcTextLocale", ["npcTextLocales"]),
    localeName() {
      if (this.npcTextLocales.length > 0) {
        let name = undefined;
        for (let npcTextLocale of this.npcTextLocales) {
          if (npcTextLocale.Locale === "zhCN") {
            name =
              npcTextLocale.Text0_0 != ""
                ? npcTextLocale.Text0_0
                : npcTextLocale.Text0_1;
          }
        }
        return name !== ""
          ? name
          : this.npcText.text0_0 != ""
          ? this.npcText.text0_0
          : this.npcText.text0_1;
      } else {
        return this.npcText.text0_0 != ""
          ? this.npcText.text0_0
          : this.npcText.text0_1;
      }
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
