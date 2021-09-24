<template>
  <el-form :model="condition" label-position="right" label-width="120px">
    <div :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }">
      <el-card
        :body-style="{ padding: '22px 20px 0 20px' }"
        style="margin-top: 1px"
      >
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="源类型/关联">
              <el-select
                v-model="condition.SourceTypeOrReferenceId"
                filterable
                placeholder="SourceTypeOrReferenceId"
              >
                <el-option
                  v-for="(sourceType, index) in sourceTypes"
                  :key="`sourceType-${index}`"
                  :value="index"
                  :label="sourceType"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="SourceGroup">
              <el-input
                v-model="condition.SourceGroup"
                placeholder="SourceGroup"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="SourceEntry">
              <el-input-number
                v-model="condition.SourceEntry"
                controls-position="right"
                placeholder="SourceEntry"
                v-loading="initing"
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(255, 255, 255, 0.5)"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="SourceId">
              <el-input-number
                v-model="condition.SourceId"
                controls-position="right"
                placeholder="SourceId"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="ElseGroup">
              <el-input-number
                v-model="condition.ElseGroup"
                controls-position="right"
                placeholder="ElseGroup"
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
            <el-form-item label="条件类型/关联">
              <el-select
                v-model="condition.ConditionTypeOrReference"
                filterable
                placeholder="ConditionTypeOrReference"
              >
                <el-option
                  v-for="(conditionType, index) in conditionTypes"
                  :key="`conditionType-${index}`"
                  :value="index"
                  :label="conditionType"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="ConditionTarget">
              <el-input-number
                v-model="condition.ConditionTarget"
                controls-position="right"
                placeholder="ConditionTarget"
              ></el-input-number>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="ConditionValue1">
              <el-input-number
                v-model="condition.ConditionValue1"
                controls-position="right"
                placeholder="ConditionValue1"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="ConditionValue2">
              <el-input-number
                v-model="condition.ConditionValue2"
                controls-position="right"
                placeholder="ConditionValue2"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="ConditionValue3">
              <el-input-number
                v-model="condition.ConditionValue3"
                controls-position="right"
                placeholder="ConditionValue3"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="NegativeCondition">
              <el-input-number
                v-model="condition.NegativeCondition"
                controls-position="right"
                placeholder="NegativeCondition"
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
            <el-form-item label="错误类型">
              <el-input-number
                v-model="condition.ErrorType"
                controls-position="right"
                placeholder="ErrorType"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="错误文本编号">
              <el-input-number
                v-model="condition.ErrorTextId"
                controls-position="right"
                placeholder="ErrorTextId"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="脚本名称">
              <el-input
                v-model="condition.ScriptName"
                placeholder="ScriptName"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="注解">
              <el-input
                v-model="condition.Comment"
                placeholder="Comment"
              ></el-input>
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
import { mapActions, mapState } from "vuex";
import { sourceTypes, conditionTypes } from "@/locales/condition.js";

export default {
  data() {
    return {
      initing: false,
      loading: false,
      creating: false,
      sourceTypes: sourceTypes,
      conditionTypes: conditionTypes,
    };
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("condition", ["condition"]),
    credential() {
      return {
        SourceTypeOrReferenceId: this.$route.params.id,
        SourceGroup: this.$route.query.SourceGroup,
        SourceEntry: this.$route.query.SourceEntry,
        SourceId: this.$route.query.SourceId,
        ElseGroup: this.$route.query.ElseGroup,
        ConditionTypeOrReference: this.$route.query.ConditionTypeOrReference,
        ConditionTarget: this.$route.query.ConditionTarget,
        ConditionValue1: this.$route.query.ConditionValue1,
        ConditionValue2: this.$route.query.ConditionValue2,
        ConditionValue3: this.$route.query.ConditionValue3,
      };
    },
  },
  methods: {
    ...mapActions("condition", [
      "storeCondition",
      "findCondition",
      "updateCondition",
      "createCondition",
    ]),
    calculateMaxHeight() {
      return this.clientHeight - 307;
    },
    async store() {
      this.loading = true;
      if (this.creating) {
        this.storeCondition(this.condition);
        this.$notify({
          title: "保存成功",
          position: "top-right",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateCondition({
          credential: this.credential,
          condition: this.condition,
        });
        this.$notify({
          title: "修改成功",
          position: "top-right",
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
      if (this.$route.path == "/condition/create") {
        this.creating = true;
        await Promise.all([this.createCondition()]);
      } else {
        await this.findCondition(this.credential);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
};
</script>
