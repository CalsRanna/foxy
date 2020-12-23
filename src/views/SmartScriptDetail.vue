<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/smart-script' }">内建脚本管理</el-breadcrumb-item>
        <el-breadcrumb-item>内建脚本详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-card style="margin-top: 16px;">
      <el-tabs value="quest_template" style="margin-top: 16px">
        <el-tab-pane label="任务模版" name="quest_template"> </el-tab-pane>
        <el-tab-pane label="模版补充" name="template_addon"></el-tab-pane>
        <el-tab-pane label="任务奖励" name="quest_offer_reward"></el-tab-pane>
        <el-tab-pane label="任务需要物品" name="quest_request_items"></el-tab-pane>
        <el-tab-pane label="任务开始生物" name="creature_quest_starter"></el-tab-pane>
        <el-tab-pane label="任务结束生物" name="creature_quest_ender"></el-tab-pane>
        <el-tab-pane label="任务开始游戏对象" name="game_object_quest_starter"></el-tab-pane>
        <el-tab-pane label="任务结束游戏对象" name="game_object_quest_ender"></el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
export default {
  computed: {
    localeName() {
      return null;
    },
    localeDescription() {
      return null;
    }
  }
};
</script>
