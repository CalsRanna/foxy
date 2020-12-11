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
        <el-menu-item index="setting"> 设置 <small>SETTING</small> </el-menu-item>
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
import {
  UPDATE_MYSQL_CONFIG,
  UPDATE_DBC_CONFIG,
  UPDATE_CONFIG_CONFIG,
  UPDATE_DEVELOPER_CONFIG,
  SET_ACTIVE,
  SET_SETTING_ACTIVE
} from "@/store/MUTATION_TYPES";

export default {
  computed: {
    ...mapState("global", ["mysqlConfig", "dbcConfig", "configConfig", "developerConfig", "active"]),
    ...mapState("dbc", ["factions", "factionTemplates", "itemDisplayInfos", "spells", "spellDurations"])
  },
  methods: {
    ...mapActions("dbc", [
      "searchDbcFactions",
      "searchDbcFactionTemplates",
      "searchDbcItemDisplayInfos",
      "searchDbcSpells",
      "searchDbcSpellDurations"
    ]),
    ...mapMutations("global", {
      updateMysqlConfig: UPDATE_MYSQL_CONFIG,
      updateDbcConfig: UPDATE_DBC_CONFIG,
      updateConfigConfig: UPDATE_CONFIG_CONFIG,
      updateDeveloperConfig: UPDATE_DEVELOPER_CONFIG,
      setActive: SET_ACTIVE
    }),
    ...mapMutations("setting", { setSettingActive: SET_SETTING_ACTIVE }),
    navigate(index) {
      this.setActive(index);
      this.$router.push(`/${index}`).catch(error => error);
    },
    initMysqlConfig() {
      let host = localStorage.getItem("host");
      let port = localStorage.getItem("port");
      let username = localStorage.getItem("username");
      let password = localStorage.getItem("password");
      let database = localStorage.getItem("database");
      let limit = localStorage.getItem("limit");

      if (host && username && password && database) {
        this.updateMysqlConfig({
          host: host,
          port: port,
          username: username,
          password: password,
          database: database,
          limit: limit
        });
      } else {
        this.setActive("setting");
        this.setSettingActive("mysql");
        this.$router.push("/setting/mysql").catch(error => error);
      }
    },
    initDbcConfig() {
      let path = localStorage.getItem("dbcPath");

      if (path) {
        this.updateDbcConfig({
          path: path
        });
      } else {
        this.setActive("setting");
        this.setSettingActive("dbc");
        this.$router.push("/setting/dbc").catch(error => error);
      }
    },
    initConfigConfig() {
      let path = localStorage.getItem("configPath");

      if (path) {
        this.updateConfigConfig({
          path: path
        });
      } else {
        this.setActive("setting");
        this.setSettingActive("config");
        this.$router.push("/setting/config").catch(error => error);
      }
    },
    initDeveloperConfig() {
      let debug = localStorage.getItem("debug");

      this.updateDeveloperConfig({
        debug: debug === "true" ? true : false
      });
    },
    init() {
      this.initMysqlConfig();
      this.initDbcConfig();
      this.initConfigConfig();
      this.initDeveloperConfig();

      this.searchDbcFactions();
      this.searchDbcFactionTemplates();
      this.searchDbcItemDisplayInfos();
      this.searchDbcSpells();
      this.searchDbcSpellDurations();
    }
  },
  created() {
    this.init();

    ipcRenderer.on("UPDATE_MESSAGE_REPLY", (event, response) => {
      if (response.category === "notification") {
        this.$notify({
          title: response.title,
          message: response.message,
          type: response.type
        });
      } else if (response.category === "alert" && this.developerConfig.debug) {
        this.$alert(response.message.replace(/at/g, "<br>&nbsp;&nbsp;&nbsp;&nbsp;at"), response.title, {
          type: response.type,
          dangerouslyUseHTMLString: true,
          customClass: "wider-message-box"
        });
      } else {
        if (this.developerConfig.debug) {
          this.$message({
            message: response
          });
        }
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
