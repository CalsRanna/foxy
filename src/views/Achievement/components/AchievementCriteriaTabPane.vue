<template>
  <el-form
    :model="achievementCriteria"
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
                v-model="achievementCriteria.ID"
                controls-position="right"
                placeholder="ID"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="成就">
              <achievement-selector
                v-model="achievementCriteria.Achievement_Id"
                placeholder="Achievement_Id"
              />
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="描述">
              <el-input
                v-model="achievementCriteria.Description_Lang_zhCN"
                placeholder="Description_Lang_zhCN"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="描述掩码">
              <el-input-number
                v-model="achievementCriteria.Description_Lang_Mask"
                controls-position="right"
                placeholder="Description_Lang_Mask"
              ></el-input-number>
            </el-form-item>
          </el-col>
        </el-row>
      </el-card>
      <el-card
        :body-style="{ padding: '22px 20px 0 20px' }"
        style="margin-top: 16px"
      >
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="标识">
              <el-input-number
                v-model="achievementCriteria.Flags"
                controls-position="right"
                placeholder="Flags"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="顺序">
              <el-input-number
                v-model="achievementCriteria.Ui_Order"
                controls-position="right"
                placeholder="Ui_Order"
              ></el-input-number>
            </el-form-item>
          </el-col>
        </el-row>
      </el-card>
      <el-card
        :body-style="{ padding: '22px 20px 0 20px' }"
        style="margin-top: 16px"
      >
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="类别">
              <el-select
                v-model="achievementCriteria.Type"
                placeholder="Type"
                filterable
              >
                <el-option
                  v-for="(type, index) in types"
                  :key="`type-${index}`"
                  :value="index"
                  :label="type"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col
            :span="6"
            v-for="(criteria, index) in matchedCriterias"
            :key="`criteria-${index}`"
          >
            <el-form-item :label="criteria.label">
              <el-switch
                v-model="achievementCriteria[criteria.field]"
                :active-value="1"
                :inactive-value="0"
                v-if="criteria.type === 'el-switch'"
              ></el-switch>
              <el-input-number
                v-model="achievementCriteria[criteria.field]"
                controls-position="right"
                :placeholder="criteria.field"
                v-else-if="criteria.type === 'el-input-number'"
              ></el-input-number>
              <map-selector
                v-model="achievementCriteria[criteria.field]"
                :placeholder="criteria.field"
                v-else-if="criteria.type === 'map-selector'"
              ></map-selector>
              <faction-selector
                v-model="achievementCriteria[criteria.field]"
                :placeholder="criteria.field"
                v-else-if="criteria.type === 'faction-selector'"
              />
              <quest-template-selector
                v-model="achievementCriteria[criteria.field]"
                :placeholder="criteria.field"
                v-else-if="criteria.type === 'quest-template-selector'"
              />
              <spell-selector
                v-model="achievementCriteria[criteria.field]"
                :placeholder="criteria.field"
                v-else-if="criteria.type === 'spell-selector'"
              ></spell-selector>
              <el-input
                v-model="achievementCriteria[criteria.field]"
                :placeholder="criteria.field"
                v-else
              ></el-input>
            </el-form-item>
          </el-col>
        </el-row>
      </el-card>
      <el-card
        :body-style="{ padding: '22px 20px 0 20px' }"
        style="margin-top: 16px"
      >
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item>
              <hint-label
                label="开始事件"
                :tooltip="timerStartEventTooltip"
                slot="label"
              />
              <el-input-number
                v-model="achievementCriteria.Timer_Start_Event"
                controls-position="right"
                placeholder="Timer_Start_Event"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item>
              <hint-label
                label="要求"
                :tooltip="timerAssetIdTooltip"
                slot="label"
              />
              <el-input-number
                v-model="achievementCriteria.Timer_Asset_Id"
                controls-position="right"
                placeholder="Timer_Asset_Id"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="计时器时间">
              <el-input-number
                v-model="achievementCriteria.Timer_Time"
                controls-position="right"
                placeholder="Timer_Time"
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
import {
  types,
  criterias,
  timerStartEventTooltip,
  timerAssetIdTooltip,
} from "@/locales/achievement";

import { mapState, mapActions } from "vuex";
import AchievementSelector from "@/components/AchievementSelector";
import FactionSelector from "@/components/FactionSelector";
import HintLabel from "@/components/HintLabel";
import ItemTemplateSelector from "@/components/ItemTemplateSelector";
import MapSelector from "@/components/MapSelector";
import QuestTemplateSelector from "@/components/QuestTemplateSelector";
import SpellSelector from "@/components/SpellSelector";
import WaypointDataSelector from "@/components/WaypointDataSelector";

export default {
  data() {
    return {
      types: types,
      criterias: criterias,
      timerStartEventTooltip: timerStartEventTooltip,
      timerAssetIdTooltip: timerAssetIdTooltip,
      initing: false,
      loading: false,
      creating: false,
    };
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("achievement", ["achievement"]),
    ...mapState("achievementCriteria", ["achievementCriteria"]),
    matchedCriterias() {
      return this.achievementCriteria.Type >= 0
        ? this.criterias[this.achievementCriteria.Type]
        : this.criterias[0];
    },
    credential() {
      return {
        ID: this.achievementCriteria.ID,
      };
    },
  },
  methods: {
    ...mapActions("achievementCriteria", [
      "storeAchievementCriteria",
      "findAchievementCriteria",
      "updateAchievementCriteria",
      "createAchievementCriteria",
    ]),
    calculateMaxHeight() {
      return this.clientHeight - 307;
    },
    async store() {
      this.loading = true;
      try {
        if (this.creating) {
          await this.storeAchievementCriteria(this.achievementCriteria);
          this.$notify({
            title: "保存成功",
            position: "top-right",
            type: "success",
          });
          this.creating = false;
        } else {
          await this.updateAchievementCriteria({
            credential: this.credential,
            achievementCriteria: this.achievementCriteria,
          });
          this.$notify({
            title: "修改成功",
            position: "top-right",
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
      await this.findAchievementCriteria({
        Achievement_Id: this.achievement.ID,
      });
      if (this.achievementCriteria.ID == undefined) {
        this.creating = true;
        await this.createAchievementCriteria({
          Achievement_Id: this.achievement.ID,
        });
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: {
    HintLabel,
    AchievementSelector,
    FactionSelector,
    ItemTemplateSelector,
    MapSelector,
    QuestTemplateSelector,
    SpellSelector,
    WaypointDataSelector,
  },
};
</script>
