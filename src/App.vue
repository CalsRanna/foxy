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
              法术技能 <small>SPELL</small>
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
    <updater></updater>
  </el-container>
</template>

<script>
const ipcRenderer = window.ipcRenderer;

import { mapState, mapActions } from "vuex";
import { GLOBAL_MESSAGE_BOX, GLOBAL_MESSAGE } from "./constants";
import Initiator from "@/components/Initiator";
import Exporter from "@/components/Exporter";
import Updater from "@/components/Updater";

export default {
  computed: {
    ...mapState("app", ["active", "error"]),
    ...mapState("initiator", [
      "developerConfig",
      "initialized",
      "initializeSucceed",
    ]),
  },
  watch: {
    error(value, oldValue) {
      if (value.timestamp - oldValue.timestamp >= 1000) {
        this.$alert(this.error.content, this.error.title, {
          type: "error",
          dangerouslyUseHTMLString: true,
          customClass: "wider-message-box",
        });
      }
    },
  },
  methods: {
    ...mapActions("app", ["setClientHeight", "setActive", "updateError"]),
    navigate(index) {
      this.setActive(index);
      this.$router.push(`/${index}`).catch((error) => error);
    },
  },
  mounted() {
    this.setClientHeight(document.documentElement.clientHeight);
    this.navigate(this.active || "dashboard");
    ipcRenderer.once(GLOBAL_MESSAGE_BOX, (event, error) => {
      let title = "";
      let content = "";
      try {
        let properties = Object.getOwnPropertyNames(error);
        title = properties.includes["code"]
          ? `内部错误[${error.code}]`
          : "内部错误";
        content = this.developerConfig.debug
          ? error.stack.replaceAll(" at ", "<br>&nbsp;&nbsp; at ")
          : error.message;
      } catch (e) {
        title = "未知错误";
        content = error;
      }
      this.updateError({
        timestamp: new Date().getTime(),
        title: title,
        content: content,
      });
    });

    ipcRenderer.once(GLOBAL_MESSAGE, (event, message) => {
      if (this.developerConfig.debug) {
        this.$message(message);
      }
    });
  },
  components: { Initiator, Exporter, Updater },
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

.wider-message-box {
  width: 50vw !important;
}

.clickable-card {
  cursor: pointer;
  margin-top: 16px;
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

.selectable-table tbody tr {
  cursor: pointer;
}

.hide-when-overflow .cell {
  white-space: nowrap !important;
  overflow: hidden !important;
  text-overflow: ellipsis !important;
}

.tight-table td {
  padding: 6px 0;
}
.footer {
  position: fixed;
  bottom: 0;
  width: 100vw;
  z-index: 1;
}
</style>
