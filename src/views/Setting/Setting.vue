<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item
          :to="{ path: '/dashboard' }"
          v-if="initializeSucceed"
        >
          首页
        </el-breadcrumb-item>
        <el-breadcrumb-item v-else>首页</el-breadcrumb-item>
        <el-breadcrumb-item>设置</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">设置</h3>
    </el-card>
    <el-row :gutter="16" style="margin-top: 16px">
      <el-col :span="6">
        <el-menu
          :default-active="active"
          @select="navigate"
          style="border-right: none"
        >
          <el-card body-style="padding: 0">
            <el-menu-item index="basic">
              基础配置
              <el-tooltip
                class="item"
                effect="dark"
                content="所有配置项必须准确无误才能使用本软件"
                placement="right"
              >
                <i class="el-icon-info"></i>
              </el-tooltip>
            </el-menu-item>
          </el-card>
          <el-card body-style="padding: 0" style="margin-top: 16px">
            <el-menu-item index="developer"> 开发者 </el-menu-item>
          </el-card>
          <el-card body-style="padding: 0" style="margin-top: 16px">
            <el-menu-item index="changelog"> 更新日志 </el-menu-item>
          </el-card>
        </el-menu>
      </el-col>
      <el-col :span="18">
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
    ...mapState("initiator", ["initializeSucceed"]),
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
