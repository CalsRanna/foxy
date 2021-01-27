<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">
          首页
        </el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/spell' }">
          技能管理
        </el-breadcrumb-item>
        <el-breadcrumb-item>技能详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ spell.nameLangZhCN }}
        <small>
          {{ spell.rankLangZhCN }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="basic" style="margin-top: 16px">
      <el-tab-pane label="基本信息" name="basic">
        <el-form :model="spell" label-position="right" label-width="120px">
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="id">
                  <el-input-number
                    v-model="spell.id"
                    controls-position="right"
                    :loading="initing"
                    placeholder="id"
                    element-loading-spinner="el-icon-loading"
                    element-loading-background="rgba(255, 255, 255, 0.5)"
                  ></el-input-number>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="名称">
                  <el-input
                    v-model="spell.nameLangZhCN"
                    placeholder="nameLangZhCN"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="子名称">
                  <el-input
                    v-model="spell.rankLangZhCN"
                    placeholder="rankLangZhCN"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="描述">
                  <el-input
                    v-model="spell.descriptionLangZhCN"
                    placeholder="descriptionLangZhCN"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="Buff描述">
                  <el-input
                    v-model="spell.auraDescriptionLangZhCN"
                    placeholder="auraDescriptionLangZhCN"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="名称掩码">
                  <el-input
                    v-model="spell.nameLangMask"
                    placeholder="nameLangMask"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="子名称掩码">
                  <el-input
                    v-model="spell.rankLangMask"
                    placeholder="rankLangMask"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="描述掩码">
                  <el-input
                    v-model="spell.descriptionLangMask"
                    placeholder="descriptionLangMask"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="Buff描述掩码">
                  <el-input
                    v-model="spell.auraDescriptionLangMask"
                    placeholder="auraDescriptionLangMask"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="类型">
                  <el-input
                    v-model="spell.category"
                    placeholder="category"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性类型">
                  <el-input
                    v-model="spell.schoolMask"
                    placeholder="schoolMask"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="伤害类型">
                  <el-input
                    v-model="spell.damageClass"
                    placeholder="damageClass"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="mechanic">
                  <el-input
                    v-model="spell.mechanic"
                    placeholder="mechanic"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="驱散类型">
                  <el-input
                    v-model="spell.displayType"
                    placeholder="displayType"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="阻止类型">
                  <el-input
                    v-model="spell.preventionType"
                    placeholder="preventionType"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="施法时间">
                  <el-input
                    v-model="spell.castingTimeIndex"
                    placeholder="castingTimeIndex"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="持续时间">
                  <el-input
                    v-model="spell.durationIndex"
                    placeholder="durationIndex"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="施法距离">
                  <el-input
                    v-model="spell.randeIndex"
                    placeholder="randeIndex"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="描述变量">
                  <el-input
                    v-model="spell.spellDescriptionVariableID"
                    placeholder="spellDescriptionVariableID"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="需要等级">
                  <el-input-number
                    v-model="spell.baseLevel"
                    controls-position="right"
                    placeholder="baseLevel"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="技能等级">
                  <el-input-number
                    v-model="spell.spellLevel"
                    controls-position="right"
                    placeholder="spellLevel"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="最大等级">
                  <el-input-number
                    v-model="spell.maxLevel"
                    controls-position="right"
                    placeholder="maxLevel"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="难度">
                  <el-input
                    v-model="spell.spellDifficultyID"
                    placeholder="spellDifficultyID"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="公共冷却类型">
                  <el-input
                    v-model="spell.startRecoveryCategory"
                    placeholder="startRecoveryCategory"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="公共冷却时间">
                  <el-input-number
                    v-model="spell.startRecoveryTime"
                    controls-position="right"
                    placeholder="startRecoveryTime"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="冷却时间">
                  <el-input-number
                    v-model="spell.recoveryTime"
                    controls-position="right"
                    placeholder="recoveryTime"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="类型冷却时间">
                  <el-input-number
                    v-model="spell.categoryRecoveryTime"
                    controls-position="right"
                    placeholder="categoryRecoveryTime"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="目标类型">
                  <el-input
                    v-model="spell.targetCreatureType"
                    placeholder="targetCreatureType"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="目标">
                  <el-input
                    v-model="spell.targets"
                    placeholder="targets"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="最大目标数">
                  <el-input
                    v-model="spell.maxTargets"
                    placeholder="maxTargets"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="最大目标等级">
                  <el-input
                    v-model="spell.maxTargetLevel"
                    placeholder="maxTargetLevel"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="施法光环规则">
                  <el-input
                    v-model="spell.casterAuraState"
                    placeholder="casterAuraState"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="目标光环规则">
                  <el-input
                    v-model="spell.targetAuraState"
                    placeholder="targetAuraState"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="发射物">
                  <el-input
                    v-model="spell.spellMissileID"
                    placeholder="spellMissileID"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="速度">
                  <el-input
                    v-model="spell.speed"
                    placeholder="speed"
                  ></el-input>
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
                <el-form-item label="需要区域">
                  <el-input
                    v-model="spell.requiredAreasID"
                    placeholder="requiredAreasID"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="requireSpellFoucus">
                  <el-input
                    v-model="spell.requireSpellFoucus"
                    placeholder="requireSpellFoucus"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="面对目标">
                  <el-input
                    v-model="spell.facingCasterFlags"
                    placeholder="facingCasterFlags"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="能量类型">
                  <el-input
                    v-model="spell.powerType"
                    placeholder="powerType"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="符文消耗">
                  <el-input
                    v-model="spell.runeCostID"
                    placeholder="runeCostID"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法力消耗">
                  <el-input
                    v-model="spell.manaCost"
                    placeholder="manaCost"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法力消耗(%)">
                  <el-input
                    v-model="spell.manaCostPct"
                    placeholder="manaCostPct"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法力消耗/级">
                  <el-input
                    v-model="spell.manaCostPerLevel"
                    placeholder="manaCostPerLevel"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法力消耗/秒">
                  <el-input
                    v-model="spell.manaPerSecond"
                    placeholder="manaPerSecond"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法力消耗/秒/级">
                  <el-input
                    v-model="spell.manaPerSecondPerLevel"
                    placeholder="manaPerSecondPerLevel"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="触发标识">
                  <el-input
                    v-model="spell.procFlags"
                    placeholder="procFlags"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="触发几率">
                  <el-input
                    v-model="spell.procChance"
                    placeholder="procChance"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="触发充能">
                  <el-input
                    v-model="spell.procCharges"
                    placeholder="procCharges"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="法术大类">
                  <el-input-number
                    v-model="spell.spellClassSet"
                    controls-position="right"
                    placeholder="spellClassSet"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法术小类1">
                  <el-input-number
                    v-model="spell.spellClassMask_1"
                    controls-position="right"
                    placeholder="spellClassMask_1"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法术小类2">
                  <el-input-number
                    v-model="spell.spellClassMask_2"
                    controls-position="right"
                    placeholder="spellClassMask_2"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法术小类3">
                  <el-input-number
                    v-model="spell.spellClassMask_3"
                    controls-position="right"
                    placeholder="spellClassMask_3"
                  ></el-input-number>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="效果">
                  <el-input
                    v-model="spell.effect_1"
                    placeholder="effect_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="基础值">
                  <el-input
                    v-model="spell.effectBasePoints_1"
                    placeholder="effectBasePoints_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="浮动值">
                  <el-input
                    v-model="spell.effectDieSides_1"
                    placeholder="effectDieSides_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="每级真实值">
                  <el-input
                    v-model="spell.effectRealPointsPerLevel_1"
                    placeholder="effectRealPointsPerLevel_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="machanic">
                  <el-input
                    v-model="spell.effectMachanic_1"
                    placeholder="effectMachanic_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="效果链目标">
                  <el-input
                    v-model="spell.effectChainTargets_1"
                    placeholder="effectChainTargets_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="光环效果">
                  <el-input
                    v-model="spell.effectAura_1"
                    placeholder="effectAura_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="光环效果周期">
                  <el-input
                    v-model="spell.effectAuraPeriod_1"
                    placeholder="effectAuraPeriod_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="目标A">
                  <el-input
                    v-model="spell.implicitTargetA_1"
                    placeholder="implicitTargetA_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="目标B">
                  <el-input
                    v-model="spell.implicitTargetB_1"
                    placeholder="implicitTargetB_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="参数A">
                  <el-input
                    v-model="spell.effectMiscValueA_1"
                    placeholder="effectMiscValueA_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="参数B">
                  <el-input
                    v-model="spell.effectMiscValueB_1"
                    placeholder="effectMiscValueB_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="范围">
                  <el-input
                    v-model="spell.effectRadiusIndex_1"
                    placeholder="effectRadiusIndex_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="倍数">
                  <el-input
                    v-model="spell.effectMultipleValue_1"
                    placeholder="effectMultipleValue_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="奖励乘数">
                  <el-input
                    v-model="spell.effectBonusMultiplier_1"
                    placeholder="effectBonusMultiplier_1"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="effectChainAmplitude_1">
                  <el-input
                    v-model="spell.effectChainAmplitude_1"
                    placeholder="effectChainAmplitude_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectItemType_1">
                  <el-input
                    v-model="spell.effectItemType_1"
                    placeholder="effectItemType_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="触发法术">
                  <el-input
                    v-model="spell.effectTriggerSpell_1"
                    placeholder="effectTriggerSpell_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="每级连击点">
                  <el-input
                    v-model="spell.effectPointsPerCombo_1"
                    placeholder="effectPointsPerCombo_1"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="法术小类掩码1">
                  <el-input
                    v-model="spell.effectSpellClassMask_1"
                    placeholder="effectSpellClassMask_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法术小类掩码2">
                  <el-input
                    v-model="spell.effectSpellClassMask_2"
                    placeholder="effectSpellClassMask_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法术小类掩码3">
                  <el-input
                    v-model="spell.effectSpellClassMask_3"
                    placeholder="effectSpellClassMask_3"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="效果">
                  <el-input
                    v-model="spell.effect_2"
                    placeholder="effect_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="基础值">
                  <el-input
                    v-model="spell.effectBasePoints_2"
                    placeholder="effectBasePoints_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="浮动值">
                  <el-input
                    v-model="spell.effectDieSides_2"
                    placeholder="effectDieSides_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="每级真实值">
                  <el-input
                    v-model="spell.effectRealPointsPerLevel_2"
                    placeholder="effectRealPointsPerLevel_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="machanic">
                  <el-input
                    v-model="spell.effectMachanic_2"
                    placeholder="effectMachanic_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="效果链目标">
                  <el-input
                    v-model="spell.effectChainTargets_2"
                    placeholder="effectChainTargets_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="光环效果">
                  <el-input
                    v-model="spell.effectAura_2"
                    placeholder="effectAura_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="光环效果周期">
                  <el-input
                    v-model="spell.effectAuraPeriod_2"
                    placeholder="effectAuraPeriod_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="目标A">
                  <el-input
                    v-model="spell.implicitTargetA_2"
                    placeholder="implicitTargetA_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="目标B">
                  <el-input
                    v-model="spell.implicitTargetB_2"
                    placeholder="implicitTargetB_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="参数A">
                  <el-input
                    v-model="spell.effectMiscValueA_2"
                    placeholder="effectMiscValueA_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="参数B">
                  <el-input
                    v-model="spell.effectMiscValueB_2"
                    placeholder="effectMiscValueB_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="范围">
                  <el-input
                    v-model="spell.effectRadiusIndex_2"
                    placeholder="effectRadiusIndex_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="倍数">
                  <el-input
                    v-model="spell.effectMultipleValue_2"
                    placeholder="effectMultipleValue_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="奖励系数">
                  <el-input
                    v-model="spell.effectBonusMultiplier_2"
                    placeholder="effectBonusMultiplier_2"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="effectChainAmplitude_2">
                  <el-input
                    v-model="spell.effectChainAmplitude_2"
                    placeholder="effectChainAmplitude_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectItemType_2">
                  <el-input
                    v-model="spell.effectItemType_2"
                    placeholder="effectItemType_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="触发法术">
                  <el-input
                    v-model="spell.effectTriggerSpell_2"
                    placeholder="effectTriggerSpell_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="每级连击点">
                  <el-input
                    v-model="spell.effectPointsPerCombo_2"
                    placeholder="effectPointsPerCombo_2"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="法术小类掩码1">
                  <el-input
                    v-model="spell.effectSpellClassMask_4"
                    placeholder="effectSpellClassMask_4"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法术小类掩码2">
                  <el-input
                    v-model="spell.effectSpellClassMask_5"
                    placeholder="effectSpellClassMask_5"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法术小类掩码3">
                  <el-input
                    v-model="spell.effectSpellClassMask_6"
                    placeholder="effectSpellClassMask_6"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="效果">
                  <el-input
                    v-model="spell.effect_3"
                    placeholder="effect_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="基础值">
                  <el-input
                    v-model="spell.effectBasePoints_3"
                    placeholder="effectBasePoints_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="浮动值">
                  <el-input
                    v-model="spell.effectDieSides_3"
                    placeholder="effectDieSides_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="每级真实值">
                  <el-input
                    v-model="spell.effectRealPointsPerLevel_3"
                    placeholder="effectRealPointsPerLevel_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="machanic">
                  <el-input
                    v-model="spell.effectMachanic_3"
                    placeholder="effectMachanic_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="效果链目标">
                  <el-input
                    v-model="spell.effectChainTargets_3"
                    placeholder="effectChainTargets_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="光环效果">
                  <el-input
                    v-model="spell.effectAura_3"
                    placeholder="effectAura_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="光环效果周期">
                  <el-input
                    v-model="spell.effectAuraPeriod_3"
                    placeholder="effectAuraPeriod_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="参数A">
                  <el-input
                    v-model="spell.effectMiscValueA_3"
                    placeholder="effectMiscValueA_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="参数B">
                  <el-input
                    v-model="spell.effectMiscValueB_3"
                    placeholder="effectMiscValueB_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="目标A">
                  <el-input
                    v-model="spell.implicitTargetA_3"
                    placeholder="implicitTargetA_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="目标B">
                  <el-input
                    v-model="spell.implicitTargetB_3"
                    placeholder="implicitTargetB_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="范围">
                  <el-input
                    v-model="spell.effectRadiusIndex_3"
                    placeholder="effectRadiusIndex_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="倍数">
                  <el-input
                    v-model="spell.effectMultipleValue_3"
                    placeholder="effectMultipleValue_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="奖励乘数">
                  <el-input
                    v-model="spell.effectBonusMultiplier_3"
                    placeholder="effectBonusMultiplier_3"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="effectChainAmplitude_3">
                  <el-input
                    v-model="spell.effectChainAmplitude_3"
                    placeholder="effectChainAmplitude_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="effectItemType_3">
                  <el-input
                    v-model="spell.effectItemType_3"
                    placeholder="effectItemType_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="触发法术">
                  <el-input
                    v-model="spell.effectTriggerSpell_3"
                    placeholder="effectTriggerSpell_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="每级连击点">
                  <el-input
                    v-model="spell.effectPointsPerCombo_3"
                    placeholder="effectPointsPerCombo_3"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="法术小类掩码1">
                  <el-input
                    v-model="spell.effectSpellClassMask_7"
                    placeholder="effectSpellClassMask_7"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法术小类掩码2">
                  <el-input
                    v-model="spell.effectSpellClassMask_8"
                    placeholder="effectSpellClassMask_8"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法术小类掩码3">
                  <el-input
                    v-model="spell.effectSpellClassMask_9"
                    placeholder="effectSpellClassMask_9"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="totem_1">
                  <el-input
                    v-model="spell.totem_1"
                    placeholder="totem_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="totem_2">
                  <el-input
                    v-model="spell.totem_2"
                    placeholder="totem_2"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="物品类型">
                  <el-input
                    v-model="spell.equippedItemClass"
                    placeholder="equippedItemClass"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="物品子类型">
                  <el-input
                    v-model="spell.equippedItemSubClassMask"
                    placeholder="equippedItemSubClassMask"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="物品佩戴位置">
                  <el-input
                    v-model="spell.equippedItemInventoryTypeMask"
                    placeholder="equippedItemInventoryTypeMask"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="消耗物品1">
                  <el-input
                    v-model="spell.reagent_1"
                    placeholder="reagent_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗数量">
                  <el-input
                    v-model="spell.regentCount_1"
                    placeholder="regentCount_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗物品2">
                  <el-input
                    v-model="spell.reagent_2"
                    placeholder="reagent_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗数量">
                  <el-input
                    v-model="spell.regentCount_2"
                    placeholder="regentCount_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗物品3">
                  <el-input
                    v-model="spell.reagent_3"
                    placeholder="reagent_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗数量">
                  <el-input
                    v-model="spell.regentCount_3"
                    placeholder="regentCount_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗物品4">
                  <el-input
                    v-model="spell.reagent_4"
                    placeholder="reagent_4"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗数量">
                  <el-input
                    v-model="spell.regentCount_4"
                    placeholder="regentCount_4"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗物品5">
                  <el-input
                    v-model="spell.reagent_5"
                    placeholder="reagent_5"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗数量">
                  <el-input
                    v-model="spell.regentCount_5"
                    placeholder="regentCount_5"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗物品6">
                  <el-input
                    v-model="spell.reagent_6"
                    placeholder="reagent_6"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗数量">
                  <el-input
                    v-model="spell.regentCount_6"
                    placeholder="regentCount_6"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗物品7">
                  <el-input
                    v-model="spell.reagent_7"
                    placeholder="reagent_7"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗数量">
                  <el-input
                    v-model="spell.regentCount_7"
                    placeholder="regentCount_7"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗物品8">
                  <el-input
                    v-model="spell.reagent_8"
                    placeholder="reagent_8"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗数量">
                  <el-input
                    v-model="spell.regentCount_8"
                    placeholder="regentCount_8"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="打断标识">
                  <el-input
                    v-model="spell.interruptFlags"
                    placeholder="interruptFlags"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="光环打断标识">
                  <el-input
                    v-model="spell.aruaInterruptFlags"
                    placeholder="aruaInterruptFlags"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="引导打断标识">
                  <el-input
                    v-model="spell.channelInterruptFlags"
                    placeholder="channelInterruptFlags"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性">
                  <el-input
                    v-model="spell.attributes"
                    placeholder="attributes"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="额外属性1">
                  <el-input
                    v-model="spell.attributesExtra_1"
                    placeholder="attributesExtra_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="额外属性2">
                  <el-input
                    v-model="spell.attributesExtra_2"
                    placeholder="attributesExtra_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="额外属性3">
                  <el-input
                    v-model="spell.attributesExtra_3"
                    placeholder="attributesExtra_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="额外属性4">
                  <el-input
                    v-model="spell.attributesExtra_4"
                    placeholder="attributesExtra_4"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="额外属性5">
                  <el-input
                    v-model="spell.attributesExtra_5"
                    placeholder="attributesExtra_5"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="额外属性6">
                  <el-input
                    v-model="spell.attributesExtra_6"
                    placeholder="attributesExtra_6"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="额外属性7">
                  <el-input
                    v-model="spell.attributesExtra_7"
                    placeholder="attributesExtra_7"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="图标">
                  <el-input-number
                    v-model="spell.spellIconID"
                    controls-position="right"
                    placeholder="spellIconID"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="激活图标">
                  <el-input-number
                    v-model="spell.activeIconID"
                    controls-position="right"
                    placeholder="activeIconID"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="视觉效果1">
                  <el-input-number
                    v-model="spell.spellVisualID_1"
                    controls-position="right"
                    placeholder="spellVisualID_1"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="视觉效果2">
                  <el-input-number
                    v-model="spell.spellVisualID_2"
                    controls-position="right"
                    placeholder="spellVisualID_2"
                  ></el-input-number>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="casterAuraSpell">
                  <el-input
                    v-model="spell.casterAuraSpell"
                    placeholder="casterAuraSpell"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="累加光环">
                  <el-input
                    v-model="spell.cumulativeAura"
                    placeholder="cumulativeAura"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="minFactionID">
                  <el-input
                    v-model="spell.minFactionID"
                    placeholder="minFactionID"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="minReputation">
                  <el-input
                    v-model="spell.minReputation"
                    placeholder="minReputation"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="excludeCasterAuraSpell">
                  <el-input
                    v-model="spell.excludeCasterAuraSpell"
                    placeholder="excludeCasterAuraSpell"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="excludeCasterAuraState">
                  <el-input
                    v-model="spell.excludeCasterAuraState"
                    placeholder="excludeCasterAuraState"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="excludeTargetAuraSpell">
                  <el-input
                    v-model="spell.excludeTargetAuraSpell"
                    placeholder="excludeTargetAuraSpell"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="excludeTargetAuraState">
                  <el-input
                    v-model="spell.excludeTargetAuraState"
                    placeholder="excludeTargetAuraState"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="spellPriority">
                  <el-input
                    v-model="spell.spellPriority"
                    placeholder="spellPriority"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="modalNextSpell">
                  <el-input
                    v-model="spell.modalNextSpell"
                    placeholder="modalNextSpell"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="powerDisplayID">
                  <el-input
                    v-model="spell.powerDisplayID"
                    placeholder="powerDisplayID"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="requiredAuraVision">
                  <el-input
                    v-model="spell.requiredAuraVision"
                    placeholder="requiredAuraVision"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="targetAuraSpell">
                  <el-input
                    v-model="spell.targetAuraSpell"
                    placeholder="targetAuraSpell"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="stanceBarOrder">
                  <el-input
                    v-model="spell.stanceBarOrder"
                    placeholder="stanceBarOrder"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="stances">
                  <el-input
                    v-model="spell.stances"
                    placeholder="stances"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="stanceNot">
                  <el-input
                    v-model="spell.stanceNot"
                    placeholder="stanceNot"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="unk_13">
                  <el-input
                    v-model="spell.unk_13"
                    placeholder="unk_13"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="unk_15">
                  <el-input
                    v-model="spell.unk_15"
                    placeholder="unk_15"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-button type="primary" :loading="loading" @click="store">
              保存
            </el-button>
            <el-button @click="cancel">返回</el-button>
          </el-card>
        </el-form>
      </el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import { mapState, mapActions } from "vuex";
export default {
  data() {
    return {
      initing: false,
      loading: false,
      creating: false,
    };
  },
  computed: {
    ...mapState("spell", ["spell"]),
    credential() {
      return {
        id: this.$route.params.id,
      };
    },
  },
  methods: {
    ...mapActions("spell", [
      "storeSpell",
      "findSpell",
      "updateSpell",
      "createSpell",
    ]),
    async store() {
      this.loading = true;
      if (this.creating) {
        this.storeSpell(this.spell);
        this.creating = false;
      } else {
        await this.updateSpell({
          credential: this.credential,
          spell: this.spell,
        });
      }
      this.loading = false;
    },
    cancel() {
      this.$router.go(-1);
    },
    async init() {
      this.initing = true;
      if (this.$route.path == "/spell/create") {
        this.creating = true;
        await this.createSpell();
      } else {
        await this.findSpell(this.credential);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
};
</script>
