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
import { mapState, mapMutations } from "vuex";
import { UPDATE_DEVELOPER_CONFIG } from "@/store/MUTATION_TYPES";
export default {
  computed: {
    ...mapState("global", { config: "developerConfig" })
  },
  methods: {
    ...mapMutations("global", { storeConfig: UPDATE_DEVELOPER_CONFIG }),
    handleChange(value) {
      this.storeConfig({ debug: value });
      this.$notify({
        type: "success",
        title: "成功",
        message: "修改设置成功。"
      });
    }
  }
};
</script>
