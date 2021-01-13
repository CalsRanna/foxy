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
        <el-menu :default-active="active" @select="navigate" style="border-right: none">
          <el-menu-item index="dashboard"> 首页 <small>DASHBOARD</small> </el-menu-item>
          <el-menu-item index="creature"> 生物 <small>CREATURE</small> </el-menu-item>
          <el-menu-item index="game-object"> 游戏对象 <small>GAME OBJECT</small> </el-menu-item>
          <el-menu-item index="item"> 物品 <small>ITEM</small> </el-menu-item>
          <el-menu-item index="quest"> 任务 <small>QUEST</small> </el-menu-item>
          <el-menu-item index="gossip-menu"> 对话 <small>GOSSIP MENU</small> </el-menu-item>
          <el-menu-item index="smart-script"> 内建脚本 <small>SMART SCRIPT</small> </el-menu-item>
          <el-menu-item index="spell"> 技能 <small>SPELL</small> </el-menu-item>
          <el-menu-item index="developer" v-show="developerConfig.debug">
            开发者 <small>DEVELOPER</small>
          </el-menu-item>
          <el-menu-item index="setting"> 设置 <small>SETTING</small> </el-menu-item>
        </el-menu>
      </el-aside>
      <el-main style="margin-left: 200px">
        <router-view></router-view>
      </el-main>
    </template>
    <el-dialog
      :visible.sync="initializing"
      width="30%"
      top="40vh"
      :show-close="false"
      :close-on-click-modal="false"
      :modal="false"
    >
      <div style="text-align:center; margin-bottom: 24px; font-size: 20px;">
        <i class="el-icon-loading" v-show="initializingText.indexOf(['加载完成', '加载失败']) == -1"></i>
        {{ initializingText }}
      </div>
    </el-dialog>
  </el-container>
</template>

<script>
const ipcRenderer = window.require("electron").ipcRenderer;
import { mapState, mapActions } from "vuex";
import { GLOBAL_NOTICE } from "./constants";

export default {
  data() {
    return {
      initializing: true,
      initializingText: "正在初始化"
    };
  },
  computed: {
    ...mapState("global", ["mysqlConfig", "dbcConfig", "configConfig", "developerConfig", "active"]),
    ...mapState("dbc", [
      "factions",
      "factionTemplates",
      "itemDisplayInfos",
      "scalingStatDistributions",
      "scalingStatValues",
      "spells",
      "spellDurations"
    ])
  },
  methods: {
    ...mapActions("dbc", [
      "searchDbcFactions",
      "searchDbcFactionTemplates",
      "searchDbcItemDisplayInfos",
      "searchDbcSpells",
      "searchDbcSpellDurations",
      "searchDbcScalingStatDistributions",
      "searchDbcScalingStatValues"
    ]),
    ...mapActions("global", [
      "storeMysqlConfig",
      "storeDbcConfig",
      "storeConfigConfig",
      "storeDeveloperConfig",
      "setActive",
      "initMysqlConnection",
      "initDbcConnection"
    ]),
    ...mapActions("setting", ["setSettingActive"]),
    navigate(index) {
      this.setActive(index);
      this.$router.push(`/${index}`).catch(error => error);
    },
    initMysqlConfig() {
      return new Promise((resolve, reject) => {
        let host = localStorage.getItem("host");
        let user = localStorage.getItem("user");
        let password = localStorage.getItem("password");
        let database = localStorage.getItem("database");

        if (host && user && password && database) {
          this.storeMysqlConfig({
            host: host,
            user: user,
            password: password,
            database: database
          }).then(() => {
            this.initMysqlConnection(this.mysqlConfig);
            resolve();
          });
        } else {
          this.setActive("setting");
          this.setSettingActive("mysql");
          this.$router.push("/setting/mysql").catch(error => error);
          reject();
        }
      });
    },
    initDbcConfig() {
      return new Promise((resolve, reject) => {
        let path = localStorage.getItem("dbcPath");

        if (path) {
          this.storeDbcConfig({
            path: path
          }).then(() => {
            this.initDbcConnection(this.dbcConfig).then(() => {
              resolve();
            });
          });
        } else {
          // this.setActive("setting");
          // this.setSettingActive("dbc");
          // this.$router.push("/setting/dbc").catch(error => error);
          reject();
        }
      });
    },
    initConfigConfig() {
      return new Promise((resolve, reject) => {
        let path = localStorage.getItem("configPath");

        if (path) {
          this.storeConfigConfig({
            path: path
          }).then(() => {
            resolve();
          });
        } else {
          // this.setActive("setting");
          // this.setSettingActive("config");
          // this.$router.push("/setting/config").catch(error => error);
          reject();
        }
      });
    },
    initDeveloperConfig() {
      return new Promise(resolve => {
        let debug = localStorage.getItem("debug");

        this.storeDeveloperConfig({
          debug: debug === "true" ? true : false
        }).then(() => {
          resolve();
        });
      });
    },
    async init() {
      try {
        this.initializingText = "加载开发者配置";
        await this.initDeveloperConfig();
        this.initializingText = "加载数据库配置";
        await this.initMysqlConfig();
        this.initializingText = "加载DBC配置";
        await this.initDbcConfig();
        this.initializingText = "加载服务端配置";
        await this.initConfigConfig();
        this.initializingText = "加载Faction.dbc";
        await this.searchDbcFactions();
        this.initializingText = "加载FactionTemplate.dbc";
        await this.searchDbcFactionTemplates();
        this.initializingText = "加载ItemDisplayInfo.dbc";
        await this.searchDbcItemDisplayInfos();
        this.initializingText = "加载Spell.dbc";
        await this.searchDbcSpells();
        this.initializingText = "加载SpellDuration.dbc";
        await this.searchDbcSpellDurations();
        this.initializingText = "加载ScalingStatDistribution.dbc";
        await this.searchDbcScalingStatDistributions();
        this.initializingText = "加载ScalingStatValues.dbc";
        await this.searchDbcScalingStatValues();
        this.initializingText = "加载完成";
        setTimeout(() => {
          this.initializing = false;
        }, 500);
      } catch (error) {
        this.initializingText = "加载失败";
        setTimeout(() => {
          this.initializing = false;
        }, 500);
      }
    }
  },
  mounted() {
    this.init();

    ipcRenderer.on(GLOBAL_NOTICE, (event, response) => {
      switch (response.category) {
        case "message":
          if (this.developerConfig.debug) {
            this.$message({
              message: response.message
            });
          }
          break;
        case "notification":
          this.$notify({
            type: response.type,
            title: response.title,
            message: response.message
          });
          break;
        case "alert":
          this.$alert(response.message.replace(/at /g, "<br>&nbsp;&nbsp;&nbsp;&nbsp;at "), response.title, {
            type: response.type,
            dangerouslyUseHTMLString: true,
            customClass: "wider-message-box"
          });
          break;
        default:
          break;
      }
    });
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

.wider-message-box {
  width: 50vw !important;
}
</style>
