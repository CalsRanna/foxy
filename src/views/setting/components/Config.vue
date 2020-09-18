<template>
  <el-card>
    <el-form :model="config" label-width="160px" style="width: 50%">
      <el-form-item label="配置文件路径">
        <el-input v-model="config.path">
          <el-button slot="append" @click="selectPath">选择路径</el-button>
        </el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="store">保存</el-button>
      </el-form-item>
    </el-form>
  </el-card>
</template>

<script>
import { mapState, mapMutations } from "vuex";
import { UPDATE_CONFIG_CONFIG } from "@/store/MUTATION_TYPES";

export default {
  computed: {
    ...mapState("global", { config: "configConfig" })
  },
  methods: {
    ...mapMutations("global", { storeConfig: UPDATE_CONFIG_CONFIG }),
    selectPath() {
      const { ipcRenderer } = window.require("electron");

      ipcRenderer.send("SELECT_CONFIG_PATH");
      ipcRenderer.on("SELECT_CONFIG_PATH_REPLY", (event, path) => {
        console.log(path);
        this.config.path = path;
      });
    },
    store() {
      if (this.config.path === "") {
        this.$notify({
          type: "error",
          title: "失败",
          message: "dbc 文件路径不能为空。"
        });
      } else {
        this.storeConfig(this.config);
        this.$notify({
          type: "success",
          title: "成功",
          message: "修改设置成功。"
        });
      }
    }
  }
};
</script>
