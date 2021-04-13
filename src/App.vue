<template>
  <el-container>
    <template v-if="!initializing">
      <el-aside width="200px" class="left-menu">
        <div class="logo">
          <h3 style="margin: 0; padding: 0">FOXY</h3>
          <p style="font-size: 12px; color: #c0c4cc">
            魔兽世界编辑器
          </p>
        </div>
        <el-menu
          :default-active="active"
          @select="navigate"
          style="border-right: none"
        >
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
          <el-menu-item index="quest"> 任务 <small>QUEST</small> </el-menu-item>
          <el-menu-item index="gossip-menu">
            对话 <small>GOSSIP MENU</small>
          </el-menu-item>
          <el-menu-item index="smart-script">
            内建脚本 <small>SMART SCRIPT</small>
          </el-menu-item>
          <el-menu-item index="spell"> 技能 <small>SPELL</small> </el-menu-item>
          <el-menu-item index="setting">
            设置 <small>SETTING</small>
          </el-menu-item>
        </el-menu>
      </el-aside>
      <el-main style="margin-left: 200px">
        <router-view></router-view>
      </el-main>
    </template>
    <el-dialog
      :visible.sync="visible"
      width="30%"
      top="40vh"
      :show-close="false"
      :close-on-click-modal="false"
      :modal="modal"
    >
      <div style="text-align:center; margin-bottom: 24px; font-size: 20px;">
        <i class="el-icon-loading"></i>
        {{ loadingText }}
        <template v-show="progressText != undefined">
          <br />
          <br />
          <small style="color: #909399; font-size: 14px">
            {{ progressText }}
            <span v-show="seconds != 0">，用时{{ seconds }}秒</span>
          </small>
        </template>
      </div>
    </el-dialog>
  </el-container>
</template>

<script>
const ipcRenderer = window.ipcRenderer;

import { mapState, mapActions } from "vuex";
import {
  EXPORT_ITEM_DBC,
  EXPORT_SPELL_DBC,
  GLOBAL_MESSAGE_BOX,
  GLOBAL_MESSAGE,
  START_EXPORT,
} from "./constants";

