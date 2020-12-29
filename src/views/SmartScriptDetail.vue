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
    <el-card style="margin-top: 16px;">
      <el-tabs value="smart_script" style="margin-top: 16px">
        <el-tab-pane label="脚本模板" name="smart_script">
          <el-form :model="smartScript" label-position="right" label-width="120px">
            <el-card style="margin-top: 16px">
              <el-row :gutter="24">
                <el-col :span="6">
                  <el-form-item label="entryorguid">
                    <el-input v-model="smartScript.entryorguid" placeholder="entryorguid"></el-input>
                  </el-form-item>
                </el-col>
                <el-col :span="6">
                  <el-form-item label="source_type">
                    <el-input v-model="smartScript.source_type" placeholder="source_type"></el-input>
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
                    <el-input v-model="smartScript.event_type" placeholder="event_type"></el-input>
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
                  <el-form-item label="行动">
                    <el-input v-model="smartScript.action_type" placeholder="action_type"></el-input>
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
                    <el-input v-model="smartScript.target_type" placeholder="target_type"></el-input>
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
            <el-card style="margin-top:16px">
              <el-button type="primary">保存</el-button>
              <el-button>返回</el-button>
            </el-card>
          </el-form>
        </el-tab-pane>
      </el-tabs>
    </el-card>
  </div>
</template>

<script>
import { mapActions, mapState } from "vuex";

export default {
  data() {
    return {
      loading: false
    };
  },
  computed: {
    ...mapState("smartScript", ["smartScript"]),
    localeName() {
      return null;
    },
    localeDescription() {
      return null;
    }
  },
  methods: {
    ...mapActions("smartScript", {
      findSmartScript: "findSmartScript"
    }),
    async init() {
      this.loading = true;
      let payload = this.$route.query;
      payload.id = this.$route.params.id;
      await this.findSmartScript(payload);
      this.loading = false;
    }
  },
  created() {
    this.init();
  }
};
</script>
