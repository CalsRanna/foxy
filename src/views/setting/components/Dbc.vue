<template>
  <el-card>
    <el-form :model="config" label-width="160px" style="width: 50%">
      <el-form-item label="Dbc 文件路径">
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
import { UPDATE_DBC_CONFIG } from "@/store/MUTATION_TYPES";

export default {
  computed: {
    ...mapState("global", { config: "dbcConfig" })
  },
  methods: {
    ...mapMutations("global", { storeConfig: UPDATE_DBC_CONFIG }),
    selectPath() {
      const { ipcRenderer } = window.require("electron");

      ipcRenderer.send("SELECT_DBC_PATH");
      ipcRenderer.on("SELECT_DBC_PATH_REPLY", (event, path) => {
        this.config.path = path;
      });
    },
    store() {
      this.storeConfig(this.config);
    }
  }
};
</script>
