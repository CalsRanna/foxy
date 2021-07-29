<template>
  <el-dialog
    :visible.sync="visible"
    width="30%"
    top="40vh"
    :show-close="false"
    :close-on-click-modal="false"
    :modal="false"
  >
    <div style="text-align: center; margin-bottom: 24px; font-size: 20px">
      {{ loadingText }}
      <div v-show="progressText != undefined">
        <small style="color: #909399; font-size: 14px">
          <i class="el-icon-loading"></i>
          {{ progressText }}
        </small>
      </div>
    </div>
  </el-dialog>
</template>

<script>
import { mapActions } from "vuex";

export default {
  data() {
    return {
      visible: false,
      loadingText: "正在加载",
      progressText: undefined,
    };
  },
  methods: {
    ...mapActions("app", ["setActive"]),
    ...mapActions("initiator", [
      "loadDeveloperConfig",
      "loadMysqlConfig",
      "loadDbcConfig",
      "initializeMysqlConnection",
      "loadDbcAreaTables",
      "loadDbcCharTitles",
      "loadDbcChrClasses",
      "loadDbcChrRaces",
      "loadDbcCreatureDisplayInfos",
      "loadDbcCreatureModelDatas",
      "loadDbcCreatureSpellDatas",
      "loadDbcEmotes",
      "loadDbcEmotesTexts",
      "loadDbcFactions",
      "loadDbcFactionTemplates",
      "loadDbcGameObjectDisplayInfos",
      "loadDbcItems",
      "loadDbcItemDisplayInfos",
      "loadDbcItemRandomProperties",
      "loadDbcItemRandomSuffixes",
      "loadDbcItemSets",
      "loadDbcLocks",
      "loadDbcLockTypes",
      "loadDbcMaps",
      "loadDbcQuestFactionRewards",
      "loadDbcQuestInfos",
      "loadDbcQuestSorts",
      "loadDbcScalingStatDistributions",
      "loadDbcScalingStatValues",
      "loadDbcSpells",
      "loadDbcSpellCastTimes",
      "loadDbcSpellDurations",
      "loadDbcSpellIcons",
      "loadDbcSpellItemEnchantments",
      "loadDbcSpellMechanics",
      "loadDbcSpellRanges",
      "loadDbcTalents",
      "loadDbcTalentTabs",
      "initializeSuccess",
      "initializeFailure",
    ]),
    async init() {
      try {
        this.visible = true;
        this.progressText = "加载开发者配置";
        await this.loadDeveloperConfig();
        this.progressText = "加载数据库配置";
        await this.loadMysqlConfig();
        this.progressText = "加载DBC配置";
        await this.loadDbcConfig();
        this.progressText = "初始化数据库连接";
        await this.initializeMysqlConnection();
        this.progressText = "加载AreaTable.dbc";
        await this.loadDbcAreaTables();
        this.progressText = "加载CharTitles.dbc";
        await this.loadDbcCharTitles();
        this.progressText = "加载ChrClasses.dbc";
        await this.loadDbcChrClasses();
        this.progressText = "加载ChrRaces.dbc";
        await this.loadDbcChrRaces();
        this.progressText = "加载CreatureDisplayInfo.dbc";
        await this.loadDbcCreatureDisplayInfos();
        this.progressText = "加载CreatureModelData.dbc";
        await this.loadDbcCreatureModelDatas();
        this.progressText = "加载CreatureSpellData.dbc";
        await this.loadDbcCreatureSpellDatas();
        this.progressText = "加载Emotes.dbc";
        await this.loadDbcEmotes();
        this.progressText = "加载EmotesText.dbc";
        await this.loadDbcEmotesTexts();
        this.progressText = "加载Faction.dbc";
        await this.loadDbcFactions();
        this.progressText = "加载FactionTemplate.dbc";
        await this.loadDbcFactionTemplates();
        this.progressText = "加载GameObjectDisplayInfo.dbc";
        await this.loadDbcGameObjectDisplayInfos();
        this.progressText = "加载Item.dbc";
        await this.loadDbcItems();
        this.progressText = "加载ItemDisplayInfo.dbc";
        await this.loadDbcItemDisplayInfos();
        this.progressText = "加载ItemRandomProperties.dbc";
        await this.loadDbcItemRandomProperties();
        this.progressText = "加载ItemRandomSuffix.dbc";
        await this.loadDbcItemRandomSuffixes();
        this.progressText = "加载ItemSet.dbc";
        await this.loadDbcItemSets();
        this.progressText = "加载Lock.dbc";
        await this.loadDbcLocks();
        this.progressText = "加载LockType.dbc";
        await this.loadDbcLockTypes();
        this.progressText = "加载Map.dbc";
        await this.loadDbcMaps();
        this.progressText = "加载QuestFactionReward.dbc";
        await this.loadDbcQuestFactionRewards();
        this.progressText = "加载QuestInfo.dbc";
        await this.loadDbcQuestInfos();
        this.progressText = "加载QuestSort.dbc";
        await this.loadDbcQuestSorts();
        this.progressText = "加载ScalingStatDistribution.dbc";
        await this.loadDbcScalingStatDistributions();
        this.progressText = "加载ScalingStatValues.dbc";
        await this.loadDbcScalingStatValues();
        this.progressText = "加载Spell.dbc";
        await this.loadDbcSpells();
        this.progressText = "加载SpellCastTimes.dbc";
        await this.loadDbcSpellCastTimes();
        this.progressText = "加载SpellDuration.dbc";
        await this.loadDbcSpellDurations();
        this.progressText = "加载SpellIcon.dbc";
        await this.loadDbcSpellIcons();
        this.progressText = "加载SpellItemEnchantment.dbc";
        await this.loadDbcSpellItemEnchantments();
        this.progressText = "加载SpellMechanic.dbc";
        await this.loadDbcSpellMechanics();
        this.progressText = "加载SpellRange.dbc";
        await this.loadDbcSpellRanges();
        this.progressText = "加载Talent.dbc";
        await this.loadDbcTalents();
        this.progressText = "加载TalentTab.dbc";
        await this.loadDbcTalentTabs();
        this.loadingText = "加载成功";
        setTimeout(() => {
          this.initializeSuccess();
          this.visible = false;
          this.setActive("dashboard");
          this.$router.push("/dashboard").catch((error) => error);
        }, 500);
      } catch (error) {
        this.loadingText = "加载失败";
        setTimeout(() => {
          this.initializeFailure();
          this.visible = false;
          this.setActive("setting");
          this.$router.push("/setting").catch((error) => error);
        }, 500);
      }
    },
  },
  mounted() {
    this.init();
  },
};
</script>
