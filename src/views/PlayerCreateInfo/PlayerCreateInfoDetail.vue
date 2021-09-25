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
        <el-breadcrumb-item :to="{ path: '/playerCreateInfo' }">
          玩家出生信息管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>玩家出生信息详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="player-create-info" style="margin-top: 16px">
      <el-tab-pane label="玩家出生信息" name="player-create-info" lazy>
        <player-create-info-tab-pane></player-create-info-tab-pane>
      </el-tab-pane>
      <el-tab-pane label="动作条" name="player-create-info-action" lazy>
        <player-create-info-action-tab-pane></player-create-info-action-tab-pane>
      </el-tab-pane>
      <el-tab-pane label="物品" name="player-create-info-item" lazy>
        <player-create-info-item-tab-pane></player-create-info-item-tab-pane>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import PlayerCreateInfoTabPane from "@/views/PlayerCreateInfo/components/PlayerCreateInfoTabPane";
import PlayerCreateInfoActionTabPane from "@/views/PlayerCreateInfo/components/PlayerCreateInfoActionTabPane";
import PlayerCreateInfoItemTabPane from "./components/PlayerCreateInfoItemTabPane";

import { mapState } from "vuex";

export default {
  computed: {
    ...mapState("initiator", ["chrRaces", "chrClasses"]),
    ...mapState("playerCreateInfo", ["playerCreateInfo"]),
    localeName() {
      let name = "";
      for (let chrRace of this.chrRaces) {
        if (chrRace.ID === this.playerCreateInfo.race) {
          name = chrRace.Name_Lang_zhCN;
        }
      }
      return name;
    },
    localeDescription() {
      let description = "";
      for (let chrclass of this.chrClasses) {
        if (chrclass.ID === this.playerCreateInfo.class) {
          description = chrclass.Name_Lang_zhCN;
        }
      }
      return description;
    },
  },
  components: {
    PlayerCreateInfoTabPane,
    PlayerCreateInfoActionTabPane,
    PlayerCreateInfoItemTabPane,
  },
};
</script>
