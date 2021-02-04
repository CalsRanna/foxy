<template>
  <el-form :model="creatureTemplate" label-position="right" label-width="120px">
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="ID">
            <el-input-number
              v-model="creatureTemplate.entry"
              controls-position="right"
              placeholder="entry"
              :disabled="initing"
              v-loading="initing"
              element-loading-spinner="el-icon-loading"
              element-loading-background="rgba(255, 255, 255, 0.5)"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="姓名">
            <creature-template-localizer
              v-model="creatureTemplate.name"
              placeholder="name"
            ></creature-template-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="称号">
            <creature-template-localizer
              v-model="creatureTemplate.subname"
              placeholder="subname"
            ></creature-template-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="鼠标形状">
            <el-input
              v-model="creatureTemplate.IconName"
              placeholder="IconName"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="最小等级">
            <el-input-number
              v-model="creatureTemplate.minlevel"
              :min="1"
              controls-position="right"
              placeholder="minlevel"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="最大等级">
            <el-input-number
              v-model="creatureTemplate.maxlevel"
              :min="1"
              controls-position="right"
              placeholder="maxlevel"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="属性扩展"
              :tooltip="expTooltip"
              slot="label"
            ></hint-label>
            <el-select v-model="creatureTemplate.exp" placeholder="exp">
              <el-option
                v-for="(exp, index) in exps"
                :key="`exp-${index}`"
                :label="exp"
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="势力">
            <!-- <el-input
              v-model="creatureTemplate.faction"
              placeholder="faction"
            ></el-input> -->
            <faction-template-selector
              v-model="creatureTemplate.faction"
              placeholder="faction"
            ></faction-template-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="职业"
              :tooltip="unitClassTooltip"
              slot="label"
            ></hint-label>
            <el-select
              v-model="creatureTemplate.unit_class"
              placeholder="unit_class"
            >
              <el-option
                v-for="(unitClass, index) in unitClasses"
                :key="`unit-class-${index}`"
                :label="unitClass"
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="排行"
              :tooltip="rankTooltip"
              slot="label"
            ></hint-label>
            <el-select v-model="creatureTemplate.rank" placeholder="rank">
              <el-option
                v-for="index in [0, 1, 4, 2, 3]"
                :key="`rank-${index}`"
                :label="ranks[index]"
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="族群">
            <el-select
              v-model="creatureTemplate.family"
              filterable
              placeholder="family"
            >
              <el-option
                v-for="(family, index) in families"
                :key="`family-${index}`"
                :label="family"
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="类型">
            <el-select
              v-model="creatureTemplate.type"
              filterable
              placeholder="type"
            >
              <el-option
                v-for="(type, index) in types"
                :key="`type-${index}`"
                :label="type"
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="NPC标识"
              :tooltip="npcFlagTooltip"
              slot="label"
            ></hint-label>
            <flag-editor
              title="Npc标识编辑器"
              v-model="creatureTemplate.npcflag"
              :flags="npcFlags"
              placeholder="npcflag"
            ></flag-editor>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="类型标识"
              :tooltip="typeFlagsTooltip"
              slot="label"
            ></hint-label>
            <flag-editor
              title="类型标识编辑器"
              v-model="creatureTemplate.type_flags"
              :flags="typeFlags"
              placeholder="type_flags"
            ></flag-editor>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="单位标识"
              :tooltip="unitFlagsTooltip"
              slot="label"
            ></hint-label>
            <flag-editor
              title="单位标识编辑器"
              v-model="creatureTemplate.unit_flags"
              :flags="unitFlags"
              placeholder="unit_flags"
            ></flag-editor>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="单位标识"
              :tooltip="unitFlags2Tooltip"
              slot="label"
            ></hint-label>
            <flag-editor
              title="单位标识2编辑器"
              v-model="creatureTemplate.unit_flags2"
              :flags="unitFlags2"
              placeholder="unit_flags2"
            ></flag-editor>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="动态标识"
              :tooltip="dynamicFlagsTooltip"
              slot="label"
            ></hint-label>
            <flag-editor
              title="动态标识编辑器"
              v-model="creatureTemplate.dynamicflags"
              :flags="dynamicFlags"
              placeholder="dynamicflags"
            ></flag-editor>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="额外标识"
              :tooltip="flagsExtraTooltip"
              slot="label"
            ></hint-label>
            <flag-editor
              title="额外标识编辑器"
              v-model="creatureTemplate.flags_extra"
              :flags="flagsExtra"
              placeholder="flags_extra"
            ></flag-editor>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="种族领袖">
            <el-switch
              v-model="creatureTemplate.RacialLeader"
              :active-value="1"
              :inactive-value="0"
            ></el-switch>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="回复生命">
            <el-switch
              v-model="creatureTemplate.RegenHealth"
              :active-value="1"
              :inactive-value="0"
            ></el-switch>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="免疫技能"
              :tooltip="mechanicImmuneMasksTooltip"
              slot="label"
            ></hint-label>
            <flag-editor
              title="免疫技能编辑器"
              v-model="creatureTemplate.mechanic_immune_mask"
              :flags="mechanicImmuneMasks"
              placeholder="mechanic_immune_mask"
            ></flag-editor>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="宠物技能">
            <el-input
              v-model="creatureTemplate.PetSpellDataId"
              placeholder="PetSpellDataId"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="载具编号"
              :tooltip="vehicleIdTooltip"
              slot="label"
            ></hint-label>
            <el-input
              v-model="creatureTemplate.VehicleId"
              placeholder="VehicleId"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="对话菜单">
            <gossip-menu-selector
              v-model="creatureTemplate.gossip_menu_id"
              placeholder="npcflag"
            ></gossip-menu-selector>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="模型1">
            <el-input
              v-model="creatureTemplate.modelid1"
              placeholder="modelid1"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="模型2">
            <el-input
              v-model="creatureTemplate.modelid2"
              placeholder="modelid2"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="模型3">
            <el-input
              v-model="creatureTemplate.modelid3"
              placeholder="modelid3"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="模型4">
            <el-input
              v-model="creatureTemplate.modelid4"
              placeholder="modelid4"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="伤害类型">
            <el-select
              v-model="creatureTemplate.dmgschool"
              placeholder="dmgschool"
            >
              <el-option
                v-for="dmgSchool in dmgSchools"
                :key="`dmgschool-${dmgSchool.value}`"
                :label="dmgSchool.label"
                :value="dmgSchool.value"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="最小近战伤害">
            <el-input-number
              v-model="creatureTemplate.mindmg"
              :min="0"
              controls-position="right"
              placeholder="mindmg"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="最大近战伤害">
            <el-input-number
              v-model="creatureTemplate.maxdmg"
              :min="0"
              controls-position="right"
              placeholder="maxdmg"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="近战攻击强度">
            <el-input-number
              v-model="creatureTemplate.attackpower"
              :min="0"
              controls-position="right"
              placeholder="attackpower"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="近战攻击间隔">
            <el-input-number
              v-model="creatureTemplate.BaseAttackTime"
              :min="0"
              controls-position="right"
              placeholder="BaseAttackTime"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="最小远程伤害">
            <el-input-number
              v-model="creatureTemplate.minrangedmg"
              :min="0"
              controls-position="right"
              placeholder="minrangedmg"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="最大远程伤害">
            <el-input-number
              v-model="creatureTemplate.maxrangedmg"
              :min="0"
              controls-position="right"
              placeholder="maxrangedmg"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="远程攻击强度">
            <el-input-number
              v-model="creatureTemplate.rangedattackpower"
              :min="0"
              controls-position="right"
              placeholder="rangedattackpower"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="远程攻击间隔">
            <el-input-number
              v-model="creatureTemplate.RangeAttackTime"
              :min="0"
              controls-position="right"
              placeholder="RangeAttackTime"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="伤害系数">
            <el-input-number
              v-model="creatureTemplate.DamageModifier"
              :min="0"
              controls-position="right"
              placeholder="DamageModifier"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="护甲系数">
            <el-input-number
              v-model="creatureTemplate.ArmorModifier"
              :min="0"
              controls-position="right"
              placeholder="ArmorModifier"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="生命值系数">
            <el-input-number
              v-model="creatureTemplate.HealthModifier"
              :min="0"
              controls-position="right"
              placeholder="HealthModifier"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="法力值系数">
            <el-input-number
              v-model="creatureTemplate.ManaModifier"
              :min="0"
              controls-position="right"
              placeholder="ManaModifier"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="缩放系数">
            <el-input-number
              v-model="creatureTemplate.scale"
              :min="0"
              controls-position="right"
              placeholder="scale"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="行走速度">
            <el-input-number
              v-model="creatureTemplate.speed_walk"
              :min="0"
              controls-position="right"
              placeholder="speed_walk"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="奔跑速度">
            <el-input-number
              v-model="creatureTemplate.speed_run"
              :min="0"
              controls-position="right"
              placeholder="speed_run"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="神圣抗性">
            <el-input-number
              v-model="creatureTemplate.resistance1"
              :min="0"
              controls-position="right"
              placeholder="resistance1"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="火焰抗性">
            <el-input-number
              v-model="creatureTemplate.resistance2"
              :min="0"
              controls-position="right"
              placeholder="resistance2"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="自然抗性">
            <el-input-number
              v-model="creatureTemplate.resistance3"
              :min="0"
              controls-position="right"
              placeholder="resistance3"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="暗影抗性">
            <el-input-number
              v-model="creatureTemplate.resistance5"
              :min="0"
              controls-position="right"
              placeholder="resistance5"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="冰霜抗性">
            <el-input-number
              v-model="creatureTemplate.resistance4"
              :min="0"
              controls-position="right"
              placeholder="resistance4"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="奥术抗性">
            <el-input-number
              v-model="creatureTemplate.resistance6"
              :min="0"
              controls-position="right"
              placeholder="resistance6"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="技能1">
            <spell-selector
              v-model="creatureTemplate.spell1"
              placeholder="spell1"
            ></spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能2">
            <spell-selector
              v-model="creatureTemplate.spell2"
              placeholder="spell2"
            ></spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能3">
            <spell-selector
              v-model="creatureTemplate.spell3"
              placeholder="spell3"
            ></spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能4">
            <spell-selector
              v-model="creatureTemplate.spell4"
              placeholder="spell4"
            ></spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能5">
            <spell-selector
              v-model="creatureTemplate.spell5"
              placeholder="spell5"
            ></spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能6">
            <spell-selector
              v-model="creatureTemplate.spell6"
              placeholder="spell6"
            ></spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能7">
            <spell-selector
              v-model="creatureTemplate.spell7"
              placeholder="spell7"
            ></spell-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="技能8">
            <spell-selector
              v-model="creatureTemplate.spell8"
              placeholder="spell8"
            ></spell-selector>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="训练师类型"
              :tooltip="trainerTypeTooltip"
              slot="label"
            ></hint-label>
            <el-select
              v-model="creatureTemplate.trainer_type"
              placeholder="trainer_type"
              :disabled="(creatureTemplate.npcflag & 4194416) == 0"
            >
              <el-option
                v-for="(trainerType, index) in trainerTypes"
                :key="`trainer-type-${index}`"
                :label="
                  (creatureTemplate.npcflag & 4194416) == 0 ? 0 : trainerType
                "
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="训练师法术"
              :tooltip="trainerSpellTooltip"
              slot="label"
            ></hint-label>
            <el-input
              v-model="creatureTemplate.trainer_spell"
              placeholder="trainer_spell"
              :disabled="(creatureTemplate.npcflag & 4194416) == 0"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="训练师职业"
              :tooltip="trainerClassTooltip"
              slot="label"
            ></hint-label>
            <el-select
              v-model="creatureTemplate.trainer_class"
              placeholder="trainer_class"
              :disabled="(creatureTemplate.npcflag & 4194416) == 0"
            >
              <el-option
                v-for="index in [1, 2, 3, 4, 5, 6, 7, 8, 9, 11]"
                :key="`trainer-class-${index}`"
                :label="trainerClasses[index]"
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="训练师种族"
              :tooltip="trainerRaceTooltip"
              slot="label"
            ></hint-label>
            <el-select
              v-model="creatureTemplate.trainer_race"
              placeholder="trainer_race"
              :disabled="(creatureTemplate.npcflag & 4194416) == 0"
            >
              <el-option
                v-for="(trainerRace, index) in trainerRaces"
                :key="`trainer-race-${index}`"
                :label="trainerRace"
                :value="index + 1"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="最小金钱掉落">
            <el-input-number
              v-model="creatureTemplate.mingold"
              :min="0"
              controls-position="right"
              placeholder="mingold"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="最大金钱掉落">
            <el-input-number
              v-model="creatureTemplate.maxgold"
              :min="0"
              controls-position="right"
              placeholder="maxgold"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="击杀关联1"
              :tooltip="killCredit1Tooltip"
              slot="label"
            ></hint-label>
            <el-input
              v-model="creatureTemplate.KillCredit1"
              placeholder="KillCredit1"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="击杀关联2"
              :tooltip="killCredit2Tooltip"
              slot="label"
            ></hint-label>
            <el-input
              v-model="creatureTemplate.KillCredit2"
              placeholder="KillCredit2"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="击杀掉落ID">
            <el-input
              v-model="creatureTemplate.lootid"
              placeholder="lootid"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="偷窃掉落ID">
            <el-input
              v-model="creatureTemplate.pickpocketloot"
              placeholder="pickpocketloot"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="剥皮掉落ID">
            <el-input
              v-model="creatureTemplate.skinloot"
              placeholder="skinloot"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="难度1"
              :tooltip="difficultyEntry1Tooltip"
              slot="label"
            ></hint-label>
            <el-input
              v-model="creatureTemplate.difficulty_entry_1"
              placeholder="difficulty_entry_1"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="难度2">
            <el-input
              v-model="creatureTemplate.difficulty_entry_2"
              placeholder="difficulty_entry_2"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="难度3">
            <el-input
              v-model="creatureTemplate.difficulty_entry_3"
              placeholder="difficulty_entry_3"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="AI名称">
            <el-input
              v-model="creatureTemplate.AIName"
              placeholder="AIName"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="脚本名称">
            <el-input
              v-model="creatureTemplate.ScriptName"
              placeholder="ScriptName"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="移动类型">
            <el-select
              v-model="creatureTemplate.MovementType"
              placeholder="MovementType"
            >
              <el-option
                v-for="(movementType, index) in movementTypes"
                :key="`movement-type-${index}`"
                :label="movementType"
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="移动ID"
              :tooltip="movementIdTooltip"
              slot="label"
            ></hint-label>
            <el-input
              v-model="creatureTemplate.movementId"
              placeholder="movementId"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="栖息类型"
              :tooltip="inhabitTypeTooltip"
              slot="label"
            ></hint-label>
            <flag-editor
              title="栖息类型编辑器"
              v-model="creatureTemplate.InhabitType"
              :flags="inhabitTypes"
              placeholder="InhabitType"
            ></flag-editor>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="盘旋高度"
              :tooltip="hoverHeightTooltip"
              slot="label"
            ></hint-label>
            <el-input
              v-model="creatureTemplate.HoverHeight"
              placeholder="HoverHeight"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="VerifiedBuild">
            <el-input
              v-model="creatureTemplate.VerifiedBuild"
              placeholder="VerifiedBuild"
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
</template>

