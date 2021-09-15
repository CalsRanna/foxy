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
            <el-form-item label="类型">
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
            <el-form-item label="编号">
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
            <el-form-item label="链接">
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
            <el-form-item label="注解">
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
              <flag-editor
                v-model="smartScript.event_flags"
                :flags="eventFlags"
                title="事件标识编辑器"
                placeholder="event_flags"
              ></flag-editor>
            </el-form-item>
          </el-col>
          <el-col :span="6">
            <el-form-item label="事件阶段掩码">
              <flag-editor
                v-model="smartScript.event_phase_mask"
                :flags="eventPhaseMasks"
                title="事件阶段掩码编辑器"
                placeholder="event_phase_mask"
              ></flag-editor>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col
            :span="6"
            v-for="(eventParam, index) in matchedEventParams"
            :key="`event-params-${index}`"
          >
            <el-form-item :label="eventParam.label">
              <el-switch
                v-model="smartScript[eventParam.field]"
                :active-value="1"
                :inactive-value="0"
                v-if="eventParam.type === 'el-switch'"
              ></el-switch>
              <el-input-number
                v-model="smartScript[eventParam.field]"
                controls-position="right"
                :placeholder="eventParam.field"
                v-else-if="eventParam.type === 'el-input-number'"
              ></el-input-number>
              <gossip-menu-selector
                v-model="smartScript[eventParam.field]"
                :placeholder="eventParam.field"
                v-else-if="eventParam.type === 'gossip-menu-selector'"
              ></gossip-menu-selector>
              <spell-selector
                v-model="smartScript[eventParam.field]"
                :placeholder="eventParam.field"
                v-else-if="eventParam.type === 'spell-selector'"
              ></spell-selector>
              <el-input
                v-model="smartScript[eventParam.field]"
                :placeholder="eventParam.field"
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
          <el-col
            :span="6"
            v-for="(actionParam, index) in matchedActionParams"
            :key="`action-params-${index}`"
          >
            <el-form-item :label="actionParam.label">
              <el-switch
                v-model="smartScript[actionParam.field]"
                :active-value="1"
                :inactive-value="0"
                v-if="actionParam.type === 'el-switch'"
              ></el-switch>
              <el-input-number
                v-model="smartScript[actionParam.field]"
                controls-position="right"
                :placeholder="actionParam.field"
                v-else-if="actionParam.type === 'el-input-number'"
              ></el-input-number>
              <gossip-menu-selector
                v-model="smartScript[actionParam.field]"
                :placeholder="actionParam.field"
                v-else-if="actionParam.type === 'gossip-menu-selector'"
              ></gossip-menu-selector>
              <map-selector
                v-model="smartScript[actionParam.field]"
                :placeholder="actionParam.field"
                v-else-if="actionParam.type === 'map-selector'"
              ></map-selector>
              <spell-selector
                v-model="smartScript[actionParam.field]"
                :placeholder="actionParam.field"
                v-else-if="actionParam.type === 'spell-selector'"
              ></spell-selector>
              <el-input
                v-model="smartScript[actionParam.field]"
                :placeholder="actionParam.field"
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
          <el-col
            :span="6"
            v-for="(targetParam, index) in matchedTargetParams"
            :key="`action-params-${index}`"
          >
            <el-form-item :label="targetParam.label">
              <el-switch
                v-model="smartScript[targetParam.field]"
                :active-value="1"
                :inactive-value="0"
                v-if="targetParam.type === 'el-switch'"
              ></el-switch>
              <el-input-number
                v-model="smartScript[targetParam.field]"
                controls-position="right"
                :placeholder="targetParam.field"
                v-else-if="targetParam.type === 'el-input-number'"
              ></el-input-number>
              <gossip-menu-selector
                v-model="smartScript[targetParam.field]"
                :placeholder="targetParam.field"
                v-else-if="targetParam.type === 'gossip-menu-selector'"
              ></gossip-menu-selector>
              <map-selector
                v-model="smartScript[targetParam.field]"
                :placeholder="targetParam.field"
                v-else-if="targetParam.type === 'map-selector'"
              ></map-selector>
              <spell-selector
                v-model="smartScript[targetParam.field]"
                :placeholder="targetParam.field"
                v-else-if="targetParam.type === 'spell-selector'"
              ></spell-selector>
              <el-input
                v-model="smartScript[targetParam.field]"
                :placeholder="targetParam.field"
                v-else
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
import {
  sourceTypes,
  eventTypes,
  eventPhaseMasks,
  eventFlags,
  eventParams,
  actionTypes,
  actionParams,
  targetTypes,
  targetParams,
} from "@/locales/smartScript";
import FlagEditor from "@/components/FlagEditor";
import GossipMenuSelector from "@/components/GossipMenuSelector";
import MapSelector from "@/components/MapSelector";
import SpellSelector from "@/components/SpellSelector";

import { mapActions, mapState } from "vuex";

export default {
  data() {
    return {
      initing: false,
      loading: false,
      creating: false,
      sourceTypes: sourceTypes,
      eventTypes: eventTypes,
      eventPhaseMasks: eventPhaseMasks,
      eventFlags: eventFlags,
      eventParams: eventParams,
      actionTypes: actionTypes,
      actionParams: actionParams,
      targetTypes: targetTypes,
      targetParams: targetParams,
    };
  },
  computed: {
    ...mapState("app", ["clientHeight"]),
    ...mapState("smartScript", ["smartScript"]),
    matchedEventParams() {
      return this.smartScript.event_type >= 0
        ? this.eventParams[this.smartScript.event_type]
        : this.eventParams[0];
    },
    matchedActionParams() {
      return this.smartScript.action_type >= 0
        ? this.actionParams[this.smartScript.action_type]
        : this.actionParams[0];
    },
    matchedTargetParams() {
      return this.smartScript.target_type >= 0
        ? this.targetParams[this.smartScript.target_type]
        : this.targetParams[0];
    },
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
          position: "top-right",
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
  components: {
    FlagEditor,
    GossipMenuSelector,
    MapSelector,
    SpellSelector,
  },
};
</script>
