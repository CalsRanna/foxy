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
      <!-- <el-checkbox v-model="checkedMpq">
        同时生成{{ mpqDefaultName }}
      </el-checkbox> -->
      <div style="margin: 15px 0"></div>
      <el-checkbox-group :value="checkedDbcs" @input="handleInput">
        <el-checkbox v-for="dbc in dbcs" :label="dbc" :key="dbc">
          {{ dbc }}
        </el-checkbox>
      </el-checkbox-group>
      <span slot="footer">
        <el-button @click="visible = false">取消</el-button>
        <el-button
          type="primary"
          :disabled="checkedDbcs.length === 0"
          @click="confirm"
        >
          确定
        </el-button>
      </span>
    </el-dialog>
    <el-dialog
      :visible.sync="visible2"
      width="30%"
      top="30vh"
      :show-close="closable"
      :close-on-click-modal="closable"
      :close-on-press-escape="closable"
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
            导出结束
            <i class="el-icon-loading" v-if="active == 2"></i>
          </span>
        </el-step>
      </el-steps>
      <ul style="list-style: none; color: #909399">
        <li v-if="checkedDbcs.indexOf('Item') > -1">
          <i class="el-icon-loading" v-if="isSearchingItemDbc"></i>
          <i class="el-icon-check" style="color: #67c23a" v-else></i>
          准备Item数据
          <span v-if="!isSearchingItemDbc"> ，共{{ items }}条数据 </span>
        </li>
        <li v-if="checkedDbcs.indexOf('Spell') > -1">
          <i class="el-icon-loading" v-if="isSearchingSpellDbc"></i>
          <i class="el-icon-check" style="color: #67c23a" v-else></i>
          准备Spell数据
          <span v-if="!isSearchingSpellDbc"> ，共{{ spells }}条数据 </span>
        </li>
        <li v-if="checkedDbcs.indexOf('ScalingStatDistribution') > -1">
          <i
            class="el-icon-loading"
            v-if="isSearchingScalingStatDistributionDbc"
          ></i>
          <i class="el-icon-check" style="color: #67c23a" v-else></i>
          准备ScalingStatDistribution数据
          <span v-if="!isSearchingScalingStatDistributionDbc">
            ，共{{ scalingStatDistributions }}条数据
          </span>
        </li>
        <li v-if="checkedDbcs.indexOf('Talent') > -1">
          <i class="el-icon-loading" v-if="isSearchingTalentDbc"></i>
          <i class="el-icon-check" style="color: #67c23a" v-else></i>
          准备Talent数据
          <span v-if="!isSearchingTalentDbc"> ，共{{ talents }}条数据 </span>
        </li>
        <li v-if="checkedDbcs.indexOf('TalentTab') > -1">
          <i class="el-icon-loading" v-if="isSearchingTalentTabDbc"></i>
          <i class="el-icon-check" style="color: #67c23a" v-else></i>
          准备TalentTab数据
          <span v-if="!isSearchingTalentTabDbc">
            ，共{{ talentTabs }}条数据
          </span>
        </li>
        <li v-if="checkedDbcs.indexOf('ItemSet') > -1">
          <i class="el-icon-loading" v-if="isSearchingItemSetDbc"></i>
          <i class="el-icon-check" style="color: #67c23a" v-else></i>
          准备ItemSet数据
          <span v-if="!isSearchingItemSetDbc"> ，共{{ itemSets }}条数据 </span>
        </li>
        <template v-if="active > 0">
          <li v-if="checkedDbcs.indexOf('Item') > -1">
            <i class="el-icon-loading" v-if="isWritingItemDbc"></i>
            <i class="el-icon-check" style="color: #67c23a" v-else></i>
            写入Item.dbc
          </li>
          <li v-if="checkedDbcs.indexOf('Spell') > -1">
            <i class="el-icon-loading" v-if="isWritingSpellDbc"></i>
            <i class="el-icon-check" style="color: #67c23a" v-else></i>
            写入Spell.dbc
          </li>
          <li v-if="checkedDbcs.indexOf('ScalingStatDistribution') > -1">
            <i
              class="el-icon-loading"
              v-if="isWritingScalingStatDistributionDbc"
            ></i>
            <i class="el-icon-check" style="color: #67c23a" v-else></i>
            写入ScalingStatDistribution.dbc
          </li>
          <li v-if="checkedDbcs.indexOf('ItemSet') > -1">
            <i class="el-icon-loading" v-if="isWritingItemSetDbc"></i>
            <i class="el-icon-check" style="color: #67c23a" v-else></i>
            写入ItemSet.dbc
          </li>
          <li v-if="checkedDbcs.indexOf('Talent') > -1">
            <i class="el-icon-loading" v-if="isWritingTalentDbc"></i>
            <i class="el-icon-check" style="color: #67c23a" v-else></i>
            写入Talent.dbc
          </li>
          <li v-if="checkedDbcs.indexOf('TalentTab') > -1">
            <i class="el-icon-loading" v-if="isWritingTalentTabDbc"></i>
            <i class="el-icon-check" style="color: #67c23a" v-else></i>
            写入TalentTab.dbc
          </li>
        </template>
        <li v-if="active === 3">
          <i class="el-icon-check" style="color: #67c23a"></i>
          导出成功
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
      closable: false,
      active: 0,
      isSearchingItemDbc: true,
      isSearchingSpellDbc: true,
      isSearchingScalingStatDistributionDbc: true,
      isSearchingItemSetDbc: true,
      isSearchingTalentDbc: true,
      isSearchingTalentTabDbc: true,
      isWritingItemDbc: true,
      isWritingSpellDbc: true,
      isWritingScalingStatDistributionDbc: true,
      isWritingItemSetDbc: true,
      isWritingTalentDbc: true,
      isWritingTalentTabDbc: true,
    };
  },
  computed: {
    ...mapState("global", ["mysqlConfig"]),
    ...mapState("exporter", [
      "checkedDbcs",
      "items",
      "spells",
      "scalingStatDistributions",
      "itemSets",
      "talents",
      "talentTabs",
    ]),
  },
  methods: {
    ...mapActions("exporter", [
      "updateCheckedDbcs",
      "searchItemDbc",
      "searchSpellDbc",
      "searchScalingStatDistributionDbc",
      "searchItemSetDbc",
      "searchTalentDbc",
      "searchTalentTabDbc",
      "writeItemDbc",
      "writeSpellDbc",
      "writeScalingStatDistributionDbc",
      "writeItemSetDbc",
      "writeTalentDbc",
      "writeTalentTabDbc",
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
      this.isSearchingItemDbc = true;
      this.isSearchingSpellDbc = true;
      this.isSearchingScalingStatDistributionDbc = true;
      this.isSearchingItemSetDbc = true;
      this.isSearchingTalentDbc = true;
      this.isSearchingTalentTabDbc = true;
      this.isWritingItemDbc = true;
      this.isWritingSpellDbc = true;
      this.isWritingScalingStatDistributionDbc = true;
      this.isWritingItemSetDbc = true;
      this.isWritingTalentDbc = true;
      this.isWritingTalentTabDbc = true;

      this.active = 0;

      this.visible = false;
      this.visible2 = true;

      this.prepareData();
    },
    prepareData() {
      let promises = [];
      for (let dbc of this.checkedDbcs) {
        switch (dbc) {
          case "Item":
            promises.push(
              this.searchItemDbc().then(() => {
                this.isSearchingItemDbc = false;
              })
            );
            break;
          case "Spell":
            promises.push(
              this.searchSpellDbc().then(() => {
                this.isSearchingSpellDbc = false;
              })
            );
            break;
          case "ScalingStatDistribution":
            promises.push(
              this.searchScalingStatDistributionDbc().then(() => {
                this.isSearchingScalingStatDistributionDbc = false;
              })
            );
            break;
          case "ItemSet":
            promises.push(
              this.searchItemSetDbc().then(() => {
                this.isSearchingItemSetDbc = false;
              })
            );
            break;
          case "Talent":
            promises.push(
              this.searchTalentDbc().then(() => {
                this.isSearchingTalentDbc = false;
              })
            );
            break;
          case "TalentTab":
            promises.push(
              this.searchTalentTabDbc().then(() => {
                this.isSearchingTalentTabDbc = false;
              })
            );
            break;
          default:
            break;
        }
      }
      Promise.all(promises)
        .then(() => {
          this.active = 1;
          this.writeFile();
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
            promises.push(
              this.writeItemDbc().then(() => {
                this.isWritingItemDbc = false;
              })
            );
            break;
          case "Spell":
            promises.push(
              this.writeSpellDbc().then(() => {
                this.isWritingSpellDbc = false;
              })
            );
            break;
          case "ScalingStatDistribution":
            promises.push(
              this.writeScalingStatDistributionDbc().then(() => {
                this.isWritingScalingStatDistributionDbc = false;
              })
            );
            break;
          case "ItemSet":
            promises.push(
              this.writeItemSetDbc().then(() => {
                this.isWritingItemSetDbc = false;
              })
            );
            break;
          case "Talent":
            promises.push(
              this.writeTalentDbc().then(() => {
                this.isWritingTalentDbc = false;
              })
            );
            break;
          case "TalentTab":
            promises.push(
              this.writeTalentTabDbc().then(() => {
                this.isWritingTalentTabDbc = false;
              })
            );
            break;
          default:
            break;
        }
      }
      Promise.all(promises)
        .then(() => {
          this.active = 3;
          this.closable = true;
        })
        .catch(() => {
          this.active = 0;
          this.visible2 = false;
        });
    },
  },
  mounted() {
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
