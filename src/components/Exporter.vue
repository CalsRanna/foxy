<template>
  <div>
    <el-dialog
      title="请选择需要导出的dbc文件"
      :visible.sync="visible"
      top="30vh"
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
        <el-checkbox
          v-for="option in options"
          :label="option"
          :key="option"
          style="width: 20%"
        >
          {{ option }}
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
        <li v-if="checkedDbcs.indexOf('AreaTable') > -1">
          <i class="el-icon-loading" v-if="isSearchingAreaTableDbc"></i>
          <i class="el-icon-check" style="color: #67c23a" v-else></i>
          准备AreaTable数据
          <span v-if="!isSearchingAreaTableDbc">
            ，共{{ areaTables }}条数据
          </span>
        </li>
        <li v-if="checkedDbcs.indexOf('EmotesText') > -1">
          <i class="el-icon-loading" v-if="isSearchingEmotesTextDbc"></i>
          <i class="el-icon-check" style="color: #67c23a" v-else></i>
          准备EmotesText数据
          <span v-if="!isSearchingEmotesTextDbc">
            ，共{{ emotesTexts }}条数据
          </span>
        </li>
        <li v-if="checkedDbcs.indexOf('Item') > -1">
          <i class="el-icon-loading" v-if="isSearchingItemDbc"></i>
          <i class="el-icon-check" style="color: #67c23a" v-else></i>
          准备Item数据
          <span v-if="!isSearchingItemDbc"> ，共{{ items }}条数据 </span>
        </li>
        <li v-if="checkedDbcs.indexOf('ItemSet') > -1">
          <i class="el-icon-loading" v-if="isSearchingItemSetDbc"></i>
          <i class="el-icon-check" style="color: #67c23a" v-else></i>
          准备ItemSet数据
          <span v-if="!isSearchingItemSetDbc"> ，共{{ itemSets }}条数据 </span>
        </li>
        <li v-if="checkedDbcs.indexOf('QuestFactionReward') > -1">
          <i
            class="el-icon-loading"
            v-if="isSearchingQuestFactionRewardDbc"
          ></i>
          <i class="el-icon-check" style="color: #67c23a" v-else></i>
          准备QuestFactionReward数据
          <span v-if="!isSearchingQuestFactionRewardDbc">
            ，共{{ questFactionRewards }}条数据
          </span>
        </li>
        <li v-if="checkedDbcs.indexOf('QuestInfo') > -1">
          <i class="el-icon-loading" v-if="isSearchingQuestInfoDbc"></i>
          <i class="el-icon-check" style="color: #67c23a" v-else></i>
          准备QuestInfo数据
          <span v-if="!isSearchingQuestInfoDbc">
            ，共{{ questInfos }}条数据
          </span>
        </li>
        <li v-if="checkedDbcs.indexOf('QuestSort') > -1">
          <i class="el-icon-loading" v-if="isSearchingQuestSortDbc"></i>
          <i class="el-icon-check" style="color: #67c23a" v-else></i>
          准备QuestSort数据
          <span v-if="!isSearchingQuestSortDbc">
            ，共{{ questSorts }}条数据
          </span>
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
        <li v-if="checkedDbcs.indexOf('ScalingStatValues') > -1">
          <i class="el-icon-loading" v-if="isSearchingScalingStatValuesDbc"></i>
          <i class="el-icon-check" style="color: #67c23a" v-else></i>
          准备ScalingStatValues数据
          <span v-if="!isSearchingScalingStatValuesDbc">
            ，共{{ scalingStatValues }}条数据
          </span>
        </li>
        <li v-if="checkedDbcs.indexOf('Spell') > -1">
          <i class="el-icon-loading" v-if="isSearchingSpellDbc"></i>
          <i class="el-icon-check" style="color: #67c23a" v-else></i>
          准备Spell数据
          <span v-if="!isSearchingSpellDbc"> ，共{{ spells }}条数据 </span>
        </li>
        <li v-if="checkedDbcs.indexOf('SpellItemEnchantment') > -1">
          <i
            class="el-icon-loading"
            v-if="isSearchingSpellItemEnchantmentDbc"
          ></i>
          <i class="el-icon-check" style="color: #67c23a" v-else></i>
          准备SpellItemEnchantment数据
          <span v-if="!isSearchingSpellItemEnchantmentDbc">
            ，共{{ spellItemEnchantments }}条数据
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
        <template v-if="active > 0">
          <li v-if="checkedDbcs.indexOf('AreaTable') > -1">
            <i class="el-icon-loading" v-if="isWritingAreaTableDbc"></i>
            <i class="el-icon-check" style="color: #67c23a" v-else></i>
            写入AreaTable.dbc
          </li>
          <li v-if="checkedDbcs.indexOf('EmotesText') > -1">
            <i class="el-icon-loading" v-if="isWritingEmotesTextDbc"></i>
            <i class="el-icon-check" style="color: #67c23a" v-else></i>
            写入EmotesText.dbc
          </li>
          <li v-if="checkedDbcs.indexOf('Item') > -1">
            <i class="el-icon-loading" v-if="isWritingItemDbc"></i>
            <i class="el-icon-check" style="color: #67c23a" v-else></i>
            写入Item.dbc
          </li>
          <li v-if="checkedDbcs.indexOf('ItemSet') > -1">
            <i class="el-icon-loading" v-if="isWritingItemSetDbc"></i>
            <i class="el-icon-check" style="color: #67c23a" v-else></i>
            写入ItemSet.dbc
          </li>
          <li v-if="checkedDbcs.indexOf('QuestFactionReward') > -1">
            <i
              class="el-icon-loading"
              v-if="isWritingQuestFactionRewardDbc"
            ></i>
            <i class="el-icon-check" style="color: #67c23a" v-else></i>
            写入QuestFactionReward.dbc
          </li>
          <li v-if="checkedDbcs.indexOf('QuestInfo') > -1">
            <i class="el-icon-loading" v-if="isWritingQuestInfoDbc"></i>
            <i class="el-icon-check" style="color: #67c23a" v-else></i>
            写入QuestInfo.dbc
          </li>
          <li v-if="checkedDbcs.indexOf('QuestSort') > -1">
            <i class="el-icon-loading" v-if="isWritingQuestSortDbc"></i>
            <i class="el-icon-check" style="color: #67c23a" v-else></i>
            写入QuestSort.dbc
          </li>
          <li v-if="checkedDbcs.indexOf('ScalingStatDistribution') > -1">
            <i
              class="el-icon-loading"
              v-if="isWritingScalingStatDistributionDbc"
            ></i>
            <i class="el-icon-check" style="color: #67c23a" v-else></i>
            写入ScalingStatDistribution.dbc
          </li>
          <li v-if="checkedDbcs.indexOf('ScalingStatValues') > -1">
            <i class="el-icon-loading" v-if="isWritingScalingStatValuesDbc"></i>
            <i class="el-icon-check" style="color: #67c23a" v-else></i>
            写入ScalingStatValues.dbc
          </li>
          <li v-if="checkedDbcs.indexOf('Spell') > -1">
            <i class="el-icon-loading" v-if="isWritingSpellDbc"></i>
            <i class="el-icon-check" style="color: #67c23a" v-else></i>
            写入Spell.dbc
          </li>
          <li v-if="checkedDbcs.indexOf('SpellItemEnchantment') > -1">
            <i
              class="el-icon-loading"
              v-if="isWritingSpellItemEnchantmentDbc"
            ></i>
            <i class="el-icon-check" style="color: #67c23a" v-else></i>
            写入SpellItemEnchantment.dbc
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
const options = [
  "AreaTable",
  "EmotesText",
  "Item",
  "ItemSet",
  "QuestFactionReward",
  "QuestInfo",
  "QuestSort",
  "ScalingStatDistribution",
  "ScalingStatValues",
  "Spell",
  "SpellItemEnchantment",
  "Talent",
  "TalentTab",
];

