<template>
  <div>
    <el-dialog
      title="请选择需要导出的dbc文件"
      :visible.sync="visible"
      width="30%"
      top="40vh"
    >
      <el-checkbox
        :indeterminate="isIndeterminate"
        v-model="checkAll"
        @change="handleCheckAllChange"
      >
        全选
      </el-checkbox>
      <el-checkbox v-model="checkedMpq">
        同时生成{{ mpqDefaultName }}
      </el-checkbox>
      <div style="margin: 15px 0"></div>
      <el-checkbox-group :value="checkedDbcs" @input="handleInput">
        <el-checkbox v-for="dbc in dbcs" :label="dbc" :key="dbc">
          {{ dbc }}
        </el-checkbox>
      </el-checkbox-group>
      <span slot="footer">
        <el-button @click="visible = false">取消</el-button>
        <el-button type="primary" @click="confirm">确定</el-button>
      </span>
    </el-dialog>
    <el-dialog
      :visible.sync="visible2"
      width="30%"
      top="40vh"
      :show-close="false"
      :close-on-click-modal="false"
      :close-on-press-escape="false"
    >
      <el-steps :active="active" align-center finish-status="success">
        <el-step icon="el-icon-data-analysis">
          <span slot="title">
            准备数据
            <i class="el-icon-loading" v-if="active == 0"></i>
          </span>
        </el-step>
        <el-step icon="el-icon-document">
          <span slot="title">
            写入文件
            <i class="el-icon-loading" v-if="active == 1"></i>
          </span>
        </el-step>
        <el-step icon="el-icon-download">
          <span slot="title">
            导出
            <i class="el-icon-loading" v-if="active == 2"></i>
          </span>
        </el-step>
      </el-steps>
      <ul style="list-style: none; color: #909399" v-if="active == 0">
        <li>
          <i class="el-icon-loading"></i>
          <!-- <i class="el-icon-check" style="color: #67c23a"></i> -->
          准备Item数据
          <!-- <span> ，共{{ 46101 }}条数据 </span> -->
        </li>
        <li>
          <i class="el-icon-loading"></i>
          准备Spell数据
        </li>
        <li>
          <i class="el-icon-loading"></i>
          准备ScalingStatDistribution数据
        </li>
      </ul>
      <ul style="list-style: none; color: #909399" v-else-if="active == 1">
        <li>
          <!-- <i class="el-icon-loading"></i> -->
          <i class="el-icon-check" style="color: #67c23a"></i>
          写入Item.dbc
        </li>
        <li>
          <i class="el-icon-loading"></i>
          写入Spell.dbc
        </li>
        <li>
          <i class="el-icon-loading"></i>
          写入ScalingStatDistribution.dbc
        </li>
      </ul>
    </el-dialog>
  </div>
</template>

<script>
const ipcRenderer = window.ipcRenderer;

const dbcOptions = [
  "Item",
  "Spell",
  "ScalingStatDistribution",
  "ItemSet",
  "Talent",
  "TalentTab",
];

import { START_EXPORT } from "@/constants";
import { init } from "@/repository/config";

import { mapState, mapActions } from "vuex";

export default {
  data() {
    return {
      visible: false,
      dbcs: dbcOptions,
      isIndeterminate: true,
      checkedMpq: false,
      mpqDefaultName: "patch-zhCN-5.MPQ",
      checkAll: false,
      visible2: false,
      active: 0,
    };
  },
  computed: {
    ...mapState("global", ["mysqlConfig"]),
    ...mapState("exporter", ["checkedDbcs"]),
  },
  methods: {
    ...mapActions("exporter", [
      "updateCheckedDbcs",
      "searchItemDbc",
      "searchSpellDbc",
      "searchScalingStatDistributionDbc",
    ]),
    handleCheckAllChange(val) {
      this.isIndeterminate = false;
      this.updateCheckedDbcs({ checkedDbcs: val ? dbcOptions : [] });
    },
    handleInput(value) {
      let checkedCount = value.length;
      this.checkAll = checkedCount === this.dbcs.length;
      this.isIndeterminate =
        checkedCount > 0 && checkedCount < this.dbcs.length;
      this.updateCheckedDbcs({ checkedDbcs: value });
    },
    confirm() {
      this.visible = false;
      this.visible2 = true;
      this.searchItemDbc();
      // this.prepareData();
    },
    prepareData() {
      let promises = [];
      for (let dbc of this.checkedDbcs) {
        switch (dbc) {
          case "Item":
            promises.push(this.searchItemDbc);
            break;
          case "Spell":
            promises.push(this.searchSpellDbc);
            break;
          case "ScalingStatDistribution":
            promises.push(this.searchScalingStatDistributionDbc);
            break;
          default:
            break;
        }
      }
      Promise.all(promises)
        .then(() => {
          this.active = 1;
        })
        .catch(() => {
          this.visible2 = false;
        });
    },
    writeFile() {
      let promises = [];
      for (let dbc of this.checkedDbcs) {
        switch (dbc) {
          case "Item":
            promises.push(this.writeItemDbc);
            break;
          case "Spell":
            promises.push(this.writeSpellDbc);
            break;
          case "ScalingStatDistribution":
            promises.push(this.writeScalingStatDistributionDbc);
            break;
          default:
            break;
        }
      }
      Promise.all(promises)
        .then(() => {
          this.active = 2;
        })
        .catch(() => {
          this.active = 0;
          this.visible2 = false;
        });
    },
  },
  mounted() {
    init(this.mysqlConfig);
    ipcRenderer.on(START_EXPORT, () => {
      if (this.visible == false && this.visible2 == false) {
        this.visible = true;
      }
    });
  },
};
</script>

<style scoped>
li {
  margin-bottom: 8px;
}
</style>
