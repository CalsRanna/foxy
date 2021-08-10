<template>
  <el-form :model="smartScript" label-position="right" label-width="120px">
    <div :style="{ maxHeight: `${calculateMaxHeight()}px`, overflow: 'auto' }">
      <el-card
        :body-style="{ padding: '22px 20px 0 20px' }"
        style="margin-top: 1px"
      >
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="entryorguid">
              <el-input-number
                v-model="smartScript.entryorguid"
                controls-position="right"
                placeholder="entryorguid"
                v-loading="initing"
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(255, 255, 255, 0.5)"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="source_type">
              <el-select
                v-model="smartScript.source_type"
                filterable
                placeholder="source_type"
              >
                <el-option
                  v-for="index in [0, 1, 2, 9]"
                  :key="`sourceType-${index}`"
                  :label="sourceTypes[index]"
                  :value="index"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="id">
              <el-input-number
                v-model="smartScript.id"
                controls-position="right"
                placeholder="id"
                v-loading="initing"
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(255, 255, 255, 0.5)"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="link">
              <el-input-number
                v-model="smartScript.link"
                controls-position="right"
                placeholder="link"
                v-loading="initing"
                element-loading-spinner="el-icon-loading"
                element-loading-background="rgba(255, 255, 255, 0.5)"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="comment">
              <el-input
                v-model="smartScript.comment"
                placeholder="comment"
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
            <el-form-item label="事件">
              <el-select
                v-model="smartScript.event_type"
                filterable
                placeholder="event_type"
              >
                <el-option
                  v-for="(eventType, index) in eventTypes"
                  :key="`eventType-${index}`"
                  :label="eventType"
                  :value="index"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="几率">
              <el-input-number
                v-model="smartScript.event_chance"
                controls-position="right"
                placeholder="event_chance"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="标识">
              <el-input
                v-model="smartScript.event_flags"
                placeholder="event_flags"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="event_phase_mask">
              <el-input
                v-model="smartScript.event_phase_mask"
                placeholder="event_phase_mask"
              ></el-input>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="参数1">
              <el-input-number
                v-model="smartScript.event_param1"
                controls-position="right"
                placeholder="event_param1"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="参数2">
              <el-input-number
                v-model="smartScript.event_param2"
                controls-position="right"
                placeholder="event_param2"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="参数3">
              <el-input-number
                v-model="smartScript.event_param3"
                controls-position="right"
                placeholder="event_param3"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="参数4">
              <el-input-number
                v-model="smartScript.event_param4"
                controls-position="right"
                placeholder="event_param4"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="参数5">
              <el-input-number
                v-model="smartScript.event_param5"
                controls-position="right"
                placeholder="event_param5"
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
            <el-form-item label="动作">
              <el-select
                v-model="smartScript.action_type"
                filterable
                placeholder="action_type"
              >
                <el-option
                  v-for="(actionType, index) in actionTypes"
                  :key="`actionType-${index}`"
                  :label="actionType"
                  :value="index"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="参数1">
              <el-input-number
                v-model="smartScript.action_param1"
                controls-position="right"
                placeholder="action_param1"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="参数2">
              <el-input-number
                v-model="smartScript.action_param2"
                controls-position="right"
                placeholder="action_param2"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="参数3">
              <el-input-number
                v-model="smartScript.action_param3"
                controls-position="right"
                placeholder="action_param3"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="参数4">
              <el-input-number
                v-model="smartScript.action_param4"
                controls-position="right"
                placeholder="action_param4"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="参数5">
              <el-input-number
                v-model="smartScript.action_param5"
                controls-position="right"
                placeholder="action_param5"
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
            <el-form-item label="目标">
              <el-select
                v-model="smartScript.target_type"
                filterable
                placeholder="target_type"
              >
                <el-option
                  v-for="(targetType, index) in targetTypes"
                  :key="`targetType-${index}`"
                  :label="targetType"
                  :value="index"
                ></el-option>
              </el-select>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="6">
            <el-form-item label="参数1">
              <el-input-number
                v-model="smartScript.target_param1"
                controls-position="right"
                placeholder="target_param1"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="参数2">
              <el-input-number
                v-model="smartScript.target_param2"
                controls-position="right"
                placeholder="target_param2"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="参数3">
              <el-input-number
                v-model="smartScript.target_param3"
                controls-position="right"
                placeholder="target_param3"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="参数4">
              <el-input-number
                v-model="smartScript.target_param4"
                controls-position="right"
                placeholder="target_param4"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="target_x">
              <el-input-number
                v-model="smartScript.target_x"
                controls-position="right"
                placeholder="target_x"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="target_y">
              <el-input-number
                v-model="smartScript.target_y"
                controls-position="right"
                placeholder="target_y"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="target_z">
              <el-input-number
                v-model="smartScript.target_z"
                controls-position="right"
                placeholder="target_z"
              ></el-input-number>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="target_o">
              <el-input-number
                v-model="smartScript.target_o"
                controls-position="right"
                placeholder="target_o"
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
  sourceTypes,
  eventTypes,
  actionTypes,
  targetTypes,
} from "@/locales/smartScript";

import { mapActions, mapState } from "vuex";

export default {
  data() {
    return {
      initing: false,
      loading: false,
      creating: false,
      sourceTypes: sourceTypes,
      eventTypes: eventTypes,
      actionTypes: actionTypes,
      targetTypes: targetTypes,
    };
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("smartScript", ["smartScript"]),
    credential() {
      return {
        entryorguid: this.$route.query.entryorguid,
        source_type: this.$route.query.source_type,
        id: this.$route.params.id,
        link: this.$route.query.link,
      };
    },
  },
  methods: {
    ...mapActions("smartScript", [
      "storeSmartScript",
      "findSmartScript",
      "updateSmartScript",
      "createSmartScript",
    ]),
    calculateMaxHeight() {
      return this.clientHeight - 307;
    },
    async store() {
      this.loading = true;
      if (this.creating) {
        this.storeSmartScript(this.smartScript);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateSmartScript({
          credential: this.credential,
          smartScript: this.smartScript,
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
      if (this.$route.path == "/smart-script/create") {
        this.creating = true;
        await Promise.all([this.createSmartScript()]);
      } else {
        await this.findSmartScript(this.credential);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
};
</script>
