<template>
  <el-form
    :model="scalingStatDistribution"
    label-position="right"
    label-width="120px"
  >
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="编号">
            <el-input-number
              v-model="scalingStatDistribution.ID"
              controls-position="right"
              placeholder="ID"
              v-loading="initing"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="最大等级">
            <el-input-number
              v-model="scalingStatDistribution.Maxlevel"
              controls-position="right"
              placeholder="Maxlevel"
              v-loading="initing"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="属性">
            <el-select
              v-model="scalingStatDistribution.StatID_1"
              filterable
              placeholder="action_type"
            >
              <el-option
                v-for="(localeStatType, index) in localeStatTypes"
                :key="`StatID_1-${index}`"
                :label="localeStatType"
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="系数">
            <el-input-number
              v-model="scalingStatDistribution.Bonus_1"
              controls-position="right"
              placeholder="Bonus_1"
              v-loading="initing"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="属性">
            <el-select
              v-model="scalingStatDistribution.StatID_2"
              filterable
              placeholder="action_type"
            >
              <el-option
                v-for="(localeStatType, index) in localeStatTypes"
                :key="`StatID_2-${index}`"
                :label="localeStatType"
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="系数">
            <el-input-number
              v-model="scalingStatDistribution.Bonus_2"
              controls-position="right"
              placeholder="Bonus_2"
              v-loading="initing"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="属性">
            <el-select
              v-model="scalingStatDistribution.StatID_3"
              filterable
              placeholder="action_type"
            >
              <el-option
                v-for="(localeStatType, index) in localeStatTypes"
                :key="`StatID_3-${index}`"
                :label="localeStatType"
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="系数">
            <el-input-number
              v-model="scalingStatDistribution.Bonus_3"
              controls-position="right"
              placeholder="Bonus_3"
              v-loading="initing"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="属性">
            <el-select
              v-model="scalingStatDistribution.StatID_4"
              filterable
              placeholder="action_type"
            >
              <el-option
                v-for="(localeStatType, index) in localeStatTypes"
                :key="`StatID_4-${index}`"
                :label="localeStatType"
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="系数">
            <el-input-number
              v-model="scalingStatDistribution.Bonus_4"
              controls-position="right"
              placeholder="Bonus_4"
              v-loading="initing"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="属性">
            <el-select
              v-model="scalingStatDistribution.StatID_5"
              filterable
              placeholder="action_type"
            >
              <el-option
                v-for="(localeStatType, index) in localeStatTypes"
                :key="`StatID_5-${index}`"
                :label="localeStatType"
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="系数">
            <el-input-number
              v-model="scalingStatDistribution.Bonus_5"
              controls-position="right"
              placeholder="Bonus_5"
              v-loading="initing"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="属性">
            <el-select
              v-model="scalingStatDistribution.StatID_6"
              filterable
              placeholder="action_type"
            >
              <el-option
                v-for="(localeStatType, index) in localeStatTypes"
                :key="`StatID_6-${index}`"
                :label="localeStatType"
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="系数">
            <el-input-number
              v-model="scalingStatDistribution.Bonus_6"
              controls-position="right"
              placeholder="Bonus_6"
              v-loading="initing"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="属性">
            <el-select
              v-model="scalingStatDistribution.StatID_7"
              filterable
              placeholder="action_type"
            >
              <el-option
                v-for="(localeStatType, index) in localeStatTypes"
                :key="`StatID_7-${index}`"
                :label="localeStatType"
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="系数">
            <el-input-number
              v-model="scalingStatDistribution.Bonus_7"
              controls-position="right"
              placeholder="Bonus_7"
              v-loading="initing"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="属性">
            <el-select
              v-model="scalingStatDistribution.StatID_8"
              filterable
              placeholder="action_type"
            >
              <el-option
                v-for="(localeStatType, index) in localeStatTypes"
                :key="`StatID_8-${index}`"
                :label="localeStatType"
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="系数">
            <el-input-number
              v-model="scalingStatDistribution.Bonus_8"
              controls-position="right"
              placeholder="Bonus_8"
              v-loading="initing"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="属性">
            <el-select
              v-model="scalingStatDistribution.StatID_9"
              filterable
              placeholder="action_type"
            >
              <el-option
                v-for="(localeStatType, index) in localeStatTypes"
                :key="`StatID_9-${index}`"
                :label="localeStatType"
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="系数">
            <el-input-number
              v-model="scalingStatDistribution.Bonus_9"
              controls-position="right"
              placeholder="Bonus_9"
              v-loading="initing"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="属性">
            <el-select
              v-model="scalingStatDistribution.StatID_10"
              filterable
              placeholder="action_type"
            >
              <el-option
                v-for="(localeStatType, index) in localeStatTypes"
                :key="`StatID_10-${index}`"
                :label="localeStatType"
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="系数">
            <el-input-number
              v-model="scalingStatDistribution.Bonus_10"
              controls-position="right"
              placeholder="Bonus_10"
              v-loading="initing"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
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
import { mapActions, mapState } from "vuex";

import { localeStatTypes } from "@/locales/item";

export default {
  data() {
    return {
      initing: false,
      loading: false,
      creating: false,
      localeStatTypes: localeStatTypes,
    };
  },
  computed: {
    ...mapState("scalingStatDistribution", ["scalingStatDistribution"]),
    credential() {
      return {
        ID: this.$route.params.id,
      };
    },
  },
  methods: {
    ...mapActions("scalingStatDistribution", [
      "storeScalingStatDistribution",
      "findScalingStatDistribution",
      "updateScalingStatDistribution",
      "createScalingStatDistribution",
    ]),
    async store() {
      this.loading = true;
      if (this.creating) {
        this.storeScalingStatDistribution(this.scalingStatDistribution);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateScalingStatDistribution({
          credential: this.credential,
          scalingStatDistribution: this.scalingStatDistribution,
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
      if (this.$route.path == "/scaling-stat-distribution/create") {
        this.creating = true;
        await Promise.all([this.createScalingStatDistribution()]);
      } else {
        await this.findScalingStatDistribution(this.credential);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
};
</script>
