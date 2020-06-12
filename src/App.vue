<template>
  <el-container>
    <el-aside
      width="200px"
      style="position: fixed; min-height: 100vh;border-right: solid 1px #E6E6E6"
    >
      <div style="padding: 16px;text-align: center;background-color: #F2F6FC">
        <h3 style="margin: 0; padding: 0">FOXY</h3>
        <span style="font-size: 12px; color: #C0C4CC"
          >魔兽世界<span style="font-size: 10px;text-decoration:line-through"
            >编辑</span
          ><span style="font-size: 14px">查看</span>器</span
        >
      </div>
      <el-menu
        default-active="dashboard"
        :router="true"
        style="border-right: none"
      >
        <el-menu-item index="/"> 主页 <small>DASHBOARD</small> </el-menu-item>
        <el-menu-item index="/creature">
          生物 <small>CREATURE</small>
        </el-menu-item>
        <el-menu-item index="/game-object">
          游戏对象 <small>GAME OBJECT</small>
        </el-menu-item>
        <el-menu-item index="/item"> 物品 <small>ITEM</small> </el-menu-item>
        <el-menu-item index="/quest"> 任务 <small>QUEST</small> </el-menu-item>
        <el-menu-item index="/gossip">
          对话 <small>GOSSIP</small>
        </el-menu-item>
      </el-menu>
    </el-aside>
    <el-main style="margin-left: 200px">
      <router-view></router-view>
    </el-main>
  </el-container>
</template>

<style>
.el-aside {
  color: #333;
}

.el-input-number .el-input__inner {
  text-align: left !important;
}
</style>

<script>
export default {
  name: "app",
};
</script>
