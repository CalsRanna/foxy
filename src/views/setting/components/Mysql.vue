<template>
  <el-card>
    <el-form :model="config" label-width="160px" style="width: 50%">
      <el-form-item label="主机地址">
        <el-input v-model="config.host"></el-input>
      </el-form-item>
      <el-form-item label="端口">
        <el-input v-model="config.port"></el-input>
      </el-form-item>
      <el-form-item label="用户名">
        <el-input v-model="config.username"></el-input>
      </el-form-item>
      <el-form-item label="密码">
        <el-input v-model="config.password"></el-input>
      </el-form-item>
      <el-form-item label="数据库">
        <el-input v-model="config.database"></el-input>
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
