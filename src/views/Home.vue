<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item>控制面板</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">控制面板</h3>
    </el-card>
    <el-row :gutter="16" style="margin-top: 16px">
      <el-col :span="6">
        <el-card>
          <h3>生物</h3>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card>
          <h3>物品</h3>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card>
          <h3>任务</h3>
        </el-card>
      </el-col>
      <el-col :span="6">
        <el-card>
          <h3>玩家</h3>
        </el-card>
      </el-col>
    </el-row>
    <el-row :gutter="16" style="margin-top: 16px">
      <el-col :span="16">
        <el-card style="min-height: 400px"></el-card>
      </el-col>
      <el-col :span="8">
        <el-card style="min-height: 400px">
          <h3 style="margin: 0">系统状态</h3>
          <p>服务端核心版本：AzerothCore rev. 992161381699+ 2020-03-16 16:12:26 +0800 (master branch) (Unix, Release)</p>
          <p>Hash：992161381699+ </p>
          <p>数据库版本：ACDB 335.3 (dev)</p>
          <p>World DB version：2019_12_18_00</p>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
export default {
  name: "Home",
};
</script>
