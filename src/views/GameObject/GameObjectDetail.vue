<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">
          首页
        </el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/game-object' }">
          物体管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>物体详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-tabs value="game_object_template" style="margin-top: 16px">
        <el-tab-pane label="物体模版" name="game_object_template" lazy>
          <game-object-template-tab-pane></game-object-template-tab-pane>
        </el-tab-pane>
        <el-tab-pane label="模版补充" name="game_object_template_addon" lazy>
          <game-object-template-addon-tab-pane></game-object-template-addon-tab-pane>
        </el-tab-pane>
        <el-tab-pane label="任务物品" name="game_object_quest_item" lazy>
          <game-object-quest-item-tab-pane></game-object-quest-item-tab-pane>
        </el-tab-pane>
        <el-tab-pane label="物品掉落" name="game_object_loot_template" lazy>
          <game-object-loot-template-tab-pane></game-object-loot-template-tab-pane>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
import { mapState } from "vuex";

import GameObjectTemplateTabPane from "@/views/GameObject/components/GameObjectTemplateTabPane";
import GameObjectTemplateAddonTabPane from "@/views/GameObject/components/GameObjectTemplateAddonTabPane";
import GameObjectQuestItemTabPane from "./components/GameObjectQuestItemTabPane.vue";
import GameObjectLootTemplateTabPane from "./components/GameObjectLootTemplateTabPane.vue";

export default {
  computed: {
    ...mapState("gameObjectTemplate", ["gameObjectTemplate"]),
    ...mapState("gameObjectTemplateLocale", ["gameObjectTemplateLocales"]),
    localeName() {
      if (this.gameObjectTemplateLocales.length > 0) {
        let name = undefined;
        for (let gameObjectTemplateLocale of this.gameObjectTemplateLocales) {
          if (gameObjectTemplateLocale.locale === "zhCN") {
            name = gameObjectTemplateLocale.name;
          }
        }
        return name !== undefined ? name : this.gameObjectTemplate.name;
      } else {
        return this.gameObjectTemplate.name;
      }
    },
    localeDescription() {
      return null;
    },
  },
  components: {
    GameObjectTemplateTabPane,
    GameObjectTemplateAddonTabPane,
    GameObjectQuestItemTabPane,
    GameObjectLootTemplateTabPane,
  },
};
</script>