<script>
import {
  rankTooltip,
  ranks,
  expTooltip,
  exps,
  unitClassTooltip,
  unitClasses,
  families,
  types,
  npcFlagTooltip,
  npcFlags,
  typeFlagsTooltip,
  typeFlags,
  unitFlagsTooltip,
  unitFlags,
  unitFlags2Tooltip,
  unitFlags2,
  dynamicFlagsTooltip,
  dynamicFlags,
  flagsExtraTooltip,
  flagsExtra,
  mechanicImmuneMasksTooltip,
  mechanicImmuneMasks,
  vehicleIdTooltip,
  dmgSchools,
  trainerTypeTooltip,
  trainerTypes,
  trainerSpellTooltip,
  trainerClassTooltip,
  trainerClasses,
  trainerRaceTooltip,
  trainerRaces,
  killCredit1Tooltip,
  killCredit2Tooltip,
  difficultyEntry1Tooltip,
  movementTypes,
  movementIdTooltip,
  inhabitTypeTooltip,
  inhabitTypes,
  hoverHeightTooltip,
} from "@/locales/creature";

import CreatureTemplateLocalizer from "@/views/Creature/components/CreatureTemplateLocalizer";
import FactionTemplateSelector from "@/components/FactionTemplateSelector";
import FlagEditor from "@/components/FlagEditor";
import GossipMenuSelector from "@/components/GossipMenuSelector";
import HintLabel from "@/components/HintLabel";
import SpellSelector from "@/components/SpellSelector";

