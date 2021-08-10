<template>
  <el-form
    :model="creatureOnKillReputation"
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
                v-model="creatureOnKillReputation.creature_id"
                controls-position="right"
                placeholder="creature_id"
                :disabled="initing"
                v-loading="initing"
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(255, 255, 255, 0.5)"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="势力1">
              <faction-template-selector
                v-model="creatureOnKillReputation.RewOnKillRepFaction1"
                placeholder="RewOnKillRepFaction1"
              ></faction-template-selector>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="势力2">
              <faction-template-selector
                v-model="creatureOnKillReputation.RewOnKillRepFaction2"
                placeholder="RewOnKillRepFaction2"
              ></faction-template-selector>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="区分阵营">
              <el-switch
                v-model="creatureOnKillReputation.TeamDependent"
                :active-value="1"
                :inactive-value="0"
              ></el-switch>
            </el-form-item>
          </el-col>
          <el-col :span="6" :offset="6">
            <el-form-item label="声望值1">
              <el-input-number
                v-model="creatureOnKillReputation.RewOnKillRepValue1"
                controls-position="right"
                placeholder="RewOnKillRepValue1"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="声望值2">
              <el-input-number
                v-model="creatureOnKillReputation.RewOnKillRepValue2"
                controls-position="right"
                placeholder="RewOnKillRepValue2"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6" :offset="6">
            <el-form-item label="最高声望等级1">
              <el-select
                v-model="creatureOnKillReputation.MaxStanding1"
                placeholder="MaxStanding1"
              >
                <el-option
                  v-for="maxStanding in maxStandings"
                  :key="`maxStanding1-${maxStanding.value}`"
                  :value="maxStanding.value"
                  :label="maxStanding.label"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="最高声望等级2">
              <el-select
                v-model="creatureOnKillReputation.MaxStanding2"
                placeholder="MaxStanding2"
              >
                <el-option
                  v-for="maxStanding in maxStandings"
                  :key="`maxStanding2-${maxStanding.value}`"
                  :value="maxStanding.value"
                  :label="maxStanding.label"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="6" :offset="6">
            <el-form-item label="包括声望组1">
              <el-switch
                v-model="creatureOnKillReputation.IsTeamAward1"
                :active-value="1"
                :inactive-value="0"
              ></el-switch>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="包括声望组2">
              <el-switch
                v-model="creatureOnKillReputation.IsTeamAward2"
                :active-value="1"
                :inactive-value="0"
              ></el-switch>
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
import { maxStandings } from "@/locales/creature";

import { mapState, mapActions } from "vuex";
import FactionTemplateSelector from "../../../components/FactionTemplateSelector.vue";

export default {
  data() {
    return {
      initing: false,
      loading: false,
      creating: false,
      maxStandings: maxStandings,
    };
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("creatureTemplate", ["creatureTemplate"]),
    ...mapState("creatureOnKillReputation", ["creatureOnKillReputation"]),
    credential() {
      return {
        creature_id: this.creatureTemplate.entry,
      };
    },
  },
  methods: {
    ...mapActions("creatureOnKillReputation", [
      "storeCreatureOnKillReputation",
      "findCreatureOnKillReputation",
      "updateCreatureOnKillReputation",
      "createCreatureOnKillReputation",
    ]),
    calculateMaxHeight() {
      return this.clientHeight - 307;
    },
    async store() {
      this.loading = true;
      try {
        if (this.creating) {
          await this.storeCreatureOnKillReputation(
            this.creatureOnKillReputation
          );
          this.$notify({
            title: "保存成功",
            position: "bottom-left",
            type: "success",
          });
          this.creating = false;
        } else {
          await this.updateCreatureOnKillReputation({
            credential: this.credential,
            creatureOnKillReputation: this.creatureOnKillReputation,
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
      await this.findCreatureOnKillReputation(this.credential);
      if (this.creatureOnKillReputation.creature_id == undefined) {
        this.creating = true;
        await this.createCreatureOnKillReputation(this.credential);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: { FactionTemplateSelector },
};
</script>
