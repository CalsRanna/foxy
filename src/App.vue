<template>
  <el-container>
    <el-aside width="200px" style="background-color: rgb(238, 241, 246)">
      <div style="padding: 16px;text-align: center">
        <h3 style="margin: 0; padding: 0">FOXY</h3>
      </div>
      <el-row :gutter="16" style="padding: 16px">
        <el-col :span="6">
          <el-avatar src="./assets/logo.png">
            <img
              src="https://cube.elemecdn.com/e/fd/0fc7d20532fdaf769a25683617711png.png"
            />
          </el-avatar>
        </el-col>
        <el-col :span="18">
          root
          <br>
          10.0.0.13:3306
          <br>
          acore_world
        </el-col>
      </el-row>
      <el-menu default-active="dashboard" :router="true">
        <el-menu-item index="/">
          控制面板
        </el-menu-item>
        <el-menu-item index="/creature">
          生物 <small>CREATURE</small>
        </el-menu-item>
        <el-menu-item index="/item"> 物品 <small>ITEM</small> </el-menu-item>
        <el-menu-item index="/quest"> 任务 <small>QUEST</small> </el-menu-item>
        <el-menu-item index="/spell"> 技能 <small>SPELL</small> </el-menu-item>
      </el-menu>
    </el-aside>
    <el-main>
      <router-view></router-view>
    </el-main>
  </el-container>
</template>

<style>
.el-aside {
  color: #333;
}
</style>

<script>
export default {
  name: "app",
  data() {
    const item = {
      date: "2016-05-02",
      name: "王小虎",
      address: "上海市普陀区金沙江路 1518 弄",
    };
    return {
      tableData: Array(20).fill(item),
    };
  },
};
</script>