export default {
  data() {
    return {
      initializing: true,
      visible: false,
      modal: false,
      loadingText: "加载开始",
      seconds: 0,
      progressText: undefined,
    };
  },
  computed: {
    ...mapState("global", [
      "active",
      "developerConfig",
      "mysqlConfig",
      "dbcConfig",
      "configConfig",
    ]),
  },
  methods: {
    ...mapActions("dbc", [
      "searchDbcFactions",
      "searchDbcFactionTemplates",
      "searchDbcCreatureSpellDatas",
      "searchDbcCreatureDisplayInfos",
      "searchDbcCreatureModelDatas",
      "searchDbcItemDisplayInfos",
      "searchDbcItems",
      "searchDbcScalingStatDistributions",
      "searchDbcScalingStatValues",
      "searchDbcSpellDurations",
      "searchDbcSpells",
      "searchDbcItemSets",
      "searchDbcSpellItemEnchantments",
      "searchDbcItemRandomProperties",
      "searchDbcItemRandomSuffixes",
      "exportItemDbc",
      "exportSpellDbc",
    ]),
    ...mapActions("global", [
      "findLatestVersion",
      "setActive",
      "storeDeveloperConfig",
      "storeMysqlConfig",
      "storeDbcConfig",
      "storeConfigConfig",
      "initMysqlConnection",
      "initDbcConnection",
    ]),
    ...mapActions("setting", ["setSettingActive"]),
    navigate(index) {
      this.setActive(index);
      this.$router.push(`/${index}`).catch((error) => error);
    },
    initDeveloperConfig() {
      return new Promise((resolve, reject) => {
        let config = {
          debug: localStorage.getItem("debug") === "true" ? true : false,
        };

        this.storeDeveloperConfig(config)
          .then(() => {
            resolve();
          })
          .catch((error) => {
            reject(error);
          });
      });
    },
    initMysqlConfig() {
      return new Promise((resolve, reject) => {
        let config = {
          host: localStorage.getItem("host"),
          user: localStorage.getItem("user"),
          password: localStorage.getItem("password"),
          database: localStorage.getItem("database"),
        };

        if (config.host && config.user && config.password && config.database) {
          Promise.all([
            this.storeMysqlConfig(config),
            this.initMysqlConnection(config),
          ])
            .then(() => {
              resolve();
            })
            .catch((error) => {
              reject(error);
            });
        } else {
          this.setActive("setting");
          this.setSettingActive("mysql");
          this.$router.push("/setting/mysql").catch((error) => error);
          reject();
        }
      });
    },
    initDbcConfig() {
      return new Promise((resolve, reject) => {
        let config = {
          path: localStorage.getItem("dbcPath"),
        };

        if (config.path) {
          Promise.all([
            this.storeDbcConfig(config),
            this.initDbcConnection(config),
          ])
            .then(() => {
              resolve();
            })
            .catch((error) => {
              reject(error);
            });
        } else {
          this.setActive("setting");
          this.setSettingActive("dbc");
          this.$router.push("/setting/dbc").catch((error) => error);
          reject();
        }
      });
    },
    async init() {
      try {
        this.visible = true;
        this.progressText = "加载开发者配置";
        await this.initDeveloperConfig();
        this.progressText = "加载数据库配置";
        await this.initMysqlConfig();
        this.progressText = "加载DBC配置";
        await this.initDbcConfig();
        this.progressText = "加载Faction.dbc";
        await this.searchDbcFactions();
        this.progressText = "加载FactionTemplate.dbc";
        await this.searchDbcFactionTemplates();
        this.progressText = "加载CreatureSpellData.dbc";
        await this.searchDbcCreatureSpellDatas();
        this.progressText = "加载CreatureDisplayInfo.dbc";
        await this.searchDbcCreatureDisplayInfos();
        this.progressText = "加载CreatureModelData.dbc";
        await this.searchDbcCreatureModelDatas();
        this.progressText = "加载Item.dbc";
        await this.searchDbcItems();
        this.progressText = "加载ItemDisplayInfo.dbc";
        await this.searchDbcItemDisplayInfos();
        this.progressText = "加载ItemSet.dbc";
        await this.searchDbcItemSets();
        this.progressText = "加载SpellItemEnchantment.dbc";
        await this.searchDbcSpellItemEnchantments();
        this.progressText = "加载ItemRandomProperties.dbc";
        await this.searchDbcItemRandomProperties();
        this.progressText = "加载ItemRandomSuffix.dbc";
        await this.searchDbcItemRandomSuffixes();
        this.progressText = "加载ScalingStatDistribution.dbc";
        await this.searchDbcScalingStatDistributions();
        this.progressText = "加载ScalingStatValues.dbc";
        await this.searchDbcScalingStatValues();
        this.progressText = "加载Spell.dbc";
        await this.searchDbcSpells();
        this.progressText = "加载SpellDuration.dbc";
        await this.searchDbcSpellDurations();
        this.loadingText = "加载完成";
        this.progressText = undefined;
        setTimeout(() => {
          this.initializing = false;
          this.visible = false;
        }, 500);
      } catch (error) {
        this.loadingText = "加载中止";
        this.progressText = undefined;
        setTimeout(() => {
          this.initializing = false;
          this.visible = false;
        }, 500);
      }
      this.findLatestVersion();
    },
  },
  mounted() {
    this.init();

    ipcRenderer.on(GLOBAL_MESSAGE_BOX, (event, error) => {
      error = JSON.parse(error);
      let content = this.developerConfig.debug
        ? [
            `- ${error.index}`,
            error.sqlState,
            error.sqlMessage,
            error.sql,
          ].join("<br>- ")
        : `${error.sqlMessage}`;
      let title =
        error.code == undefined ? "未知错误" : `[${error.errno}] ${error.code}`;
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

    ipcRenderer.on(START_EXPORT, () => {
      this.visible = true;
      this.modal = true;
      this.loadingText = "正在导出";
      let timer = setInterval(() => {
        this.seconds++;
      }, 1000);
      this.exportItemDbc()
        .then(() => {
          this.exportSpellDbc()
            .then(() => {
              clearInterval(timer);
              this.loadingText = "导出成功";
              setTimeout(() => {
                this.visible = false;
                this.modal = false;
              }, 500);
              this.$notify({
                title: `导出成功，用时${this.seconds}秒`,
                position: "bottom-left",
                type: "success",
              });
              this.seconds = 0;
            })
            .catch((error) => {
              clearInterval(timer);
              this.loadingText = "导出失败";
              setTimeout(() => {
                this.visible = false;
                this.modal = false;
                this.$alert(
                  error.message.replace(
                    /at /g,
                    "<br>&nbsp;&nbsp;&nbsp;&nbsp;at "
                  ),
                  error.title,
                  {
                    type: "error",
                    dangerouslyUseHTMLString: true,
                    customClass: "wider-message-box",
                  }
                );
              }, 500);
              this.seconds = 0;
            });
        })
        .catch((error) => {
          clearInterval(timer);
          this.loadingText = "导出失败";
          setTimeout(() => {
            this.visible = false;
            this.modal = false;
            this.$alert(
              error.message.replace(/at /g, "<br>&nbsp;&nbsp;&nbsp;&nbsp;at "),
              error.title,
              {
                type: "error",
                dangerouslyUseHTMLString: true,
                customClass: "wider-message-box",
              }
            );
          }, 500);
          this.seconds = 0;
        });
    });

    ipcRenderer.on(`${EXPORT_SPELL_DBC}_PROGRESS`, (event, text) => {
      this.progressText = text;
    });

    ipcRenderer.on(`${EXPORT_ITEM_DBC}_PROGRESS`, (event, text) => {
      this.progressText = text;
    });
  },
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

.summary-title {
  font-size: 20px;
  font-weight: 600;
  color: #303133;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: clip;
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
}

.hide-when-overflow .cell {
  white-space: nowrap !important;
  overflow: hidden !important;
  text-overflow: ellipsis !important;
}
</style>
