<template>
  <div>
    <el-card :body-style="{ padding: '22px 20px 0 20px' }">
      <el-form :model="developerConfig" label-width="160px" style="width: 50%">
        <el-form-item label="打开开发者模式">
          <el-switch v-model="developerConfig.debug" @change="handleChange">
          </el-switch>
        </el-form-item>
      </el-form>
    </el-card>
    <div v-if="developerConfig.debug === true">
      <el-card
        :body-style="{ padding: '22px 20px 0 20px' }"
        style="margin-top: 16px"
      >
        <div slot="header">
          高级配置
          <el-tooltip
            content="如果不是很确定以下配置项代表的意义，请不要随意更改"
            placement="right"
          >
            <i class="el-icon-info"></i>
          </el-tooltip>
        </div>
        <el-form :model="advanceConfig" label-width="120px">
          <el-row :gutter="16">
            <el-col :span="8">
              <el-form-item label="分页大小">
                <el-input-number
                  v-model="advanceConfig.size"
                  controls-position="right"
                  :min="5"
                  :max="100"
                  placeholder="size"
                >
                </el-input-number>
              </el-form-item>
            </el-col>
          </el-row>
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
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
export default {
  data() {
    return {
      loading: false,
    };
  },
  computed: {
    ...mapState("initiator", ["developerConfig", "advanceConfig"]),
  },
  methods: {
    ...mapActions("initiator", ["storeDeveloperConfig", "storeAdvanceConfig"]),
    handleChange(value) {
      this.storeDeveloperConfig({ debug: value });
      this.$notify({
        title: value === true ? "打开开发者模式" : "关闭开发者模式",
        position: "top-right",
        type: "success",
      });
    },
    async store() {
      this.loading = true;
      try {
        await Promise.all([this.storeAdvanceConfig(this.advanceConfig)]);
        this.loading = false;
        this.$notify({
          title: "保存成功",
          position: "top-right",
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
