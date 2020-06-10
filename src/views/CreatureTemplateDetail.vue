<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/creature' }"
          >生物管理</el-breadcrumb-item
        >
        <el-breadcrumb-item>生物详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{
          creatureTemplate.CreatureTemplateLocales.length > 0
            ? creatureTemplate.CreatureTemplateLocales[0].Name
            : creatureTemplate.name
        }}
        <small>
          {{
            creatureTemplate.CreatureTemplateLocales.length > 0
              ? creatureTemplate.CreatureTemplateLocales[0].Title
              : creatureTemplate.subname
          }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="creature_template" style="margin-top: 16px">
      <el-tab-pane
        label="生物模版"
        name="creature_template"
        v-loading="loading"
      >
        <el-form
          :model="creatureTemplate"
          label-position="right"
          label-width="120px"
        >
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="ID">
                  <el-input
                    v-model="creatureTemplate.entry"
                    placeholder="entry"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="姓名">
                  <el-input
                    v-model="creatureTemplate.name"
                    placeholder="name"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="称号">
                  <el-input
                    v-model="creatureTemplate.subname"
                    placeholder="subname"
                  ></el-input>
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
                    style="width: 100%"
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
                    style="width: 100%"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item>
                  <template slot="label">
                    <el-tooltip>
                      <div slot="content" style="max-width: 400px">
                        exp，可选值为0-2，详见 creature_classlevelstats.
                      </div>
                      <i class="el-icon-info"></i>
                    </el-tooltip>
                    生命值扩展
                  </template>
                  <el-select v-model="creatureTemplate.exp" placeholder="exp">
                    <el-option label="经典旧世" :value="0"></el-option>
                    <el-option label="燃烧的远征" :value="1"></el-option>
                    <el-option label="巫妖王之怒" :value="2"></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="势力">
                  <el-input
                    v-model="creatureTemplate.faction"
                    placeholder="faction"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="标识">
                  <el-input
                    v-model="creatureTemplate.npcflag"
                    placeholder="npcflag"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item>
                  <template slot="label">
                    <el-tooltip>
                      <div slot="content" style="max-width: 400px">
                        The rank of the creature:
                        <br />
                        Note 1: An NPC's rank is mostly visual (which also
                        requires your Cache to be cleared to see changes).
                        Changing this value will not change its health, damage,
                        or loot. However, it will change the respawn time of the
                        creature.
                        <br />
                        Note 2: Respawn times can be modified in two other
                        places: Creature.spawntimesecs (only for that single
                        GUID of the creature) and in the worldserver.conf file
                        under the "Corpse.Decay" settings (for ALL creatures of
                        the same rank). The default `spawntimesecs` for all
                        spawned creatures is 300 seconds (5 minutes). For
                        example, using the ".npc add" command to spawn a
                        "Normal" NPC will give it a default respawn time of 6
                        minutes (spawntimesecs + Corpse.Decay time). Also, the
                        creature must decay first before it can respawn. For
                        this reason, the Corpse Decay Time of the creature is
                        also it's minimum respawn time, since setting the
                        creature's Creature.spawntimesecs = 0 will remove the
                        Default Respawn Time. In the example above, setting our
                        Normal NPC's spawntimesecs = 0 will mean the creature's
                        respawn time decreases from 6 minutes to 60 seconds.
                        <br />
                        Note 3: If you want the creature to show a skull or "??"
                        in the portrait (often with Bosses), set the type_flags
                        to 4.
                      </div>
                      <i class="el-icon-info"></i>
                    </el-tooltip>
                    Rank
                  </template>
                  <el-select v-model="creatureTemplate.rank" placeholder="rank">
                    <el-option label="普通" :value="0"></el-option>
                    <el-option label="精英" :value="1"></el-option>
                    <el-option label="稀有精英" :value="2"></el-option>
                    <el-option label="BOSS" :value="3"></el-option>
                    <el-option label="稀有" :value="4"></el-option>
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
                    <el-option label="无" :value="0"></el-option>
                    <el-option label="狼" :value="1"></el-option>
                    <el-option label="豹" :value="2"></el-option>
                    <el-option label="蜘蛛" :value="3"></el-option>
                    <el-option label="熊" :value="4"></el-option>
                    <el-option label="野猪" :value="5"></el-option>
                    <el-option label="鳄鱼" :value="6"></el-option>
                    <el-option label="食腐鸟" :value="7"></el-option>
                    <el-option label="螃蟹" :value="8"></el-option>
                    <el-option label="猩猩" :value="9"></el-option>
                    <el-option label="迅猛龙" :value="11"></el-option>
                    <el-option label="陆行鸟" :value="12"></el-option>
                    <el-option label="地狱犬" :value="15"></el-option>
                    <el-option label="虚空行者" :value="16"></el-option>
                    <el-option label="魅魔" :value="17"></el-option>
                    <el-option label="末日守卫" :value="19"></el-option>
                    <el-option label="蝎子" :value="20"></el-option>
                    <el-option label="海龟" :value="21"></el-option>
                    <el-option label="小鬼" :value="23"></el-option>
                    <el-option label="蝙蝠" :value="24"></el-option>
                    <el-option label="鬣狗" :value="25"></el-option>
                    <el-option label="枭兽" :value="26"></el-option>
                    <el-option label="风蛇" :value="27"></el-option>
                    <el-option label="遥控装置" :value="28"></el-option>
                    <el-option label="恶魔卫士" :value="29"></el-option>
                    <el-option label="龙鹰" :value="30"></el-option>
                    <el-option label="劫掠者" :value="31"></el-option>
                    <el-option label="Warp Stalker" :value="32"></el-option>
                    <el-option label="孢子蝠" :value="33"></el-option>
                    <el-option label="虚空鳐" :value="34"></el-option>
                    <el-option label="毒蛇" :value="35"></el-option>
                    <el-option label="飞蛾" :value="37"></el-option>
                    <el-option label="奇美拉" :value="38"></el-option>
                    <el-option label="魔暴龙" :value="39"></el-option>
                    <el-option label="食尸鬼" :value="40"></el-option>
                    <el-option label="异种蝎" :value="41"></el-option>
                    <el-option label="蠕虫" :value="42"></el-option>
                    <el-option label="犀牛" :value="43"></el-option>
                    <el-option label="黄蜂" :value="44"></el-option>
                    <el-option label="熔岩犬" :value="45"></el-option>
                    <el-option label="灵魂兽" :value="46"></el-option>
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
                    <el-option label="无" :value="0"></el-option>
                    <el-option label="野兽" :value="1"></el-option>
                    <el-option label="龙人" :value="2"></el-option>
                    <el-option label="恶魔" :value="3"></el-option>
                    <el-option label="元素生物" :value="4"></el-option>
                    <el-option label="巨人" :value="5"></el-option>
                    <el-option label="亡灵" :value="6"></el-option>
                    <el-option label="人形生物" :value="7"></el-option>
                    <el-option label="生物" :value="8"></el-option>
                    <el-option label="机械" :value="9"></el-option>
                    <el-option label="Not specified" :value="10"></el-option>
                    <el-option label="图腾" :value="11"></el-option>
                    <el-option label="小宠物" :value="12"></el-option>
                    <el-option label="Gas Cloud" :value="13"></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="类型标识">
                  <el-input
                    v-model="creatureTemplate.type_flags"
                    placeholder="type_flags"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item>
                  <template slot="label">
                    <el-tooltip>
                      <div slot="content" style="max-width: 400px">
                        This is the creature's class, and it dictates levels of
                        health and mana. Also note that health and mana will
                        change according to exp, HealthModifier, and
                        ManaModifier. Not setting this value will report a minor
                        warning in the "DB_Errors.log".
                      </div>
                      <i class="el-icon-info"></i>
                    </el-tooltip>
                    职业
                  </template>
                  <el-select
                    v-model="creatureTemplate.unit_class"
                    placeholder="unit_class"
                  >
                    <el-option label="战士" :value="1"></el-option>
                    <el-option label="圣骑士" :value="2"></el-option>
                    <el-option label="盗贼" :value="4"></el-option>
                    <el-option label="法师" :value="8"></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="unit_flags">
                  <el-input
                    v-model="creatureTemplate.unit_flags"
                    placeholder="unit_flags"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="unit_flags2">
                  <el-input
                    v-model="creatureTemplate.unit_flags2"
                    placeholder="unit_flags2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="dynamicflags">
                  <el-input
                    v-model="creatureTemplate.dynamicflags"
                    placeholder="dynamicflags"
                  ></el-input>
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
                <el-form-item label="mechanic_immune_mask">
                  <el-input
                    v-model="creatureTemplate.mechanic_immune_mask"
                    placeholder="mechanic_immune_mask"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="flags_extra">
                  <el-input
                    v-model="creatureTemplate.flags_extra"
                    placeholder="flags_extra"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="VehicleId">
                  <el-input
                    v-model="creatureTemplate.VehicleId"
                    placeholder="VehicleId"
                  ></el-input>
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
                <el-form-item label="PetSpellDataId">
                  <el-input
                    v-model="creatureTemplate.PetSpellDataId"
                    placeholder="PetSpellDataId"
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
            <el-row :gutter="16">
              <el-col :span="6">
                <h1>Model</h1>
              </el-col>
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
                <el-form-item label="训练师类型">
                  <el-input
                    v-model="creatureTemplate.trainer_type"
                    placeholder="trainer_type"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="trainer_spell">
                  <el-input
                    v-model="creatureTemplate.trainer_spell"
                    placeholder="trainer_spell"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="训练师职业">
                  <el-input
                    v-model="creatureTemplate.trainer_class"
                    placeholder="trainer_class"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="训练师种族">
                  <el-input
                    v-model="creatureTemplate.trainer_race"
                    placeholder="trainer_race"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="KillCredit1">
                  <el-input
                    v-model="creatureTemplate.KillCredit1"
                    placeholder="KillCredit1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="KillCredit2">
                  <el-input
                    v-model="creatureTemplate.KillCredit2"
                    placeholder="KillCredit2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="最小金钱掉落">
                  <el-input
                    v-model="creatureTemplate.mingold"
                    placeholder="mingold"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="最大金钱掉落">
                  <el-input
                    v-model="creatureTemplate.maxgold"
                    placeholder="maxgold"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="lootid">
                  <el-input
                    v-model="creatureTemplate.lootid"
                    placeholder="lootid"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="pickpocketloot">
                  <el-input
                    v-model="creatureTemplate.pickpocketloot"
                    placeholder="pickpocketloot"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="skinloot">
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
                <el-form-item label="difficulty_entry_1">
                  <el-input
                    v-model="creatureTemplate.difficulty_entry_1"
                    placeholder="difficulty_entry_1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="difficulty_entry_2">
                  <el-input
                    v-model="creatureTemplate.difficulty_entry_2"
                    placeholder="difficulty_entry_2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="difficulty_entry_3">
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
                <el-form-item label="最小近战伤害">
                  <el-input
                    v-model="creatureTemplate.mindmg"
                    placeholder="mindmg"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="最大近战伤害">
                  <el-input
                    v-model="creatureTemplate.maxdmg"
                    placeholder="maxdmg"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="伤害类型">
                  <el-input
                    v-model="creatureTemplate.dmgschool"
                    placeholder="dmgschool"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="近战攻击强度">
                  <el-input
                    v-model="creatureTemplate.attackpower"
                    placeholder="attackpower"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="近战攻击间隔">
                  <el-input
                    v-model="creatureTemplate.BaseAttackTime"
                    placeholder="BaseAttackTime"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="远程攻击间隔">
                  <el-input
                    v-model="creatureTemplate.RangeAttackTime"
                    placeholder="RangeAttackTime"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="最小远程伤害">
                  <el-input
                    v-model="creatureTemplate.minrangedmg"
                    placeholder="minrangedmg"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="最大远程伤害">
                  <el-input
                    v-model="creatureTemplate.maxrangedmg"
                    placeholder="maxrangedmg"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="远程攻击强度">
                  <el-input
                    v-model="creatureTemplate.rangedattackpower"
                    placeholder="rangedattackpower"
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
                <el-form-item label="Script名称">
                  <el-input
                    v-model="creatureTemplate.ScriptName"
                    placeholder="ScriptName"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="对话菜单">
                  <el-input
                    v-model="creatureTemplate.gossip_menu_id"
                    placeholder="gossip_menu_id"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="MovementType">
                  <el-input
                    v-model="creatureTemplate.MovementType"
                    placeholder="MovementType"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="movementId">
                  <el-input
                    v-model="creatureTemplate.movementId"
                    placeholder="movementId"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="InhabitType">
                  <el-input
                    v-model="creatureTemplate.InhabitType"
                    placeholder="InhabitType"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="HoverHeight">
                  <el-input
                    v-model="creatureTemplate.HoverHeight"
                    placeholder="HoverHeight"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="缩放系数">
                  <el-input
                    v-model="creatureTemplate.scale"
                    placeholder="scale"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="伤害系数">
                  <el-input
                    v-model="creatureTemplate.DamageModifier"
                    placeholder="DamageModifier"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="生命值系数">
                  <el-input
                    v-model="creatureTemplate.HealthModifier"
                    placeholder="HealthModifier"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="法力值系数">
                  <el-input
                    v-model="creatureTemplate.ManaModifier"
                    placeholder="ManaModifier"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="护甲系数">
                  <el-input
                    v-model="creatureTemplate.ArmorModifier"
                    placeholder="ArmorModifier"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="行走速度">
                  <el-input
                    v-model="creatureTemplate.speed_walk"
                    placeholder="speed_walk"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="奔跑速度">
                  <el-input
                    v-model="creatureTemplate.speed_run"
                    placeholder="speed_run"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="神圣抗性">
                  <el-input
                    v-model="creatureTemplate.resistance1"
                    placeholder="resistance1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="火焰抗性">
                  <el-input
                    v-model="creatureTemplate.resistance2"
                    placeholder="resistance2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="自然抗性">
                  <el-input
                    v-model="creatureTemplate.resistance3"
                    placeholder="resistance3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="冰霜抗性">
                  <el-input
                    v-model="creatureTemplate.resistance4"
                    placeholder="resistance4"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="暗影抗性">
                  <el-input
                    v-model="creatureTemplate.resistance5"
                    placeholder="resistance5"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="奥术抗性">
                  <el-input
                    v-model="creatureTemplate.resistance6"
                    placeholder="resistance6"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="技能1">
                  <el-input
                    v-model="creatureTemplate.spell1"
                    placeholder="spell1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="技能2">
                  <el-input
                    v-model="creatureTemplate.spell2"
                    placeholder="spell2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="技能3">
                  <el-input
                    v-model="creatureTemplate.spell3"
                    placeholder="spell3"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="技能4">
                  <el-input
                    v-model="creatureTemplate.spell4"
                    placeholder="spell4"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="技能5">
                  <el-input
                    v-model="creatureTemplate.spell5"
                    placeholder="spell5"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="技能6">
                  <el-input
                    v-model="creatureTemplate.spell6"
                    placeholder="spell6"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="技能7">
                  <el-input
                    v-model="creatureTemplate.spell7"
                    placeholder="spell7"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="技能8">
                  <el-input
                    v-model="creatureTemplate.spell8"
                    placeholder="spell8"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
        </el-form>
      </el-tab-pane>
      <el-tab-pane label="模版补充" name="creature_template_addon">
        <el-form label-position="right" label-width="120px">
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="ID">
                  <el-input placeholder="entry"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="path_id">
                  <el-input placeholder="path_id"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="mount">
                  <el-input placeholder="mount"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="bytes1">
                  <el-input placeholder="bytes1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="bytes2">
                  <el-input placeholder="bytes2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="表情">
                  <el-input placeholder="emote"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="isLarge">
                  <el-input placeholder="isLarge"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="光环列表">
                  <el-input placeholder="auras"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
        </el-form>
      </el-tab-pane>
      <el-tab-pane label="击杀荣誉" name="creature_onkill_reputation"
        >击杀荣誉</el-tab-pane
      >
      <el-tab-pane label="装备模板" name="creature_equip_template"
        >装备模板</el-tab-pane
      >
      <el-tab-pane label="商人" name="npc_vendor">商人</el-tab-pane>
      <el-tab-pane label="训练师" name="npc_trainer">训练师</el-tab-pane>
      <el-tab-pane label="任务物品" name="creature_questitem"
        >任务物品</el-tab-pane
      >
      <el-tab-pane label="掉落模板" name="creature_loot_template"
        >掉落模板</el-tab-pane
      >
      <el-tab-pane label="pickpocketloot" name="pickpocketloot"
        >pickpocketloot</el-tab-pane
      >
      <el-tab-pane label="skinloot" name="skinloot">skinloot</el-tab-pane>
    </el-tabs>
  </div>
</template>

<script>
import axios from "axios";
export default {
  data() {
    return {
      loading: false,
      creatureTemplate: {
        CreatureTemplateLocales: [],
      },
    };
  },
  created() {
    this.loading = true;
    let id = this.$route.params.id;
    axios.get(`/creature-template/${id}`).then((response) => {
      this.creatureTemplate = response.data;
      this.loading = false;
      console.log(this.creatureTemplate.CreatureTemplateLocales[0].Name);
    });
  },
};
</script>
