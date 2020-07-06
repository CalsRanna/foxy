<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }"
          >首页</el-breadcrumb-item
        >
        <el-breadcrumb-item>游戏对象</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">游戏对象列表</h3>
    </el-card>
  </div>
</template>

<script>
export default {
  name: "dashboard",
  data() {},
};
</script>
