<template>
  <el-card>
    <el-form :model="config" label-width="160px" style="width: 50%">
      <el-form-item label="主机地址">
        <el-input v-model="config.host"></el-input>
      </el-form-item>
      <el-form-item label="用户名">
        <el-input v-model="config.user"></el-input>
      </el-form-item>
      <el-form-item label="密码">
        <el-input v-model="config.password"></el-input>
      </el-form-item>
      <el-form-item label="数据库">
        <el-input v-model="config.database"></el-input>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="store" :loading="loading">保存</el-button>
        <el-button @click="test" :loading="loading">测试</el-button>
      </el-form-item>
    </el-form>
  </el-card>
</template>

<script>
import { mapState, mapActions } from "vuex";

export default {
  data() {
    return {
      loading: false
    };
  },
  computed: {
    ...mapState("global", { config: "mysqlConfig" })
  },
  methods: {
    ...mapActions("global", ["testMysqlConfig", "storeMysqlConfig"]),
    async store() {
      this.loading = true;
      await this.storeMysqlConfig(this.config);
      this.loading = false;
    },
    async test() {
      this.loading = true;
      await this.testMysqlConfig(this.config);
      this.loading = false;
    }
  }
};
</script>
