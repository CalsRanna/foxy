<template>
  <el-container>
    <template v-if="initialized">
      <el-aside width="200px" class="left-menu">
        <div class="logo">
          <h3 style="margin: 0; padding: 0">FOXY</h3>
          <p style="font-size: 12px; color: #c0c4cc">魔兽世界编辑器</p>
        </div>
        <el-menu
          :default-active="active"
          @select="navigate"
          style="border-right: none"
        >
          <template v-if="initializeSucceed">
            <el-menu-item index="dashboard">
              首页 <small>DASHBOARD</small>
            </el-menu-item>
            <el-menu-item index="creature">
              生物 <small>CREATURE</small>
            </el-menu-item>
            <el-menu-item index="item"> 物品 <small>ITEM</small> </el-menu-item>
            <el-menu-item index="game-object">
              物体 <small>GAME OBJECT</small>
            </el-menu-item>
            <el-menu-item index="quest">
              任务 <small>QUEST</small>
            </el-menu-item>
            <el-menu-item index="gossip-menu">
              对话 <small>GOSSIP MENU</small>
            </el-menu-item>
            <el-menu-item index="smart-script">
              内建脚本 <small>SMART SCRIPT</small>
            </el-menu-item>
            <el-menu-item index="spell">
              技能 <small>SPELL</small>
            </el-menu-item>
            <el-menu-item index="advance">
              高级 <small>ADVANCE</small>
            </el-menu-item>
          </template>
          <el-menu-item index="setting">
            设置 <small>SETTING</small>
          </el-menu-item>
        </el-menu>
      </el-aside>
      <el-main style="margin-left: 200px">
        <router-view></router-view>
      </el-main>
    </template>
    <initiator></initiator>
    <exporter></exporter>
  </el-container>
</template>

<script>
const ipcRenderer = window.ipcRenderer;

import { mapState, mapActions } from "vuex";
import { GLOBAL_MESSAGE_BOX, GLOBAL_MESSAGE } from "./constants";
import Initiator from "@/components/Initiator";
import Exporter from "@/components/Exporter";

export default {
  computed: {
    ...mapState("global", ["active"]),
    ...mapState("initiator", [
      "developerConfig",
      "initialized",
      "initializeSucceed",
    ]),
  },
  methods: {
    ...mapActions("global", ["setActive"]),
    navigate(index) {
      this.setActive(index);
      this.$router.push(`/${index}`).catch((error) => error);
    },
  },
  mounted() {
    ipcRenderer.on(GLOBAL_MESSAGE_BOX, (event, error) => {
      console.log(error);
      let content = "";
      let title = "";
      try {
        error = JSON.parse(error);
        content = this.developerConfig.debug
          ? [
              `- ${error.index}`,
              error.sqlState,
              error.sqlMessage,
              error.sql,
            ].join("<br>- ")
          : `${error.sqlMessage}`;
        title =
          error.code == undefined
            ? "未知错误"
            : `[${error.errno}] ${error.code}`;
      } catch (e) {
        content = error.stack
          ? error.stack.replaceAll(" at ", "<br>&nbsp;&nbsp; at ")
          : error;
        title = "未知错误";
      }
      this.$alert(content, title, {
        type: "error",
        dangerouslyUseHTMLString: true,
        customClass: "wider-message-box",
      });
    });

    ipcRenderer.on(GLOBAL_MESSAGE, (event, message) => {
      if (this.developerConfig.debug) {
        this.$message(message);
      }
    });
  },
  components: { Initiator, Exporter },
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

.el-dialog__body {
  padding: 10px 20px !important;
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

.wider-message-box {
  width: 50vw !important;
}

.clickable-card {
  cursor: pointer;
}

.summary-title {
  font-size: 20px;
  font-weight: 600;
  color: #303133;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.summary-title span {
  font-size: 16px;
  color: #909399;
  margin-left: 8px;
}

.summary-content {
  font-size: 24px;
  font-weight: 900;
  color: #606266;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.hide-when-overflow .cell {
  white-space: nowrap !important;
  overflow: hidden !important;
  text-overflow: ellipsis !important;
}
</style>
