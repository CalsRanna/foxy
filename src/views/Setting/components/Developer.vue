<template>
  <el-card>
    <el-form :model="config" label-width="160px" style="width: 50%">
      <el-form-item label="打开开发者模式">
        <el-switch v-model="config.debug" @change="handleChange"> </el-switch>
      </el-form-item>
    </el-form>
  </el-card>
</template>

<script>
import { mapState, mapActions } from "vuex";
export default {
  computed: {
    ...mapState("initiator", { config: "developerConfig" }),
  },
  methods: {
    ...mapActions("initiator", ["storeDeveloperConfig"]),
    handleChange(value) {
      this.storeDeveloperConfig({ debug: value });
      this.$notify({
        title: value === true ? "打开开发者模式" : "关闭开发者模式",
        position: "bottom-left",
        type: "success",
      });
    },
  },
};
</script>
