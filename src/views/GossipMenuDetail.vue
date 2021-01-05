<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/gossip-menu' }">对话管理</el-breadcrumb-item>
        <el-breadcrumb-item>对话详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeSubname }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="gossip_menu" @tab-click="switchover" style="margin-top: 16px">
      <el-tab-pane label="对话" name="gossip_menu">
        <el-form :model="gossipMenu" label-position="right" label-width="120px">
          <el-card style="margin-top: 16px">
            <el-row :gutter="24">
              <el-col :span="6">
                <el-form-item label="对话ID">
                  <el-input-number
                    v-model="gossipMenu.MenuID"
                    :min="min"
                    controls-position="right"
                    placeholder="MenuID"
                    :disabled="disabled"
                    v-loading="loading"
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(255, 255, 255, 0.5)"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="文本ID">
                  <el-input v-model="gossipMenu.TextID" placeholder="TextID"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-button type="primary" @click="() => store('gossip_menu')">保存</el-button>
            <el-button @click="cancel">返回</el-button>
          </el-card>
        </el-form>
      </el-tab-pane>
      <el-tab-pane label="文本" name="npc_text" lazy v-loading="loading"></el-tab-pane>
      <el-tab-pane label="选项" name="gossip_menu_option" lazy v-loading="loading"></el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import { mapState } from "vuex";

export default {
  data() {
    return {
      loading: false,
      min: 0,
      isCreating: true,
      credential: {}
    };
  },
  computed: {
    ...mapState("gossipMenu", ["gossipMenu"]),
    localeName() {
      return null;
    },
    localeSubname() {
      return null;
    },
    disabled() {
      return !this.isCreating;
    }
  },
  methods: {
    async switchover(tab) {
      console.log(tab.name);
    },
    store(module) {
      console.log(module);
    },
    cancel() {
      this.$router.go(-1);
    },
    async init() {
      this.loading = true;
      let path = this.$route.path;
      if (path === "/gossip-menu/create") {
        // await this.createSmartScript();
      } else {
        this.isCreating = false;
        this.credential = this.$route.query;
        this.credential.MenuID = this.$route.params.id;
        // await Promise.all([this.findSmartScript(this.credential)]);
      }
      this.loading = false;
    }
  },
  created() {
    this.init();
  }
};
</script>
