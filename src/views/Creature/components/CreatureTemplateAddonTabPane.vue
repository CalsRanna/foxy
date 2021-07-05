<template>
  <el-form
    :model="creatureTemplateAddon"
    label-position="right"
    label-width="120px"
  >
    <el-card
      :body-style="{ padding: '22px 20px 0 20px' }"
      style="margin-top: 16px"
    >
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="编号">
            <el-input-number
              v-model="creatureTemplateAddon.entry"
              controls-position="right"
              placeholder="entry"
              :disabled="initing"
              v-loading="initing"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="路径ID">
            <waypoint-data-selector
              v-model="creatureTemplateAddon.path_id"
              placeholder="path_id"
            ></waypoint-data-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="坐骑编号">
            <el-input-number
              v-model="creatureTemplateAddon.mount"
              controls-position="right"
              placeholder="mount"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="表情">
            <el-input-number
              v-model="creatureTemplateAddon.emote"
              controls-position="right"
              placeholder="emote"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="覆盖标识1">
            <el-input-number
              v-model="creatureTemplateAddon.bytes1"
              controls-position="right"
              placeholder="bytes1"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="覆盖标识2">
            <el-input-number
              v-model="creatureTemplateAddon.bytes2"
              controls-position="right"
              placeholder="bytes2"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="光环列表">
            <el-input
              v-model="creatureTemplateAddon.auras"
              placeholder="auras"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="更大可视范围">
            <el-switch
              v-model="creatureTemplateAddon.isLarge"
              :active-value="1"
              :inactive-value="0"
            ></el-switch>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-button type="primary" :loading="loading" @click="store">
        保存
      </el-button>
      <el-button @click="cancel">返回</el-button>
    </el-card>
  </el-form>
</template>

<script>
import { mapState, mapActions } from "vuex";
import WaypointDataSelector from "@/components/WaypointDataSelector.vue";

export default {
  data() {
    return {
      initing: false,
      loading: false,
      creating: false,
    };
  },
  computed: {
    ...mapState("creatureTemplate", ["creatureTemplate"]),
    ...mapState("creatureTemplateAddon", ["creatureTemplateAddon"]),
    credential() {
      return {
        entry: this.creatureTemplate.entry,
      };
    },
  },
  methods: {
    ...mapActions("creatureTemplateAddon", [
      "storeCreatureTemplateAddon",
      "findCreatureTemplateAddon",
      "updateCreatureTemplateAddon",
      "createCreatureTemplateAddon",
    ]),
    async store() {
      this.loading = true;
      try {
        if (this.creating) {
          await this.storeCreatureTemplateAddon(this.creatureTemplateAddon);
          this.$notify({
            title: "保存成功",
            position: "bottom-left",
            type: "success",
          });
          this.creating = false;
        } else {
          await this.updateCreatureTemplateAddon({
            credential: this.credential,
            creatureTemplateAddon: this.creatureTemplateAddon,
          });
          this.$notify({
            title: "修改成功",
            position: "bottom-left",
            type: "success",
          });
        }
        this.loading = false;
      } catch (error) {
        this.loading = false;
      }
    },
    cancel() {
      this.$router.go(-1);
    },
    async init() {
      this.initing = true;
      await this.findCreatureTemplateAddon({
        entry: this.creatureTemplate.entry,
      });
      if (this.creatureTemplateAddon.entry == undefined) {
        this.creating = true;
        await this.createCreatureTemplateAddon({
          entry: this.creatureTemplate.entry,
        });
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: { WaypointDataSelector },
};
</script>
