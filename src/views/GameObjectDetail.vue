<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/game-object' }">游戏对象管理</el-breadcrumb-item>
        <el-breadcrumb-item>游戏对象详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-card style="margin-top: 16px;">
      <el-tabs value="game_object_template" @tab-click="switchover" style="margin-top: 16px">
        <el-tab-pane label="游戏对象模版" name="game_object_template"> </el-tab-pane>
        <el-tab-pane label="模版补充" name="template_addon"></el-tab-pane>
        <el-tab-pane label="任务物品" name="quest_item"></el-tab-pane>
        <el-tab-pane label="物品掉落" name="game_object_loot"></el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
export default {};
</script>
