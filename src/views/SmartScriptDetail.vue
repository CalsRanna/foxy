<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/smart-script' }">内建脚本管理</el-breadcrumb-item>
        <el-breadcrumb-item>内建脚本详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-tabs value="smart_script" style="margin-top: 16px">
        <el-tab-pane label="脚本模板" name="smart_script">
          <el-form :model="smartScript" label-position="right" label-width="120px">
            <el-card style="margin-top: 16px">
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="entryorguid">
                    <el-input-number
                      v-model="smartScript.entryorguid"
                      controls-position="right"
                      placeholder="entryorguid"
                      :disabled="disabled"
                      v-loading="loading"
                      element-loading-spinner="el-icon-loading"
                      element-loading-background="rgba(255, 255, 255, 0.5)"
                    ></el-input-number>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="source_type">
                    <el-select v-model="smartScript.source_type" filterable placeholder="source_type">
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
                    <el-input v-model="smartScript.id" placeholder="id"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="link">
                    <el-input v-model="smartScript.link" placeholder="link"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="comment">
                    <el-input v-model="smartScript.comment" placeholder="comment"></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
            </el-card>
            <el-card style="margin-top: 16px">
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="事件">
                    <el-select v-model="smartScript.event_type" filterable placeholder="event_type">
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
                  <el-form-item label="event_chance">
                    <el-input v-model="smartScript.event_chance" placeholder="event_chance"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="event_flags">
                    <el-input v-model="smartScript.event_flags" placeholder="event_flags"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="event_phase_mask">
                    <el-input v-model="smartScript.event_phase_mask" placeholder="event_phase_mask"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="参数1">
                    <el-input v-model="smartScript.event_param1" placeholder="event_param1"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="参数2">
                    <el-input v-model="smartScript.event_param2" placeholder="event_param2"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="参数3">
                    <el-input v-model="smartScript.event_param3" placeholder="event_param3"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="参数4">
                    <el-input v-model="smartScript.event_param4" placeholder="event_param4"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="参数5">
                    <el-input v-model="smartScript.event_param5" placeholder="event_param5"></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
            </el-card>
            <el-card style="margin-top: 16px">
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="动作">
                    <el-select v-model="smartScript.action_type" filterable placeholder="action_type">
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
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="参数1">
                    <el-input v-model="smartScript.action_param1" placeholder="action_param1"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="参数2">
                    <el-input v-model="smartScript.action_param2" placeholder="action_param2"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="参数3">
                    <el-input v-model="smartScript.action_param3" placeholder="action_param3"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="参数4">
                    <el-input v-model="smartScript.action_param4" placeholder="action_param4"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="参数5">
                    <el-input v-model="smartScript.action_param5" placeholder="action_param5"></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
            </el-card>
            <el-card style="margin-top: 16px">
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="目标">
                    <el-select v-model="smartScript.target_type" filterable placeholder="target_type">
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
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="参数1">
                    <el-input v-model="smartScript.target_param1" placeholder="target_param1"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="参数2">
                    <el-input v-model="smartScript.target_param2" placeholder="target_param2"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="参数3">
                    <el-input v-model="smartScript.target_param3" placeholder="target_param3"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="参数4">
                    <el-input v-model="smartScript.target_param4" placeholder="target_param4"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="target_x">
                    <el-input v-model="smartScript.target_x" placeholder="target_x"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="target_y">
                    <el-input v-model="smartScript.target_y" placeholder="target_y"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="target_z">
                    <el-input v-model="smartScript.target_z" placeholder="target_z"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="target_o">
                    <el-input v-model="smartScript.target_o" placeholder="target_o"></el-input>
                  </el-form-item>
                </el-col>
              </el-row>
            </el-card>
            <el-card style="margin-top: 16px">
              <el-button type="primary" @click="() => store('smart_script')">保存</el-button>
              <el-button @click="cancel">返回</el-button>
            </el-card>
          </el-form>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
import { sourceTypes, eventTypes, actionTypes, targetTypes } from "@/locales/smartScript";

import { mapActions, mapState } from "vuex";

export default {
  data() {
    return {
      isCreating: true,
      loading: false,
      credential: {},
      sourceTypes: sourceTypes,
      eventTypes: eventTypes,
      actionTypes: actionTypes,
      targetTypes: targetTypes
    };
  },
  computed: {
    ...mapState("smartScript", ["smartScript"]),
    localeName() {
      return this.smartScript.comment;
    },
    localeDescription() {
      return null;
    },
    disabled() {
      return !this.isCreating;
    }
  },
  methods: {
    ...mapActions("smartScript", ["storeSmartScript", "findSmartScript", "updateSmartScript", "createSmartScript"]),
    store(module) {
      switch (module) {
        case "smart_script":
          this.loading = true;
          if (this.isCreating) {
            this.storeSmartScript(this.smartScript);
          } else {
            this.updateSmartScript({
              credential: this.credential,
              smartScript: this.smartScript
            });
          }
          this.loading = false;
          break;
        default:
          break;
      }
    },
    cancel() {
      this.$router.go(-1);
    },
    async init() {
      this.loading = true;
      let path = this.$route.path;
      if (path === "/smart-script/create") {
        await this.createSmartScript();
      } else {
        this.isCreating = false;
        this.credential = this.$route.query;
        this.credential.id = this.$route.params.id;
        await Promise.all([this.findSmartScript(this.credential)]);
      }
      this.loading = false;
    }
  },
  created() {
    this.init();
  }
};
</script>