import { mapState, mapActions } from "vuex";

export default {
  data() {
    return {
      rankTooltip: rankTooltip,
      ranks: ranks,
      expTooltip: expTooltip,
      exps: exps,
      unitClassTooltip: unitClassTooltip,
      unitClasses: unitClasses,
      families: families,
      types: types,
      npcFlagTooltip: npcFlagTooltip,
      npcFlags: npcFlags,
      typeFlagsTooltip: typeFlagsTooltip,
      typeFlags: typeFlags,
      unitFlagsTooltip: unitFlagsTooltip,
      unitFlags: unitFlags,
      unitFlags2Tooltip: unitFlags2Tooltip,
      unitFlags2: unitFlags2,
      dynamicFlagsTooltip: dynamicFlagsTooltip,
      dynamicFlags: dynamicFlags,
      flagsExtraTooltip: flagsExtraTooltip,
      flagsExtra: flagsExtra,
      mechanicImmuneMasksTooltip: mechanicImmuneMasksTooltip,
      mechanicImmuneMasks: mechanicImmuneMasks,
      vehicleIdTooltip: vehicleIdTooltip,
      dmgSchools: dmgSchools,
      trainerTypeTooltip: trainerTypeTooltip,
      trainerTypes: trainerTypes,
      trainerSpellTooltip: trainerSpellTooltip,
      trainerClassTooltip: trainerClassTooltip,
      trainerClasses: trainerClasses,
      trainerRaceTooltip: trainerRaceTooltip,
      trainerRaces: trainerRaces,
      killCredit1Tooltip: killCredit1Tooltip,
      killCredit2Tooltip: killCredit2Tooltip,
      difficultyEntry1Tooltip: difficultyEntry1Tooltip,
      movementTypes: movementTypes,
      movementIdTooltip: movementIdTooltip,
      inhabitTypeTooltip: inhabitTypeTooltip,
      inhabitTypes: inhabitTypes,
      hoverHeightTooltip: hoverHeightTooltip,
      initing: false,
      loading: false,
      creating: false,
    };
  },
  computed: {
    ...mapState("creatureTemplate", ["creatureTemplate"]),
    ...mapState("creatureTemplateLocale", ["creatureTemplateLocales"]),
    credential() {
      return {
        entry: this.$route.params.id,
      };
    },
  },
  methods: {
    ...mapActions("creatureTemplate", [
      "storeCreatureTemplate",
      "findCreatureTemplate",
      "updateCreatureTemplate",
      "createCreatureTemplate",
    ]),
    ...mapActions("creatureTemplateLocale", ["searchCreatureTemplateLocales"]),
    async store() {
      this.loading = true;
      if (this.creating) {
        await this.storeCreatureTemplate(this.creatureTemplate);
        this.creating = false;
      } else {
        await this.updateCreatureTemplate({
          credential: this.credential,
          creatureTemplate: this.creatureTemplate,
        });
      }
      this.loading = false;
    },
    cancel() {
      this.$router.go(-1);
    },
    async init() {
      this.initing = true;
      if (this.$route.path == "/creature/create") {
        this.creating = true;
        await Promise.all([
          this.createCreatureTemplate(),
          this.searchCreatureTemplateLocales({ entry: 0 }),
        ]);
      } else {
        await Promise.all([
          this.findCreatureTemplate(this.credential),
          this.searchCreatureTemplateLocales(this.credential),
        ]);
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: {
    FactionTemplateSelector,
    FlagEditor,
    GossipMenuSelector,
    HintLabel,
    SpellSelector,
    CreatureTemplateLocalizer,
  },
};
</script>
