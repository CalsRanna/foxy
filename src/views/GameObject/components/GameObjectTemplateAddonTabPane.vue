<template>
  <el-form
    :model="gameObjectTemplateAddon"
    label-position="right"
    label-width="120px"
  >
    <div :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }">
      <el-card
        :body-style="{ padding: '22px 20px 0 20px' }"
        style="margin-top: 1px"
      >
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="编号">
              <el-input-number
                v-model="gameObjectTemplateAddon.entry"
                controls-position="right"
                placeholder="entry"
                v-loading="initing"
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(255, 255, 255, 0.5)"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="势力">
              <el-input-number
                v-model="gameObjectTemplateAddon.faction"
                controls-position="right"
                placeholder="faction"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="标识">
              <flag-editor
                v-model="gameObjectTemplateAddon.flags"
                :flags="flags"
                title="标识编辑器"
                placeholder="flags"
              ></flag-editor>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="最小金钱">
              <el-input-number
                v-model="gameObjectTemplateAddon.mingold"
                controls-position="right"
                placeholder="mingold"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="最大金钱">
              <el-input-number
                v-model="gameObjectTemplateAddon.maxgold"
                controls-position="right"
                placeholder="maxgold"
              ></el-input-number>
            </el-form-item>
          </el-col>
        </el-row>
      </el-card>
    </div>
    <el-card style="margin-top: 16px">
      <el-button type="primary" :loading="loading" @click="store">
        保存
      </el-button>
      <el-button @click="cancel">返回</el-button>
    </el-card>
  </el-form>
</template>

<script>
import { flags } from "@/locales/gameObject";

import FlagEditor from "@/components/FlagEditor";

import { mapState, mapActions } from "vuex";

export default {
  data() {
    return {
      initing: false,
      loading: false,
      creating: false,
      flags: flags,
    };
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("gameObjectTemplate", ["gameObjectTemplate"]),
    ...mapState("gameObjectTemplateAddon", ["gameObjectTemplateAddon"]),
    credential() {
      return {
        entry: this.gameObjectTemplate.entry,
      };
    },
  },
  methods: {
    ...mapActions("gameObjectTemplateAddon", [
      "storeGameObjectTemplateAddon",
      "findGameObjectTemplateAddon",
      "updateGameObjectTemplateAddon",
      "createGameObjectTemplateAddon",
    ]),
    calculateMaxHeight() {
      return this.clientHeight - 307;
    },
    async store() {
      this.loading = true;
      if (this.creating) {
        await this.storeGameObjectTemplateAddon(this.gameObjectTemplateAddon);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateGameObjectTemplateAddon({
          credential: this.credential,
          gameObjectTemplateAddon: this.gameObjectTemplateAddon,
        });
        this.$notify({
          title: "修改成功",
          position: "bottom-left",
          type: "success",
        });
      }
      this.loading = false;
    },
    cancel() {
      this.$router.go(-1);
    },
    async init() {
      this.initing = true;
      await this.findGameObjectTemplateAddon({
        entry: this.gameObjectTemplate.entry,
      });
      if (this.gameObjectTemplateAddon.entry == undefined) {
        this.creating = true;
        await this.createGameObjectTemplateAddon({
          entry: this.gameObjectTemplate.entry,
        });
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: {
    FlagEditor,
  },
};
</script>
