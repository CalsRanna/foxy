<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">
          首页
        </el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/quest' }">
          任务管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>任务详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-tabs value="quest_template" style="margin-top: 16px">
        <el-tab-pane label="任务模版" name="quest_template" lazy>
          <quest-template-tab-pane></quest-template-tab-pane>
        </el-tab-pane>
        <el-tab-pane label="模版补充" name="quest_template_addon" lazy>
          <quest-template-addon-tab-pane></quest-template-addon-tab-pane>
        </el-tab-pane>
        <el-tab-pane label="任务奖励" name="quest_offer_reward" lazy>
          <quest-offer-reward-tab-pane></quest-offer-reward-tab-pane>
        </el-tab-pane>
        <el-tab-pane label="任务需要物品" name="quest_request_items" lazy>
          <quest-request-items-tab-pane></quest-request-items-tab-pane>
        </el-tab-pane>
        <el-tab-pane label="任务开始生物" name="creature_quest_starter" lazy>
        </el-tab-pane>
        <el-tab-pane label="任务结束生物" name="creature_quest_ender" lazy>
        </el-tab-pane>
        <el-tab-pane label="任务开始物体" name="game_object_quest_starter" lazy>
        </el-tab-pane>
        <el-tab-pane label="任务结束物体" name="game_object_quest_ender" lazy>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
import QuestTemplateTabPane from "@/views/Quest/components/QuestTemplateTabPane";
import QuestTemplateAddonTabPane from "@/views/Quest/components/QuestTemplateAddonTabPane";
import QuestOfferRewardTabPane from "@/views/Quest/components/QuestOfferRewardTabPane";
import QuestRequestItemsTabPane from "@/views/Quest/components/QuestRequestItemsTabPane";

export default {
  computed: {
    localeName() {
      return null;
    },
    localeDescription() {
      return null;
    },
  },
  components: {
    QuestTemplateTabPane,
    QuestTemplateAddonTabPane,
    QuestOfferRewardTabPane,
    QuestRequestItemsTabPane,
  },
};
</script>
