<template>
  <el-card>
    <el-form :model="config" label-width="160px" style="width: 50%">
      <el-form-item label="打开开发者模式">
        <el-switch v-model="config.debug"> </el-switch>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" @click="store">保存</el-button>
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
    store() {
      this.storeConfig(this.config);
    }
  }
};
</script>
