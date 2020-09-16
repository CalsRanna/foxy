<template>
  <el-container>
    <el-aside width="200px" class="left-menu">
      <div class="logo">
        <h3 style="margin: 0; padding: 0">FOXY</h3>
        <p style="font-size: 12px; color: #C0C4CC">
          魔兽世界
          <span style="font-size: 10px;text-decoration:line-through">
            编辑
          </span>
          <span style="font-size: 14px">查看</span>
          器
        </p>
      </div>
      <el-menu :default-active="active" @select="navigate" style="border-right: none">
        <el-menu-item index="dashboard"> 首页 <small>DASHBOARD</small> </el-menu-item>
        <el-menu-item index="creature"> 生物 <small>CREATURE</small> </el-menu-item>
        <el-menu-item index="game-object"> 游戏对象 <small>GAME OBJECT</small> </el-menu-item>
        <el-menu-item index="item"> 物品 <small>ITEM</small> </el-menu-item>
        <el-menu-item index="quest"> 任务 <small>QUEST</small> </el-menu-item>
        <el-menu-item index="spell"> 技能 <small>SPELL</small> </el-menu-item>
        <el-menu-item index="smart-script"> 内建脚本 <small>SMART SCRIPT</small> </el-menu-item>
      </el-menu>
    </el-aside>
    <el-main style="margin-left: 200px">
      <router-view></router-view>
    </el-main>
  </el-container>
</template>

<script>
const ipcRenderer = window.require("electron").ipcRenderer;
import { mapState, mapActions, mapMutations } from "vuex";
import * as types from "@/store/MUTATION_TYPES";

export default {
  computed: {
    ...mapState("global", ["debug", "active"]),
    ...mapState("dbc", ["factions", "factionTemplates", "itemDisplayInfos"])
  },
  methods: {
    ...mapActions("dbc", ["searchDbcFactions", "searchDbcFactionTemplates", "searchDbcItemDisplayInfos"]),
    ...mapMutations("global", {
      setActive: types.SET_ACTIVE
    }),
    navigate(index) {
      this.$router.push(`/${index}`).catch(error => error);
      this.setActive(index);
    }
  },
  created() {
    ipcRenderer.on("UPDATE_MESSAGE_REPLY", (event, response) => {
      if (response.category === "notification") {
        this.$notify({
          title: response.title,
          message: response.message,
          type: response.type
        });
      } else {
        if (this.debug) {
          this.$message({
            message: response
          });
        }
      }
    });

    this.searchDbcFactions();
    this.searchDbcFactionTemplates();
    // this.searchDbcItemDisplayInfos();
  }
};
</script>

<style>
.el-input-number {
  width: 100% !important;
}

.el-input-number .el-input__inner {
  text-align: left !important;
}

.el-select {
  width: 100%;
}

.left-menu {
  position: fixed;
  min-height: 100vh;
  border-right: solid 1px #e6e6e6;
}

.logo {
  padding: 16px;
  text-align: center;
  background-color: #f2f6fc;
}

.clickable-icon {
  cursor: pointer;
}

.flag-editor tbody tr {
  cursor: pointer;
}
</style>
