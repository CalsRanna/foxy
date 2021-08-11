<template>
  <div>
    <el-card :body-style="{ padding: '22px 20px 0 20px' }">
      <div slot="header">
        数据库配置
        <el-tooltip content="当前只支持AzerothCore数据库" placement="right">
          <i class="el-icon-info"></i>
        </el-tooltip>
        <el-button
          size="mini"
          style="float: right"
          :loading="loading"
          @click="test"
        >
          测试连接
        </el-button>
      </div>
      <el-form :model="mysqlConfig" label-width="120px">
        <el-row :gutter="16">
          <el-col :span="8">
            <el-form-item label="主机地址">
              <el-input v-model="mysqlConfig.host"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="用户名">
              <el-input v-model="mysqlConfig.user"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="密码">
              <el-input v-model="mysqlConfig.password"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="数据库">
              <el-input v-model="mysqlConfig.database"></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="8">
            <el-form-item label="端口">
              <el-input
                v-model="mysqlConfig.port"
                placeholder="3306"
              ></el-input>
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
    </el-card>
    <el-card
      :body-style="{ padding: '22px 20px 0 20px' }"
      style="margin-top: 16px"
    >
      <div slot="header">
        DBC配置
        <el-tooltip content="当前只支持3.3.5版本的DBC文件" placement="right">
          <i class="el-icon-info"></i>
        </el-tooltip>
      </div>
      <el-form :model="dbcConfig" label-width="120px">
        <el-form-item label="dbc 文件路径">
          <el-input v-model="dbcConfig.path">
            <el-button slot="append" @click="selectDbcPath">选择路径</el-button>
          </el-input>
        </el-form-item>
      </el-form>
    </el-card>
    <el-button
      type="primary"
      style="margin-top: 16px"
      @click="store"
      :loading="loading"
    >
      保存
    </el-button>
  </div>
</template>

<script>
const ipcRenderer = window.ipcRenderer;

import { mapState, mapActions } from "vuex";

export default {
  data() {
    return {
      loading: false,
    };
  },
  computed: {
    ...mapState("initiator", ["mysqlConfig", "dbcConfig"]),
  },
  methods: {
    ...mapActions("initiator", [
      "testMysqlConnection",
      "storeMysqlConfig",
      "storeDbcConfig",
    ]),
    selectDbcPath() {
      ipcRenderer.send("SELECT_DBC_PATH");
      ipcRenderer.on("SELECT_DBC_PATH_REPLY", (event, path) => {
        this.dbcConfig.path = path;
      });
    },
    async test() {
      this.loading = true;
      try {
        await this.testMysqlConnection(this.mysqlConfig);
        this.$notify({
          title: "连接成功",
          position: "bottom-left",
          type: "success",
        });
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
    },
    async store() {
      this.loading = true;
      try {
        await Promise.all([
          this.storeMysqlConfig(this.mysqlConfig),
          this.storeDbcConfig(this.dbcConfig),
        ]);
        this.loading = false;
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
        ipcRenderer.send("RELOAD_APP");
      } catch (error) {
        this.loading = false;
      }
    },
  },
};
</script>
