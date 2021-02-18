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
        {{ spell.Name_Lang_zhCN }}
        <small>
          {{ spell.Description_Lang_zhCN }}
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
                    v-model="spell.ID"
                    controls-position="right"
                    :loading="initing"
                    placeholder="ID"
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
                    v-model="spell.Name_Lang_zhCN"
                    placeholder="Name_Lang_zhCN"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="子名称">
                  <el-input
                    v-model="spell.NameSubtext_Lang_zhCN"
                    placeholder="NameSubtext_Lang_zhCN"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="描述">
                  <el-input
                    v-model="spell.Description_Lang_zhCN"
                    placeholder="Description_Lang_zhCN"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="Buff描述">
                  <el-input
                    v-model="spell.AuraDescription_Lang_zhCN"
                    placeholder="AuraDescription_Lang_zhCN"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="名称掩码">
                  <el-input
                    v-model="spell.Name_Lang_Mask"
                    placeholder="Name_Lang_Mask"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="子名称掩码">
                  <el-input
                    v-model="spell.NameSubtext_Lang_Mask"
                    placeholder="NameSubtext_Lang_Mask"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="描述掩码">
                  <el-input
                    v-model="spell.Description_Lang_Mask"
                    placeholder="Description_Lang_Mask"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="Buff描述掩码">
                  <el-input
                    v-model="spell.AuraDescription_Lang_Mask"
                    placeholder="AuraDescription_Lang_Mask"
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
                    v-model="spell.Category"
                    placeholder="Category"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性类型">
                  <flag-editor
                    v-model="spell.SchoolMask"
                    title="属性类型编辑器"
                    :flags="schoolMasks"
                    placeholder="SchoolMask"
                  ></flag-editor>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="DefenseType">
                  <el-input
                    v-model="spell.DefenseType"
                    placeholder="DefenseType"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="Mechanic">
                  <el-input
                    v-model="spell.Mechanic"
                    placeholder="Mechanic"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="驱散类型">
                  <el-input
                    v-model="spell.DispelType"
                    placeholder="DispelType"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="阻止类型">
                  <el-input
                    v-model="spell.PreventionType"
                    placeholder="PreventionType"
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
                    v-model="spell.CastingTimeIndex"
                    placeholder="CastingTimeIndex"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="持续时间">
                  <spell-duration-selector
                    v-model="spell.DurationIndex"
                    placeholder="DurationIndex"
                  ></spell-duration-selector>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="施法距离">
                  <el-input
                    v-model="spell.RangeIndex"
                    placeholder="RangeIndex"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="描述变量">
                  <el-input
                    v-model="spell.SpellDescriptionVariableID"
                    placeholder="SpellDescriptionVariableID"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="需要等级">
                  <el-input-number
                    v-model="spell.BaseLevel"
                    controls-position="right"
                    placeholder="BaseLevel"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="技能等级">
                  <el-input-number
                    v-model="spell.SpellLevel"
                    controls-position="right"
                    placeholder="SpellLevel"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="最大等级">
                  <el-input-number
                    v-model="spell.MaxLevel"
                    controls-position="right"
                    placeholder="MaxLevel"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="难度">
                  <el-input
                    v-model="spell.SpellDifficultyID"
                    placeholder="SpellDifficultyID"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="公共冷却类型">
                  <el-input
                    v-model="spell.StartRecoveryCategory"
                    placeholder="StartRecoveryCategory"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="公共冷却时间">
                  <el-input-number
                    v-model="spell.StartRecoveryTime"
                    controls-position="right"
                    placeholder="StartRecoveryTime"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="冷却时间">
                  <el-input-number
                    v-model="spell.RecoveryTime"
                    controls-position="right"
                    placeholder="RecoveryTime"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="类型冷却时间">
                  <el-input-number
                    v-model="spell.CategoryRecoveryTime"
                    controls-position="right"
                    placeholder="categoryRecoveryTime"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="目标类型">
                  <el-input
                    v-model="spell.TargetCreatureType"
                    placeholder="TargetCreatureType"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="目标">
                  <el-input
                    v-model="spell.Targets"
                    placeholder="Targets"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="最大目标数">
                  <el-input
                    v-model="spell.MaxTargets"
                    placeholder="MaxTargets"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="最大目标等级">
                  <el-input
                    v-model="spell.MaxTargetLevel"
                    placeholder="MaxTargetLevel"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="施法光环规则">
                  <el-input
                    v-model="spell.CasterAuraState"
                    placeholder="casterAuraState"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="目标光环规则">
                  <el-input
                    v-model="spell.TargetAuraState"
                    placeholder="TargetAuraState"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="发射物">
                  <el-input
                    v-model="spell.SpellMissileID"
                    placeholder="SpellMissileID"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="速度">
                  <el-input
                    v-model="spell.Speed"
                    placeholder="Speed"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="RequiredTotemCategoryID_1">
                  <el-input
                    v-model="spell.RequiredTotemCategoryID_1"
                    placeholder="RequiredTotemCategoryID_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="RequiredTotemCategoryID_2">
                  <el-input
                    v-model="spell.RequiredTotemCategoryID_2"
                    placeholder="RequiredTotemCategoryID_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="需要区域">
                  <el-input
                    v-model="spell.RequiredAreasID"
                    placeholder="RequiredAreasID"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="RequiresSpellFocus">
                  <el-input
                    v-model="spell.RequiresSpellFocus"
                    placeholder="RequiresSpellFocus"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="面对目标">
                  <el-input
                    v-model="spell.FacingCasterFlags"
                    placeholder="FacingCasterFlags"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="PowerDisplayID">
                  <el-input
                    v-model="spell.PowerDisplayID"
                    placeholder="PowerDisplayID"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="能量类型">
                  <el-input
                    v-model="spell.PowerType"
                    placeholder="PowerType"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="符文消耗">
                  <el-input-number
                    v-model="spell.RuneCostID"
                    controls-position="right"
                    placeholder="RuneCostID"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法力消耗">
                  <el-input-number
                    v-model="spell.ManaCost"
                    controls-position="right"
                    placeholder="ManaCost"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法力消耗(%)">
                  <el-input-number
                    v-model="spell.ManaCostPct"
                    controls-position="right"
                    placeholder="ManaCostPct"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法力消耗/级">
                  <el-input-number
                    v-model="spell.ManaCostPerLevel"
                    controls-position="right"
                    placeholder="ManaCostPerLevel"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法力消耗/秒">
                  <el-input-number
                    v-model="spell.ManaPerSecond"
                    controls-position="right"
                    placeholder="ManaPerSecond"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法力消耗/秒/级">
                  <el-input-number
                    v-model="spell.ManaPerSecondPerLevel"
                    controls-position="right"
                    placeholder="ManaPerSecondPerLevel"
                  ></el-input-number>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="打断标识">
                  <flag-editor
                    v-model="spell.InterruptFlags"
                    title="打断标识编辑器"
                    :flags="interruptFlags"
                    placeholder="InterruptFlags"
                  ></flag-editor>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="光环打断标识">
                  <flag-editor
                    v-model="spell.AuraInterruptFlags"
                    title="光环打断标识编辑器"
                    :flags="auraInterruptFlags"
                    placeholder="AuraInterruptFlags"
                  ></flag-editor>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="引导打断标识">
                  <flag-editor
                    v-model="spell.ChannelInterruptFlags"
                    title="引导打断标识编辑器"
                    :flags="auraInterruptFlags"
                    placeholder="ChannelInterruptFlags"
                  ></flag-editor>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性">
                  <flag-editor
                    v-model="spell.Attributes"
                    title="属性编辑器"
                    :flags="attributes"
                    placeholder="Attributes"
                  ></flag-editor>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="额外属性1">
                  <flag-editor
                    v-model="spell.AttributesEx"
                    title="额外属性1编辑器"
                    :flags="attributesEx"
                    placeholder="AttributesEx"
                  ></flag-editor>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="额外属性2">
                  <flag-editor
                    v-model="spell.AttributesExB"
                    title="额外属性2编辑器"
                    :flags="attributesExB"
                    placeholder="AttributesExB"
                  ></flag-editor>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="额外属性3">
                  <flag-editor
                    v-model="spell.AttributesExC"
                    title="额外属性3编辑器"
                    :flags="attributesExC"
                    placeholder="AttributesExC"
                  ></flag-editor>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="额外属性4">
                  <flag-editor
                    v-model="spell.AttributesExD"
                    title="额外属性4编辑器"
                    :flags="attributesExD"
                    placeholder="AttributesExD"
                  ></flag-editor>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="额外属性5">
                  <flag-editor
                    v-model="spell.AttributesExE"
                    title="额外属性5编辑器"
                    :flags="attributesExE"
                    placeholder="AttributesExE"
                  ></flag-editor>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="额外属性6">
                  <flag-editor
                    v-model="spell.AttributesExF"
                    title="额外属性6编辑器"
                    :flags="attributesExF"
                    placeholder="AttributesExF"
                  ></flag-editor>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="额外属性7">
                  <flag-editor
                    v-model="spell.AttributesExG"
                    title="额外属性7编辑器"
                    :flags="attributesExG"
                    placeholder="AttributesExG"
                  ></flag-editor>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="触发标识">
                  <flag-editor
                    v-model="spell.ProcTypeMask"
                    title="触发标识编辑器"
                    :flags="procTypeMasks"
                    placeholder="ProcTypeMask"
                  ></flag-editor>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="触发几率">
                  <el-input-number
                    v-model="spell.ProcChance"
                    controls-position="right"
                    placeholder="ProcChance"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="触发充能">
                  <el-input-number
                    v-model="spell.ProcCharges"
                    controls-position="right"
                    placeholder="ProcCharges"
                  ></el-input-number>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="法术大类">
                  <el-input-number
                    v-model="spell.SpellClassSet"
                    controls-position="right"
                    placeholder="SpellClassSet"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法术小类1">
                  <el-input-number
                    v-model="spell.SpellClassMask_1"
                    controls-position="right"
                    placeholder="SpellClassMask_1"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法术小类2">
                  <el-input-number
                    v-model="spell.SpellClassMask_2"
                    controls-position="right"
                    placeholder="SpellClassMask_2"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法术小类3">
                  <el-input-number
                    v-model="spell.SpellClassMask_3"
                    controls-position="right"
                    placeholder="SpellClassMask_3"
                  ></el-input-number>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="效果">
                  <el-select
                    v-model="spell.Effect_1"
                    filterable
                    placeholder="Effect_1"
                  >
                    <el-option
                      v-for="(effect, index) in effects"
                      :key="`effect_1-${index}`"
                      :label="effect"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="基础值">
                  <el-input-number
                    v-model="spell.EffectBasePoints_1"
                    controls-position="right"
                    placeholder="EffectBasePoints_1"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="浮动值">
                  <el-input-number
                    v-model="spell.EffectDieSides_1"
                    controls-position="right"
                    placeholder="EffectDieSides_1"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="每级真实值">
                  <el-input-number
                    v-model="spell.EffectRealPointsPerLevel_1"
                    controls-position="right"
                    placeholder="EffectRealPointsPerLevel_1"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="Mechanic">
                  <el-input
                    v-model="spell.EffectMechanic_1"
                    placeholder="EffectMechanic_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="效果链目标">
                  <el-input
                    v-model="spell.EffectChainTargets_1"
                    placeholder="EffectChainTargets_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="光环效果">
                  <el-select
                    v-model="spell.EffectAura_1"
                    filterable
                    placeholder="EffectAura_1"
                  >
                    <el-option
                      v-for="(aura, index) in auras"
                      :key="`effectAura_1-${index}`"
                      :label="aura"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="光环效果周期">
                  <el-input
                    v-model="spell.EffectAuraPeriod_1"
                    placeholder="EffectAuraPeriod_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="目标A">
                  <el-select
                    v-model="spell.ImplicitTargetA_1"
                    filterable
                    placeholder="ImplicitTargetA_1"
                  >
                    <el-option
                      v-for="(implicitTarget, index) in implicitTargets"
                      :key="`implicitTargetA_1-${index}`"
                      :label="implicitTarget"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="目标B">
                  <el-select
                    v-model="spell.ImplicitTargetB_1"
                    filterable
                    placeholder="ImplicitTargetB_1"
                  >
                    <el-option
                      v-for="(implicitTarget, index) in implicitTargets"
                      :key="`implicitTargetB_1-${index}`"
                      :label="implicitTarget"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="参数A">
                  <el-input
                    v-model="spell.EffectMiscValue_1"
                    placeholder="EffectMiscValue_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="参数B">
                  <el-input
                    v-model="spell.EffectMiscValueB_1"
                    placeholder="EffectMiscValueB_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="范围">
                  <el-input
                    v-model="spell.EffectRadiusIndex_1"
                    placeholder="EffectRadiusIndex_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="倍数">
                  <el-input
                    v-model="spell.EffectMultipleValue_1"
                    placeholder="EffectMultipleValue_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="奖励乘数">
                  <el-input
                    v-model="spell.EffectBonusMultiplier_1"
                    placeholder="EffectBonusMultiplier_1"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="EffectChainAmplitude_1">
                  <el-input
                    v-model="spell.EffectChainAmplitude_1"
                    placeholder="EffectChainAmplitude_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="EffectItemType_1">
                  <el-input
                    v-model="spell.EffectItemType_1"
                    placeholder="EffectItemType_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="触发法术">
                  <el-input
                    v-model="spell.EffectTriggerSpell_1"
                    placeholder="EffectTriggerSpell_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="每级连击点">
                  <el-input
                    v-model="spell.EffectPointsPerCombo_1"
                    placeholder="EffectPointsPerCombo_1"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="法术小类掩码1">
                  <el-input
                    v-model="spell.EffectSpellClassMaskA_1"
                    placeholder="EffectSpellClassMaskA_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法术小类掩码2">
                  <el-input
                    v-model="spell.EffectSpellClassMaskA_2"
                    placeholder="EffectSpellClassMaskA_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法术小类掩码3">
                  <el-input
                    v-model="spell.EffectSpellClassMaskA_3"
                    placeholder="EffectSpellClassMaskA_3"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="效果">
                  <el-select
                    v-model="spell.Effect_2"
                    filterable
                    placeholder="Effect_2"
                  >
                    <el-option
                      v-for="(effect, index) in effects"
                      :key="`effect_2-${index}`"
                      :label="effect"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="基础值">
                  <el-input-number
                    v-model="spell.EffectBasePoints_2"
                    controls-position="right"
                    placeholder="EffectBasePoints_2"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="浮动值">
                  <el-input-number
                    v-model="spell.EffectDieSides_2"
                    controls-position="right"
                    placeholder="EffectDieSides_2"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="每级真实值">
                  <el-input-number
                    v-model="spell.EffectRealPointsPerLevel_2"
                    controls-position="right"
                    placeholder="EffectRealPointsPerLevel_2"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="Mechanic">
                  <el-input
                    v-model="spell.EffectMechanic_2"
                    placeholder="EffectMechanic_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="效果链目标">
                  <el-input
                    v-model="spell.EffectChainTargets_2"
                    placeholder="EffectChainTargets_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="光环效果">
                  <el-select
                    v-model="spell.EffectAura_2"
                    filterable
                    placeholder="EffectAura_2"
                  >
                    <el-option
                      v-for="(aura, index) in auras"
                      :key="`effectAura_2-${index}`"
                      :label="aura"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="光环效果周期">
                  <el-input
                    v-model="spell.EffectAuraPeriod_2"
                    placeholder="EffectAuraPeriod_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="目标A">
                  <el-select
                    v-model="spell.ImplicitTargetA_2"
                    filterable
                    placeholder="ImplicitTargetA_2"
                  >
                    <el-option
                      v-for="(implicitTarget, index) in implicitTargets"
                      :key="`implicitTargetA_2-${index}`"
                      :label="implicitTarget"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="目标B">
                  <el-select
                    v-model="spell.ImplicitTargetB_2"
                    filterable
                    placeholder="ImplicitTargetB_2"
                  >
                    <el-option
                      v-for="(implicitTarget, index) in implicitTargets"
                      :key="`implicitTargetB_2-${index}`"
                      :label="implicitTarget"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="参数A">
                  <el-input
                    v-model="spell.EffectMiscValue_2"
                    placeholder="EffectMiscValue_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="参数B">
                  <el-input
                    v-model="spell.EffectMiscValueB_2"
                    placeholder="EffectMiscValueB_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="范围">
                  <el-input
                    v-model="spell.EffectRadiusIndex_2"
                    placeholder="EffectRadiusIndex_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="倍数">
                  <el-input
                    v-model="spell.EffectMultipleValue_2"
                    placeholder="EffectMultipleValue_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="奖励系数">
                  <el-input
                    v-model="spell.EffectBonusMultiplier_2"
                    placeholder="EffectBonusMultiplier_2"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="EffectChainAmplitude_2">
                  <el-input
                    v-model="spell.EffectChainAmplitude_2"
                    placeholder="EffectChainAmplitude_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="EffectItemType_2">
                  <el-input
                    v-model="spell.EffectItemType_2"
                    placeholder="EffectItemType_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="触发法术">
                  <el-input
                    v-model="spell.EffectTriggerSpell_2"
                    placeholder="EffectTriggerSpell_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="每级连击点">
                  <el-input
                    v-model="spell.EffectPointsPerCombo_2"
                    placeholder="EffectPointsPerCombo_2"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="法术小类掩码1">
                  <el-input
                    v-model="spell.EffectSpellClassMaskB_1"
                    placeholder="EffectSpellClassMaskB_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法术小类掩码2">
                  <el-input
                    v-model="spell.EffectSpellClassMaskB_2"
                    placeholder="EffectSpellClassMaskB_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法术小类掩码3">
                  <el-input
                    v-model="spell.EffectSpellClassMaskB_3"
                    placeholder="EffectSpellClassMaskB_3"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="效果">
                  <el-select
                    v-model="spell.Effect_3"
                    filterable
                    placeholder="Effect_3"
                  >
                    <el-option
                      v-for="(effect, index) in effects"
                      :key="`effect_3-${index}`"
                      :label="effect"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="基础值">
                  <el-input-number
                    v-model="spell.EffectBasePoints_3"
                    controls-position="right"
                    placeholder="EffectBasePoints_3"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="浮动值">
                  <el-input-number
                    v-model="spell.EffectDieSides_3"
                    controls-position="right"
                    placeholder="EffectDieSides_3"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="每级真实值">
                  <el-input-number
                    v-model="spell.EffectRealPointsPerLevel_3"
                    controls-position="right"
                    placeholder="EffectRealPointsPerLevel_3"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="Mechanic">
                  <el-input
                    v-model="spell.EffectMechanic_3"
                    placeholder="EffectMechanic_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="效果链目标">
                  <el-input
                    v-model="spell.EffectChainTargets_3"
                    placeholder="EffectChainTargets_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="光环效果">
                  <el-select
                    v-model="spell.EffectAura_3"
                    filterable
                    placeholder="EffectAura_3"
                  >
                    <el-option
                      v-for="(aura, index) in auras"
                      :key="`effectAura_3-${index}`"
                      :label="aura"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="光环效果周期">
                  <el-input
                    v-model="spell.EffectAuraPeriod_3"
                    placeholder="EffectAuraPeriod_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="目标A">
                  <el-select
                    v-model="spell.ImplicitTargetA_3"
                    filterable
                    placeholder="ImplicitTargetA_3"
                  >
                    <el-option
                      v-for="(implicitTarget, index) in implicitTargets"
                      :key="`implicitTargetA_3-${index}`"
                      :label="implicitTarget"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="目标B">
                  <el-select
                    v-model="spell.ImplicitTargetB_3"
                    filterable
                    placeholder="ImplicitTargetB_3"
                  >
                    <el-option
                      v-for="(implicitTarget, index) in implicitTargets"
                      :key="`implicitTargetB_3-${index}`"
                      :label="implicitTarget"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="参数A">
                  <el-input
                    v-model="spell.EffectMiscValue_3"
                    placeholder="EffectMiscValue_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="参数B">
                  <el-input
                    v-model="spell.EffectMiscValueB_3"
                    placeholder="EffectMiscValueB_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="范围">
                  <el-input
                    v-model="spell.EffectRadiusIndex_3"
                    placeholder="EffectRadiusIndex_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="倍数">
                  <el-input
                    v-model="spell.EffectMultipleValue_3"
                    placeholder="EffectMultipleValue_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="奖励乘数">
                  <el-input
                    v-model="spell.EffectBonusMultiplier_3"
                    placeholder="EffectBonusMultiplier_3"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="EffectChainAmplitude_3">
                  <el-input
                    v-model="spell.EffectChainAmplitude_3"
                    placeholder="EffectChainAmplitude_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="EffectItemType_3">
                  <el-input
                    v-model="spell.EffectItemType_3"
                    placeholder="EffectItemType_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="触发法术">
                  <el-input
                    v-model="spell.EffectTriggerSpell_3"
                    placeholder="EffectTriggerSpell_3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="每级连击点">
                  <el-input
                    v-model="spell.EffectPointsPerCombo_3"
                    placeholder="EffectPointsPerCombo_3"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="法术小类掩码1">
                  <el-input
                    v-model="spell.EffectSpellClassMaskC_1"
                    placeholder="EffectSpellClassMaskC_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法术小类掩码2">
                  <el-input
                    v-model="spell.EffectSpellClassMaskC_2"
                    placeholder="EffectSpellClassMaskC_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法术小类掩码3">
                  <el-input
                    v-model="spell.EffectSpellClassMaskC_3"
                    placeholder="EffectSpellClassMaskC_3"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="Totem_1">
                  <el-input
                    v-model="spell.Totem_1"
                    placeholder="Totem_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="Totem_2">
                  <el-input
                    v-model="spell.Totem_2"
                    placeholder="Totem_2"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="物品类型">
                  <el-input
                    v-model="spell.EquippedItemClass"
                    placeholder="EquippedItemClass"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="物品子类型">
                  <el-input
                    v-model="spell.EquippedItemSubclass"
                    placeholder="EquippedItemSubclass"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="物品佩戴位置">
                  <el-input
                    v-model="spell.EquippedItemInvTypes"
                    placeholder="EquippedItemInvTypes"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="消耗物品1">
                  <item-template-selector
                    v-model="spell.Reagent_1"
                    placeholder="Reagent_1"
                  ></item-template-selector>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗数量">
                  <el-input-number
                    v-model="spell.ReagentCount_1"
                    controls-position="right"
                    placeholder="ReagentCount_1"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗物品2">
                  <item-template-selector
                    v-model="spell.Reagent_2"
                    placeholder="Reagent_2"
                  ></item-template-selector>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗数量">
                  <el-input-number
                    v-model="spell.ReagentCount_2"
                    controls-position="right"
                    placeholder="ReagentCount_2"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗物品3">
                  <item-template-selector
                    v-model="spell.Reagent_3"
                    placeholder="Reagent_3"
                  ></item-template-selector>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗数量">
                  <el-input-number
                    v-model="spell.ReagentCount_3"
                    controls-position="right"
                    placeholder="ReagentCount_3"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗物品4">
                  <item-template-selector
                    v-model="spell.Reagent_4"
                    placeholder="Reagent_4"
                  ></item-template-selector>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗数量">
                  <el-input-number
                    v-model="spell.ReagentCount_4"
                    controls-position="right"
                    placeholder="ReagentCount_4"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗物品5">
                  <item-template-selector
                    v-model="spell.Reagent_5"
                    placeholder="Reagent_5"
                  ></item-template-selector>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗数量">
                  <el-input-number
                    v-model="spell.ReagentCount_5"
                    controls-position="right"
                    placeholder="ReagentCount_5"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗物品6">
                  <item-template-selector
                    v-model="spell.Reagent_6"
                    placeholder="Reagent_6"
                  ></item-template-selector>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗数量">
                  <el-input-number
                    v-model="spell.ReagentCount_6"
                    controls-position="right"
                    placeholder="ReagentCount_6"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗物品7">
                  <item-template-selector
                    v-model="spell.Reagent_7"
                    placeholder="Reagent_7"
                  ></item-template-selector>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗数量">
                  <el-input-number
                    v-model="spell.ReagentCount_7"
                    controls-position="right"
                    placeholder="ReagentCount_7"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗物品8">
                  <item-template-selector
                    v-model="spell.Reagent_8"
                    placeholder="Reagent_8"
                  ></item-template-selector>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="消耗数量">
                  <el-input-number
                    v-model="spell.ReagentCount_8"
                    controls-position="right"
                    placeholder="ReagentCount_8"
                  ></el-input-number>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="图标">
                  <el-input-number
                    v-model="spell.SpellIconID"
                    controls-position="right"
                    placeholder="SpellIconID"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="激活图标">
                  <el-input-number
                    v-model="spell.ActiveIconID"
                    controls-position="right"
                    placeholder="ActiveIconID"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="视觉效果1">
                  <el-input-number
                    v-model="spell.SpellVisualID_1"
                    controls-position="right"
                    placeholder="SpellVisualID_1"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="视觉效果2">
                  <el-input-number
                    v-model="spell.SpellVisualID_2"
                    controls-position="right"
                    placeholder="SpellVisualID_2"
                  ></el-input-number>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="CasterAuraSpell">
                  <el-input
                    v-model="spell.CasterAuraSpell"
                    placeholder="CasterAuraSpell"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="累加光环">
                  <el-input
                    v-model="spell.CumulativeAura"
                    placeholder="CumulativeAura"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="MinFactionID">
                  <el-input
                    v-model="spell.MinFactionID"
                    placeholder="MinFactionID"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="MinReputation">
                  <el-input
                    v-model="spell.MinReputation"
                    placeholder="MinReputation"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="ExcludeCasterAuraSpell">
                  <el-input
                    v-model="spell.ExcludeCasterAuraSpell"
                    placeholder="ExcludeCasterAuraSpell"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="ExcludeCasterAuraState">
                  <el-input
                    v-model="spell.ExcludeCasterAuraState"
                    placeholder="ExcludeCasterAuraState"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="ExcludeTargetAuraSpell">
                  <el-input
                    v-model="spell.ExcludeTargetAuraSpell"
                    placeholder="ExcludeTargetAuraSpell"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="ExcludeTargetAuraState">
                  <el-input
                    v-model="spell.ExcludeTargetAuraState"
                    placeholder="ExcludeTargetAuraState"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="SpellPriority">
                  <el-input
                    v-model="spell.SpellPriority"
                    placeholder="SpellPriority"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="ModalNextSpell">
                  <el-input
                    v-model="spell.ModalNextSpell"
                    placeholder="ModalNextSpell"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="RequiredAuraVision">
                  <el-input
                    v-model="spell.RequiredAuraVision"
                    placeholder="RequiredAuraVision"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="TargetAuraSpell">
                  <el-input
                    v-model="spell.TargetAuraSpell"
                    placeholder="TargetAuraSpell"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="StanceBarOrder">
                  <el-input
                    v-model="spell.StanceBarOrder"
                    placeholder="StanceBarOrder"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="ShapeshiftMask">
                  <el-input
                    v-model="spell.ShapeshiftMask"
                    placeholder="ShapeshiftMask"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="Unk_13">
                  <el-input
                    v-model="spell.Unk_13"
                    placeholder="Unk_13"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="ShapeshiftExclude">
                  <el-input
                    v-model="spell.ShapeshiftExclude"
                    placeholder="ShapeshiftExclude"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="Unk_15">
                  <el-input
                    v-model="spell.Unk_15"
                    placeholder="Unk_15"
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
import {
  effects,
  auras,
  interruptFlags,
  auraInterruptFlags,
  attributes,
  attributesEx,
  attributesExB,
  attributesExC,
  attributesExD,
  attributesExE,
  attributesExF,
  attributesExG,
  procTypeMasks,
  implicitTargets,
  schoolMasks,
} from "@/locales/spell";

import FlagEditor from "@/components/FlagEditor";

import { mapState, mapActions } from "vuex";
import ItemTemplateSelector from "@/components/ItemTemplateSelector.vue";
import SpellDurationSelector from "@/components/SpellDurationSelector.vue";

export default {
  data() {
    return {
      initing: false,
      loading: false,
      creating: false,
      effects: effects,
      auras: auras,
      interruptFlags: interruptFlags,
      auraInterruptFlags: auraInterruptFlags,
      attributes: attributes,
      attributesEx: attributesEx,
      attributesExB: attributesExB,
      attributesExC: attributesExC,
      attributesExD: attributesExD,
      attributesExE: attributesExE,
      attributesExF: attributesExF,
      attributesExG: attributesExG,
      procTypeMasks: procTypeMasks,
      implicitTargets: implicitTargets,
      schoolMasks: schoolMasks,
    };
  },
  computed: {
    ...mapState("spell", ["spell"]),
    credential() {
      return {
        ID: this.$route.params.id,
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
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateSpell({
          credential: this.credential,
          spell: this.spell,
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
  components: {
    FlagEditor,
    ItemTemplateSelector,
    SpellDurationSelector,
  },
};
</script>
