<template>
  <el-card>
    <el-form :model="config" label-width="160px" style="width: 50%">
      <el-form-item label="配置文件路径">
        <el-input v-model="config.host">
          <el-button slot="append">选择路径</el-button>
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
import { UPDATE_MYSQL_CONFIG } from "@/store/MUTATION_TYPES";
export default {
  computed: {
    ...mapState("global", { config: "mysqlConfig" })
  },
  methods: {
    ...mapMutations("global", { storeConfig: UPDATE_MYSQL_CONFIG }),
    store() {
      this.storeConfig(this.config);
    }
  }
};
</script>
