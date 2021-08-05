<template>
  <el-form :model="spell" label-position="right" label-width="120px">
    <el-card
      :body-style="{ padding: '22px 20px 0 20px' }"
      style="margin-top: 16px"
    >
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
            <el-input-number
              v-model="spell.Name_Lang_Mask"
              controls-position="right"
              placeholder="Name_Lang_Mask"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="子名称掩码">
            <el-input-number
              v-model="spell.NameSubtext_Lang_Mask"
              controls-position="right"
              placeholder="NameSubtext_Lang_Mask"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="描述掩码">
            <el-input-number
              v-model="spell.Description_Lang_Mask"
              controls-position="right"
              placeholder="Description_Lang_Mask"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="Buff描述掩码">
            <el-input-number
              v-model="spell.AuraDescription_Lang_Mask"
              controls-position="right"
              placeholder="AuraDescription_Lang_Mask"
            ></el-input-number>
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
          <el-form-item label="类型">
            <spell-category-selector
              v-model="spell.Category"
              placeholder="Category"
            ></spell-category-selector>
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
          <el-form-item label="防护类型">
            <el-select
              v-model="spell.DefenseType"
              filterable
              placeholder="DefenseType"
            >
              <el-option
                v-for="(defenseType, index) in defenseTypes"
                :key="`defenseType-${index}`"
                :label="defenseType"
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="控制类型">
            <el-select
              v-model="spell.Mechanic"
              filterable
              placeholder="Mechanic"
            >
              <el-option label="无" :value="0"></el-option>
              <el-option
                v-for="mechanic in spellMechanics"
                :key="`mechanic-${mechanic.ID}`"
                :label="mechanic.StateName_Lang_zhCN"
                :value="mechanic.ID"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="驱散类型">
            <el-select
              v-model="spell.DispelType"
              filterable
              placeholder="DispelType"
            >
              <el-option
                v-for="(dispelType, index) in dispelTypes"
                :key="`dispelType-${index}`"
                :label="dispelType"
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="阻止类型">
            <el-select
              v-model="spell.PreventionType"
              filterable
              placeholder="PreventionType"
            >
              <el-option
                v-for="(preventionType, index) in preventionTypes"
                :key="`preventionType-${index}`"
                :label="preventionType"
                :value="index"
              ></el-option>
            </el-select>
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
          <el-form-item label="施法时间">
            <spell-cast-time-selector
              v-model="spell.CastingTimeIndex"
              placeholder="CastingTimeIndex"
            ></spell-cast-time-selector>
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
            <spell-range-selector
              v-model="spell.RangeIndex"
              placeholder="RangeIndex"
            ></spell-range-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="描述变量">
            <spell-description-variable-selector
              v-model="spell.SpellDescriptionVariableID"
              placeholder="SpellDescriptionVariableID"
            ></spell-description-variable-selector>
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
            <el-input v-model="spell.Targets" placeholder="Targets"></el-input>
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
            <el-input v-model="spell.Speed" placeholder="Speed"></el-input>
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
    <el-card
      :body-style="{ padding: '22px 20px 0 20px' }"
      style="margin-top: 16px"
    >
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
    <el-card
      :body-style="{ padding: '22px 20px 0 20px' }"
      style="margin-top: 16px"
    >
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
      </el-row>
      <el-row :gutter="16">
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
          <el-form-item label="额外属性">
            <flag-editor
              v-model="spell.AttributesEx"
              title="额外属性编辑器"
              :flags="attributesEx"
              placeholder="AttributesEx"
            ></flag-editor>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="额外属性">
            <flag-editor
              v-model="spell.AttributesExB"
              title="额外属性编辑器"
              :flags="attributesExB"
              placeholder="AttributesExB"
            ></flag-editor>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="额外属性">
            <flag-editor
              v-model="spell.AttributesExC"
              title="额外属性编辑器"
              :flags="attributesExC"
              placeholder="AttributesExC"
            ></flag-editor>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="额外属性">
            <flag-editor
              v-model="spell.AttributesExD"
              title="额外属性编辑器"
              :flags="attributesExD"
              placeholder="AttributesExD"
            ></flag-editor>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="额外属性">
            <flag-editor
              v-model="spell.AttributesExE"
              title="额外属性编辑器"
              :flags="attributesExE"
              placeholder="AttributesExE"
            ></flag-editor>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="额外属性">
            <flag-editor
              v-model="spell.AttributesExF"
              title="额外属性编辑器"
              :flags="attributesExF"
              placeholder="AttributesExF"
            ></flag-editor>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="额外属性">
            <flag-editor
              v-model="spell.AttributesExG"
              title="额外属性编辑器"
              :flags="attributesExG"
              placeholder="AttributesExG"
            ></flag-editor>
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
    <el-card
      :body-style="{ padding: '22px 20px 0 20px' }"
      style="margin-top: 16px"
    >
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
    <el-card
      :body-style="{ padding: '22px 20px 0 20px' }"
      style="margin-top: 16px"
    >
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
            <el-input-number
              v-model="spell.EffectAuraPeriod_1"
              controls-position="right"
              placeholder="EffectAuraPeriod_1"
            ></el-input-number>
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
            <el-input-number
              v-model="spell.EffectMultipleValue_1"
              controls-position="right"
              placeholder="EffectMultipleValue_1"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="奖励乘数">
            <el-input-number
              v-model="spell.EffectBonusMultiplier_1"
              controls-position="right"
              placeholder="EffectBonusMultiplier_1"
            ></el-input-number>
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
            <spell-selector
              v-model="spell.EffectTriggerSpell_1"
              placeholder="EffectTriggerSpell_1"
            ></spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="每级连击点">
            <el-input-number
              v-model="spell.EffectPointsPerCombo_1"
              controls-position="right"
              placeholder="EffectPointsPerCombo_1"
            ></el-input-number>
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
    <el-card
      :body-style="{ padding: '22px 20px 0 20px' }"
      style="margin-top: 16px"
    >
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
            <el-input-number
              v-model="spell.EffectAuraPeriod_2"
              controls-position="right"
              placeholder="EffectAuraPeriod_2"
            ></el-input-number>
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
            <el-input-number
              v-model="spell.EffectMultipleValue_2"
              controls-position="right"
              placeholder="EffectMultipleValue_2"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="奖励系数">
            <el-input-number
              v-model="spell.EffectBonusMultiplier_2"
              controls-position="right"
              placeholder="EffectBonusMultiplier_2"
            ></el-input-number>
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
            <spell-selector
              v-model="spell.EffectTriggerSpell_2"
              placeholder="EffectTriggerSpell_2"
            ></spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="每级连击点">
            <el-input-number
              v-model="spell.EffectPointsPerCombo_2"
              controls-position="right"
              placeholder="EffectPointsPerCombo_2"
            ></el-input-number>
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
    <el-card
      :body-style="{ padding: '22px 20px 0 20px' }"
      style="margin-top: 16px"
    >
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
            <el-input-number
              v-model="spell.EffectAuraPeriod_3"
              controls-position="right"
              placeholder="EffectAuraPeriod_3"
            ></el-input-number>
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
            <el-input-number
              v-model="spell.EffectMultipleValue_3"
              controls-position="right"
              placeholder="EffectMultipleValue_3"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="奖励乘数">
            <el-input-number
              v-model="spell.EffectBonusMultiplier_3"
              controls-position="right"
              placeholder="EffectBonusMultiplier_3"
            ></el-input-number>
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
            <spell-selector
              v-model="spell.EffectTriggerSpell_3"
              placeholder="EffectTriggerSpell_3"
            ></spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="每级连击点">
            <el-input-number
              v-model="spell.EffectPointsPerCombo_3"
              controls-position="right"
              placeholder="EffectPointsPerCombo_3"
            ></el-input-number>
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
    <el-card
      :body-style="{ padding: '22px 20px 0 20px' }"
      style="margin-top: 16px"
    >
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="图腾">
            <el-input v-model="spell.Totem_1" placeholder="Totem_1"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="图腾">
            <el-input v-model="spell.Totem_2" placeholder="Totem_2"></el-input>
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
    <el-card
      :body-style="{ padding: '22px 20px 0 20px' }"
      style="margin-top: 16px"
    >
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="施法材料">
            <item-template-selector
              v-model="spell.Reagent_1"
              placeholder="Reagent_1"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              v-model="spell.ReagentCount_1"
              controls-position="right"
              placeholder="ReagentCount_1"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="施法材料">
            <item-template-selector
              v-model="spell.Reagent_2"
              placeholder="Reagent_2"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              v-model="spell.ReagentCount_2"
              controls-position="right"
              placeholder="ReagentCount_2"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="施法材料">
            <item-template-selector
              v-model="spell.Reagent_3"
              placeholder="Reagent_3"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              v-model="spell.ReagentCount_3"
              controls-position="right"
              placeholder="ReagentCount_3"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="施法材料">
            <item-template-selector
              v-model="spell.Reagent_4"
              placeholder="Reagent_4"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              v-model="spell.ReagentCount_4"
              controls-position="right"
              placeholder="ReagentCount_4"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="施法材料">
            <item-template-selector
              v-model="spell.Reagent_5"
              placeholder="Reagent_5"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              v-model="spell.ReagentCount_5"
              controls-position="right"
              placeholder="ReagentCount_5"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="施法材料">
            <item-template-selector
              v-model="spell.Reagent_6"
              placeholder="Reagent_6"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              v-model="spell.ReagentCount_6"
              controls-position="right"
              placeholder="ReagentCount_6"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="施法材料">
            <item-template-selector
              v-model="spell.Reagent_7"
              placeholder="Reagent_7"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              v-model="spell.ReagentCount_7"
              controls-position="right"
              placeholder="ReagentCount_7"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="施法材料">
            <item-template-selector
              v-model="spell.Reagent_8"
              placeholder="Reagent_8"
            ></item-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="数量">
            <el-input-number
              v-model="spell.ReagentCount_8"
              controls-position="right"
              placeholder="ReagentCount_8"
            ></el-input-number>
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
          <el-form-item label="图标">
            <spell-icon-selector
              v-model="spell.SpellIconID"
              placeholder="SpellIconID"
            ></spell-icon-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="激活图标">
            <spell-icon-selector
              v-model="spell.ActiveIconID"
              placeholder="ActiveIconID"
            ></spell-icon-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="视觉效果">
            <el-input-number
              v-model="spell.SpellVisualID_1"
              controls-position="right"
              placeholder="SpellVisualID_1"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="视觉效果">
            <el-input-number
              v-model="spell.SpellVisualID_2"
              controls-position="right"
              placeholder="SpellVisualID_2"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card
      :body-style="{ padding: '22px 20px 0 20px' }"
      style="margin: 16px 0 80px 0"
    >
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
            <el-input v-model="spell.Unk_13" placeholder="Unk_13"></el-input>
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
            <el-input v-model="spell.Unk_15" placeholder="Unk_15"></el-input>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card class="footer">
      <el-button type="primary" :loading="loading" @click="store">
        保存
      </el-button>
      <el-button @click="cancel">返回</el-button>
    </el-card>
  </el-form>
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
  defenseTypes,
  dispelTypes,
  preventionTypes,
} from "@/locales/spell";

import { mapState, mapActions } from "vuex";
import FlagEditor from "@/components/FlagEditor";
import ItemTemplateSelector from "@/components/ItemTemplateSelector.vue";
import SpellDurationSelector from "@/components/SpellDurationSelector.vue";
import SpellCastTimeSelector from "@/components/SpellCastTimeSelector.vue";
import SpellCategorySelector from "@/components/SpellCategorySelector";
import SpellDescriptionVariableSelector from "@/components/SpellDescriptionVariableSelector";
import SpellIconSelector from "@/components/SpellIconSelector.vue";
import SpellRangeSelector from "@/components/SpellRangeSelector.vue";
import SpellSelector from "../../../components/SpellSelector.vue";

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
      defenseTypes: defenseTypes,
      dispelTypes: dispelTypes,
      preventionTypes: preventionTypes,
    };
  },
  computed: {
    ...mapState("spell", ["spell"]),
    ...mapState("initiator", ["spellMechanics"]),
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
    SpellCastTimeSelector,
    SpellCategorySelector,
    SpellDescriptionVariableSelector,
    SpellIconSelector,
    SpellRangeSelector,
    SpellSelector,
  },
};
</script>
