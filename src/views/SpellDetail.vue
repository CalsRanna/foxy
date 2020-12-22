<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/spell' }">技能管理</el-breadcrumb-item>
        <el-breadcrumb-item>技能详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ spell.nameLangZhCN }}
        <small>
          {{ spell.rankLangZhCN }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="basic" @tab-click="switchover" style="margin-top: 16px">
      <el-tab-pane label="基本信息" name="basic">
        <el-form :model="spell" label-position="right" label-width="120px">
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="id">
                  <el-input v-model="spell.id" placeholder="id"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="名称">
                  <el-input v-model="spell.nameLangZhCN" placeholder="nameLangZhCN"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="等级">
                  <el-input v-model="spell.rankLangZhCN" placeholder="rankLangZhCN"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="描述">
                  <el-input v-model="spell.descriptionLangZhCN" placeholder="descriptionLangZhCN"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="Buff描述">
                  <el-input v-model="spell.auraDescriptionLangZhCN" placeholder="auraDescriptionLangZhCN"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="nameLangMask">
                  <el-input v-model="spell.nameLangMask" placeholder="nameLangMask"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="rankLangMask">
                  <el-input v-model="spell.rankLangMask" placeholder="rankLangMask"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="descriptionLangMask">
                  <el-input v-model="spell.descriptionLangMask" placeholder="descriptionLangMask"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="auraDescriptionLangMask">
                  <el-input v-model="spell.auraDescriptionLangMask" placeholder="auraDescriptionLangMask"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="类型">
                  <el-input v-model="spell.category" placeholder="category"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="！驱散类型">
                  <el-input v-model="spell.displayType" placeholder="displayType"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="机制类型">
                  <el-input v-model="spell.mechanic" placeholder="mechanic"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="施法时间">
                  <el-input v-model="spell.castingTimeIndex" placeholder="castingTimeIndex"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="durationIndex">
                  <el-input v-model="spell.durationIndex" placeholder="durationIndex"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="randeIndex">
                  <el-input v-model="spell.randeIndex" placeholder="randeIndex"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="casterAuraState">
                  <el-input v-model="spell.casterAuraState" placeholder="casterAuraState"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="spellLevel">
                  <el-input v-model="spell.spellLevel" placeholder="spellLevel"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="baseLevel">
                  <el-input v-model="spell.baseLevel" placeholder="baseLevel"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="maxLevel">
                  <el-input v-model="spell.maxLevel" placeholder="maxLevel"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="startRecoveryCategory">
                  <el-input v-model="spell.startRecoveryCategory" placeholder="startRecoveryCategory"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="startRecoveryTime">
                  <el-input v-model="spell.startRecoveryTime" placeholder="startRecoveryTime"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="recoveryTime">
                  <el-input v-model="spell.recoveryTime" placeholder="recoveryTime"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="maxTargets">
                  <el-input v-model="spell.maxTargets" placeholder="maxTargets"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="maxTargetLevel">
                  <el-input v-model="spell.maxTargetLevel" placeholder="maxTargetLevel"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="runeCostID">
                  <el-input v-model="spell.runeCostID" placeholder="runeCostID"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="speed">
                  <el-input v-model="spell.speed" placeholder="speed"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="targetAuraState">
                  <el-input v-model="spell.targetAuraState" placeholder="targetAuraState"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="categoryRecoveryTime">
                  <el-input v-model="spell.categoryRecoveryTime" placeholder="categoryRecoveryTime"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="spellMissileID">
                  <el-input v-model="spell.spellMissileID" placeholder="spellMissileID"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="spellDifficultyID">
                  <el-input v-model="spell.spellDifficultyID" placeholder="spellDifficultyID"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="powerType">
                  <el-input v-model="spell.powerType" placeholder="powerType"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="requiredTotemCategoryID_1">
                  <el-input
                    v-model="spell.requiredTotemCategoryID_1"
                    placeholder="requiredTotemCategoryID_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="requiredTotemCategoryID_2">
                  <el-input
                    v-model="spell.requiredTotemCategoryID_2"
                    placeholder="requiredTotemCategoryID_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="requiredAreasID">
                  <el-input v-model="spell.requiredAreasID" placeholder="requiredAreasID"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="spellDescriptionVariableID">
                  <el-input
                    v-model="spell.spellDescriptionVariableID"
                    placeholder="spellDescriptionVariableID"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="manaCost">
                  <el-input v-model="spell.manaCost" placeholder="manaCost"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="manaCostPct">
                  <el-input v-model="spell.manaCostPct" placeholder="manaCostPct"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="manaCostPerLevel">
                  <el-input v-model="spell.manaCostPerLevel" placeholder="manaCostPerLevel"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="manaPerSecond">
                  <el-input v-model="spell.manaPerSecond" placeholder="manaPerSecond"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="manaPerSecondPerLevel">
                  <el-input v-model="spell.manaPerSecondPerLevel" placeholder="manaPerSecondPerLevel"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="spellClassMask_1">
                  <el-input v-model="spell.spellClassMask_1" placeholder="spellClassMask_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="spellClassMask_2">
                  <el-input v-model="spell.spellClassMask_2" placeholder="spellClassMask_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="spellClassMask_3">
                  <el-input v-model="spell.spellClassMask_3" placeholder="spellClassMask_3"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="spellClassSet">
                  <el-input v-model="spell.spellClassSet" placeholder="spellClassSet"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="preventionType">
                  <el-input v-model="spell.preventionType" placeholder="preventionType"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="damageClass">
                  <el-input v-model="spell.damageClass" placeholder="damageClass"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="requireSpellFoucus">
                  <el-input v-model="spell.requireSpellFoucus" placeholder="requireSpellFoucus"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="schoolMask">
                  <el-input v-model="spell.schoolMask" placeholder="schoolMask"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="facingCasterFlags">
                  <el-input v-model="spell.facingCasterFlags" placeholder="facingCasterFlags"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="targets">
                  <el-input v-model="spell.targets" placeholder="targets"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="procChance">
                  <el-input v-model="spell.procChance" placeholder="procChance"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="procCharges">
                  <el-input v-model="spell.procCharges" placeholder="procCharges"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="procFlags">
                  <el-input v-model="spell.procFlags" placeholder="procFlags"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="效果">
                  <el-input v-model="spell.effect_1" placeholder="effect_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="基础值">
                  <el-input v-model="spell.effectBasePoints_1" placeholder="effectBasePoints_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="浮动值">
                  <el-input v-model="spell.effectDieSides_1" placeholder="effectDieSides_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectRealPointsPerLevel_1">
                  <el-input
                    v-model="spell.effectRealPointsPerLevel_1"
                    placeholder="effectRealPointsPerLevel_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectMachanic_1">
                  <el-input v-model="spell.effectMachanic_1" placeholder="effectMachanic_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="implicitTargetA_1">
                  <el-input v-model="spell.implicitTargetA_1" placeholder="implicitTargetA_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="implicitTargetB_1">
                  <el-input v-model="spell.implicitTargetB_1" placeholder="implicitTargetB_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectRadiusIndex_1">
                  <el-input v-model="spell.effectRadiusIndex_1" placeholder="effectRadiusIndex_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectAura_1">
                  <el-input v-model="spell.effectAura_1" placeholder="effectAura_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectAuraPeriod_1">
                  <el-input v-model="spell.effectAuraPeriod_1" placeholder="effectAuraPeriod_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectBonusMultiplier_1">
                  <el-input v-model="spell.effectBonusMultiplier_1" placeholder="effectBonusMultiplier_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectChainAmplitude_1">
                  <el-input v-model="spell.effectChainAmplitude_1" placeholder="effectChainAmplitude_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectChainTargets_1">
                  <el-input v-model="spell.effectChainTargets_1" placeholder="effectChainTargets_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectItemType_1">
                  <el-input v-model="spell.effectItemType_1" placeholder="effectItemType_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectMiscValueA_1">
                  <el-input v-model="spell.effectMiscValueA_1" placeholder="effectMiscValueA_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectMiscValueB_1">
                  <el-input v-model="spell.effectMiscValueB_1" placeholder="effectMiscValueB_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectMultipleValue_1">
                  <el-input v-model="spell.effectMultipleValue_1" placeholder="effectMultipleValue_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectPointsPerCombo_1">
                  <el-input v-model="spell.effectPointsPerCombo_1" placeholder="effectPointsPerCombo_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectTriggerSpell_1">
                  <el-input v-model="spell.effectTriggerSpell_1" placeholder="effectTriggerSpell_1"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="effect_2">
                  <el-input v-model="spell.effect_2" placeholder="effect_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectBasePoints_2">
                  <el-input v-model="spell.effectBasePoints_2" placeholder="effectBasePoints_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectDieSides_2">
                  <el-input v-model="spell.effectDieSides_2" placeholder="effectDieSides_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectRealPointsPerLevel_2">
                  <el-input
                    v-model="spell.effectRealPointsPerLevel_2"
                    placeholder="effectRealPointsPerLevel_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectMachanic_2">
                  <el-input v-model="spell.effectMachanic_2" placeholder="effectMachanic_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="implicitTargetA_2">
                  <el-input v-model="spell.implicitTargetA_2" placeholder="implicitTargetA_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="implicitTargetB_2">
                  <el-input v-model="spell.implicitTargetB_2" placeholder="implicitTargetB_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectRadiusIndex_2">
                  <el-input v-model="spell.effectRadiusIndex_2" placeholder="effectRadiusIndex_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectAura_2">
                  <el-input v-model="spell.effectAura_2" placeholder="effectAura_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectAuraPeriod_2">
                  <el-input v-model="spell.effectAuraPeriod_2" placeholder="effectAuraPeriod_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectBonusMultiplier_2">
                  <el-input v-model="spell.effectBonusMultiplier_2" placeholder="effectBonusMultiplier_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectChainAmplitude_2">
                  <el-input v-model="spell.effectChainAmplitude_2" placeholder="effectChainAmplitude_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectChainTargets_2">
                  <el-input v-model="spell.effectChainTargets_2" placeholder="effectChainTargets_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectItemType_2">
                  <el-input v-model="spell.effectItemType_2" placeholder="effectItemType_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectMiscValueA_2">
                  <el-input v-model="spell.effectMiscValueA_2" placeholder="effectMiscValueA_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectMiscValueB_2">
                  <el-input v-model="spell.effectMiscValueB_2" placeholder="effectMiscValueB_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectMultipleValue_2">
                  <el-input v-model="spell.effectMultipleValue_2" placeholder="effectMultipleValue_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectPointsPerCombo_2">
                  <el-input v-model="spell.effectPointsPerCombo_2" placeholder="effectPointsPerCombo_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectTriggerSpell_2">
                  <el-input v-model="spell.effectTriggerSpell_2" placeholder="effectTriggerSpell_2"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="effect_3">
                  <el-input v-model="spell.effect_3" placeholder="effect_3"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectBasePoints_3">
                  <el-input v-model="spell.effectBasePoints_3" placeholder="effectBasePoints_3"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectDieSides_3">
                  <el-input v-model="spell.effectDieSides_3" placeholder="effectDieSides_3"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectRealPointsPerLevel_3">
                  <el-input
                    v-model="spell.effectRealPointsPerLevel_3"
                    placeholder="effectRealPointsPerLevel_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectMachanic_3">
                  <el-input v-model="spell.effectMachanic_3" placeholder="effectMachanic_3"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="implicitTargetA_3">
                  <el-input v-model="spell.implicitTargetA_3" placeholder="implicitTargetA_3"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="implicitTargetB_3">
                  <el-input v-model="spell.implicitTargetB_3" placeholder="implicitTargetB_3"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectRadiusIndex_3">
                  <el-input v-model="spell.effectRadiusIndex_3" placeholder="effectRadiusIndex_3"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectAura_3">
                  <el-input v-model="spell.effectAura_3" placeholder="effectAura_3"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectAuraPeriod_3">
                  <el-input v-model="spell.effectAuraPeriod_3" placeholder="effectAuraPeriod_3"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectBonusMultiplier_3">
                  <el-input v-model="spell.effectBonusMultiplier_3" placeholder="effectBonusMultiplier_3"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectChainAmplitude_3">
                  <el-input v-model="spell.effectChainAmplitude_3" placeholder="effectChainAmplitude_3"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectChainTargets_3">
                  <el-input v-model="spell.effectChainTargets_3" placeholder="effectChainTargets_3"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectItemType_3">
                  <el-input v-model="spell.effectItemType_3" placeholder="effectItemType_3"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectMiscValueA_3">
                  <el-input v-model="spell.effectMiscValueA_3" placeholder="effectMiscValueA_3"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectMiscValueB_3">
                  <el-input v-model="spell.effectMiscValueB_3" placeholder="effectMiscValueB_3"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectMultipleValue_3">
                  <el-input v-model="spell.effectMultipleValue_3" placeholder="effectMultipleValue_3"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectPointsPerCombo_3">
                  <el-input v-model="spell.effectPointsPerCombo_3" placeholder="effectPointsPerCombo_3"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectTriggerSpell_3">
                  <el-input v-model="spell.effectTriggerSpell_3" placeholder="effectTriggerSpell_3"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="effectSpellClassMask_1">
                  <el-input v-model="spell.effectSpellClassMask_1" placeholder="effectSpellClassMask_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectSpellClassMask_2">
                  <el-input v-model="spell.effectSpellClassMask_2" placeholder="effectSpellClassMask_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectSpellClassMask_3">
                  <el-input v-model="spell.effectSpellClassMask_3" placeholder="effectSpellClassMask_3"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectSpellClassMask_4">
                  <el-input v-model="spell.effectSpellClassMask_4" placeholder="effectSpellClassMask_4"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectSpellClassMask_5">
                  <el-input v-model="spell.effectSpellClassMask_5" placeholder="effectSpellClassMask_5"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectSpellClassMask_6">
                  <el-input v-model="spell.effectSpellClassMask_6" placeholder="effectSpellClassMask_6"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectSpellClassMask_7">
                  <el-input v-model="spell.effectSpellClassMask_7" placeholder="effectSpellClassMask_7"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectSpellClassMask_8">
                  <el-input v-model="spell.effectSpellClassMask_8" placeholder="effectSpellClassMask_8"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectSpellClassMask_9">
                  <el-input v-model="spell.effectSpellClassMask_9" placeholder="effectSpellClassMask_9"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="totem_1">
                  <el-input v-model="spell.totem_1" placeholder="totem_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="totem_2">
                  <el-input v-model="spell.totem_2" placeholder="totem_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="reagent_1">
                  <el-input v-model="spell.reagent_1" placeholder="reagent_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="reagent_2">
                  <el-input v-model="spell.reagent_2" placeholder="reagent_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="reagent_3">
                  <el-input v-model="spell.reagent_3" placeholder="reagent_3"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="reagent_4">
                  <el-input v-model="spell.reagent_4" placeholder="reagent_4"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="reagent_5">
                  <el-input v-model="spell.reagent_5" placeholder="reagent_5"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="reagent_6">
                  <el-input v-model="spell.reagent_6" placeholder="reagent_6"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="reagent_7">
                  <el-input v-model="spell.reagent_7" placeholder="reagent_7"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="reagent_8">
                  <el-input v-model="spell.reagent_8" placeholder="reagent_8"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="regentCount_1">
                  <el-input v-model="spell.regentCount_1" placeholder="regentCount_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="regentCount_2">
                  <el-input v-model="spell.regentCount_2" placeholder="regentCount_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="regentCount_3">
                  <el-input v-model="spell.regentCount_3" placeholder="regentCount_3"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="regentCount_4">
                  <el-input v-model="spell.regentCount_4" placeholder="regentCount_4"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="regentCount_5">
                  <el-input v-model="spell.regentCount_5" placeholder="regentCount_5"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="regentCount_6">
                  <el-input v-model="spell.regentCount_6" placeholder="regentCount_6"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="regentCount_7">
                  <el-input v-model="spell.regentCount_7" placeholder="regentCount_7"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="regentCount_8">
                  <el-input v-model="spell.regentCount_8" placeholder="regentCount_8"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="equippedItemClass">
                  <el-input v-model="spell.equippedItemClass" placeholder="equippedItemClass"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="equippedItemInventoryTypeMask">
                  <el-input
                    v-model="spell.equippedItemInventoryTypeMask"
                    placeholder="equippedItemInventoryTypeMask"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="equippedItemSubClassMask">
                  <el-input v-model="spell.equippedItemSubClassMask" placeholder="equippedItemSubClassMask"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="interruptFlags">
                  <el-input v-model="spell.interruptFlags" placeholder="interruptFlags"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="aruaInterruptFlags">
                  <el-input v-model="spell.aruaInterruptFlags" placeholder="aruaInterruptFlags"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="channelInterruptFlags">
                  <el-input v-model="spell.channelInterruptFlags" placeholder="channelInterruptFlags"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="attributes">
                  <el-input v-model="spell.attributes" placeholder="attributes"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="attributesExtra_1">
                  <el-input v-model="spell.attributesExtra_1" placeholder="attributesExtra_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="attributesExtra_2">
                  <el-input v-model="spell.attributesExtra_2" placeholder="attributesExtra_2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="attributesExtra_3">
                  <el-input v-model="spell.attributesExtra_3" placeholder="attributesExtra_3"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="attributesExtra_4">
                  <el-input v-model="spell.attributesExtra_4" placeholder="attributesExtra_4"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="attributesExtra_5">
                  <el-input v-model="spell.attributesExtra_5" placeholder="attributesExtra_5"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="attributesExtra_6">
                  <el-input v-model="spell.attributesExtra_6" placeholder="attributesExtra_6"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="attributesExtra_7">
                  <el-input v-model="spell.attributesExtra_7" placeholder="attributesExtra_7"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="targetCreatureType">
                  <el-input v-model="spell.targetCreatureType" placeholder="targetCreatureType"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="stances">
                  <el-input v-model="spell.stances" placeholder="stances"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="spellIconID">
                  <el-input v-model="spell.spellIconID" placeholder="spellIconID"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="activeIconID">
                  <el-input v-model="spell.activeIconID" placeholder="activeIconID"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="spellVisualID_1">
                  <el-input v-model="spell.spellVisualID_1" placeholder="spellVisualID_1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="spellVisualID_2">
                  <el-input v-model="spell.spellVisualID_2" placeholder="spellVisualID_2"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="casterAuraSpell">
                  <el-input v-model="spell.casterAuraSpell" placeholder="casterAuraSpell"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="cumulativeAura">
                  <el-input v-model="spell.cumulativeAura" placeholder="cumulativeAura"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="excludeCasterAuraSpell">
                  <el-input v-model="spell.excludeCasterAuraSpell" placeholder="excludeCasterAuraSpell"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="excludeCasterAuraState">
                  <el-input v-model="spell.excludeCasterAuraState" placeholder="excludeCasterAuraState"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="excludeTargetAuraSpell">
                  <el-input v-model="spell.excludeTargetAuraSpell" placeholder="excludeTargetAuraSpell"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="excludeTargetAuraState">
                  <el-input v-model="spell.excludeTargetAuraState" placeholder="excludeTargetAuraState"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="minFactionID">
                  <el-input v-model="spell.minFactionID" placeholder="minFactionID"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="minReputation">
                  <el-input v-model="spell.minReputation" placeholder="minReputation"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="modalNextSpell">
                  <el-input v-model="spell.modalNextSpell" placeholder="modalNextSpell"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="powerDisplayID">
                  <el-input v-model="spell.powerDisplayID" placeholder="powerDisplayID"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="requiredAuraVision">
                  <el-input v-model="spell.requiredAuraVision" placeholder="requiredAuraVision"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="spellPriority">
                  <el-input v-model="spell.spellPriority" placeholder="spellPriority"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="stanceBarOrder">
                  <el-input v-model="spell.stanceBarOrder" placeholder="stanceBarOrder"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="stanceNot">
                  <el-input v-model="spell.stanceNot" placeholder="stanceNot"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="targetAuraSpell">
                  <el-input v-model="spell.targetAuraSpell" placeholder="targetAuraSpell"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="unk_13">
                  <el-input v-model="spell.unk_13" placeholder="unk_13"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="unk_15">
                  <el-input v-model="spell.unk_15" placeholder="unk_15"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
        </el-form>
      </el-tab-pane>
      <el-tab-pane label="效果" name="effect"></el-tab-pane>
      <el-tab-pane label="标识" name="flag"></el-tab-pane>
      <el-tab-pane label="物品" name="item"></el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
export default {
  computed: {
    ...mapState("spell", ["spell"])
  },
  methods: {
    ...mapActions("spell", ["find"]),
    async init() {
      this.loading = true;
      await this.find({ id: this.$route.params.id });
      this.loading = false;
    }
  },
  created() {
    this.init();
  }
};
</script>
