<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }"
          >首页</el-breadcrumb-item
        >
        <el-breadcrumb-item>设置</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">设置</h3>
    </el-card>
    <el-row :gutter="24" style="margin-top: 16px">
      <el-col :span="4">
        <el-menu
          :default-active="active"
          @select="navigate"
          style="border-right: none"
        >
          <el-card body-style="padding: 0">
            <el-menu-item index="mysql"> 数据库配置 </el-menu-item>
            <el-menu-item index="dbc"> DBC文件路径 </el-menu-item>
            <el-menu-item index="config"> 配置文件路径 </el-menu-item>
          </el-card>
          <el-card body-style="padding: 0" style="margin-top: 16px">
            <el-menu-item index="developer"> 开发者 </el-menu-item>
          </el-card>
        </el-menu>
      </el-col>
      <el-col :span="20">
        <router-view></router-view>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { mapState, mapMutations } from "vuex";
import { SET_SETTING_ACTIVE } from "@/constants";

export default {
  computed: {
    ...mapState("setting", ["active"]),
  },
  methods: {
    ...mapMutations("setting", { setActive: SET_SETTING_ACTIVE }),
    navigate(index) {
      this.setActive(index);
      this.$router.push(`/setting/${index}`).catch((error) => error);
    },
  },
};
</script>