import { START_EXPORT } from "@/constants";
import { mapState, mapActions } from "vuex";

export default {
  data() {
    return {
      visible: false,
      options: options,
      isIndeterminate: true,
      checkedMpq: false,
      mpqDefaultName: "patch-zhCN-5.MPQ",
      checkAll: false,
      visible2: false,
      closable: false,
      active: 0,
      isSearchingAreaTableDbc: true,
      isSearchingEmotesTextDbc: true,
      isSearchingItemDbc: true,
      isSearchingItemSetDbc: true,
      isSearchingQuestFactionRewardDbc: true,
      isSearchingQuestInfoDbc: true,
      isSearchingQuestSortDbc: true,
      isSearchingScalingStatDistributionDbc: true,
      isSearchingScalingStatValuesDbc: true,
      isSearchingSpellDbc: true,
      isSearchingSpellItemEnchantmentDbc: true,
      isSearchingTalentDbc: true,
      isSearchingTalentTabDbc: true,
      isWritingAreaTableDbc: true,
      isWritingEmotesTextDbc: true,
      isWritingItemDbc: true,
      isWritingItemSetDbc: true,
      isWritingQuestFactionRewardDbc: true,
      isWritingQuestInfoDbc: true,
      isWritingQuestSortDbc: true,
      isWritingScalingStatDistributionDbc: true,
      isWritingScalingStatValuesDbc: true,
      isWritingSpellDbc: true,
      isWritingSpellItemEnchantmentDbc: true,
      isWritingTalentDbc: true,
      isWritingTalentTabDbc: true,
    };
  },
  computed: {
    ...mapState("exporter", [
      "checkedDbcs",
      "areaTables",
      "emotesTexts",
      "items",
      "itemSets",
      "questFactionRewards",
      "questInfos",
      "questSorts",
      "scalingStatDistributions",
      "scalingStatValues",
      "spells",
      "spellItemEnchantments",
      "talents",
      "talentTabs",
    ]),
  },
  methods: {
    ...mapActions("exporter", [
      "updateCheckedDbcs",
      "searchAreaTableDbc",
      "searchEmotesTextDbc",
      "searchItemDbc",
      "searchItemSetDbc",
      "searchQuestFactionRewardDbc",
      "searchQuestInfoDbc",
      "searchQuestSortDbc",
      "searchScalingStatDistributionDbc",
      "searchScalingStatValuesDbc",
      "searchSpellDbc",
      "searchSpellItemEnchantmentDbc",
      "searchTalentDbc",
      "searchTalentTabDbc",
      "writeAreaTableDbc",
      "writeEmotesTextDbc",
      "writeItemDbc",
      "writeItemSetDbc",
      "writeQuestFactionRewardDbc",
      "writeQuestInfoDbc",
      "writeQuestSortDbc",
      "writeScalingStatDistributionDbc",
      "writeScalingStatValuesDbc",
      "writeSpellDbc",
      "writeSpellItemEnchantmentDbc",
      "writeTalentDbc",
      "writeTalentTabDbc",
    ]),
    handleCheckAllChange(val) {
      this.isIndeterminate = false;
      this.updateCheckedDbcs({ checkedDbcs: val ? options : [] });
    },
    handleInput(value) {
      let checkedCount = value.length;
      this.checkAll = checkedCount === this.options.length;
      this.isIndeterminate =
        checkedCount > 0 && checkedCount < this.options.length;
      this.updateCheckedDbcs({ checkedDbcs: value });
    },
    confirm() {
      this.isSearchingAreaTableDbc = true;
      this.isSearchingEmotesTextDbc = true;
      this.isSearchingItemDbc = true;
      this.isSearchingItemSetDbc = true;
      this.isSearchingQuestFactionRewardDbc = true;
      this.isSearchingQuestInfoDbc = true;
      this.isSearchingQuestSortDbc = true;
      this.isSearchingScalingStatDistributionDbc = true;
      this.isSearchingScalingStatValuesDbc = true;
      this.isSearchingSpellDbc = true;
      this.isSearchingSpellItemEnchantmentDbc = true;
      this.isSearchingTalentDbc = true;
      this.isSearchingTalentTabDbc = true;
      this.isWritingAreaTableDbc = true;
      this.isWritingEmotesTextDbc = true;
      this.isWritingItemDbc = true;
      this.isWritingItemSetDbc = true;
      this.isWritingQuestFactionRewardDbc = true;
      this.isWritingQuestInfoDbc = true;
      this.isWritingQuestSortDbc = true;
      this.isWritingScalingStatDistributionDbc = true;
      this.isWritingScalingStatValuesDbc = true;
      this.isWritingSpellDbc = true;
      this.isWritingSpellItemEnchantmentDbc = true;
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
          case "AreaTable":
            promises.push(
              this.searchAreaTableDbc().then(() => {
                this.isSearchingAreaTableDbc = false;
              })
            );
            break;
          case "EmotesText":
            promises.push(
              this.searchEmotesTextDbc().then(() => {
                this.isSearchingEmotesTextDbc = false;
              })
            );
            break;
          case "Item":
            promises.push(
              this.searchItemDbc().then(() => {
                this.isSearchingItemDbc = false;
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
          case "QuestFactionReward":
            promises.push(
              this.searchQuestFactionRewardDbc().then(() => {
                this.isSearchingQuestFactionRewardDbc = false;
              })
            );
            break;
          case "QuestInfo":
            promises.push(
              this.searchQuestInfoDbc().then(() => {
                this.isSearchingQuestInfoDbc = false;
              })
            );
            break;
          case "QuestSort":
            promises.push(
              this.searchQuestSortDbc().then(() => {
                this.isSearchingQuestSortDbc = false;
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
          case "ScalingStatValues":
            promises.push(
              this.searchScalingStatValuesDbc().then(() => {
                this.isSearchingScalingStatValuesDbc = false;
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
          case "SpellItemEnchantment":
            promises.push(
              this.searchSpellItemEnchantmentDbc().then(() => {
                this.isSearchingSpellItemEnchantmentDbc = false;
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
          case "AreaTable":
            promises.push(
              this.writeAreaTableDbc().then(() => {
                this.isWritingAreaTableDbc = false;
              })
            );
            break;
          case "EmotesText":
            promises.push(
              this.writeEmotesTextDbc().then(() => {
                this.isWritingEmotesTextDbc = false;
              })
            );
            break;
          case "Item":
            promises.push(
              this.writeItemDbc().then(() => {
                this.isWritingItemDbc = false;
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
          case "QuestFactionReward":
            promises.push(
              this.writeQuestFactionRewardDbc().then(() => {
                this.isWritingQuestFactionRewardDbc = false;
              })
            );
            break;
          case "QuestInfo":
            promises.push(
              this.writeQuestInfoDbc().then(() => {
                this.isWritingQuestInfoDbc = false;
              })
            );
            break;
          case "QuestSort":
            promises.push(
              this.writeQuestSortDbc().then(() => {
                this.isWritingQuestSortDbc = false;
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
          case "ScalingStatValues":
            promises.push(
              this.writeScalingStatValuesDbc().then(() => {
                this.isWritingScalingStatValuesDbc = false;
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
          case "SpellItemEnchantment":
            promises.push(
              this.writeSpellItemEnchantmentDbc().then(() => {
                this.isWritingSpellItemEnchantmentDbc = false;
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
