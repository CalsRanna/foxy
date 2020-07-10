<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }"
          >首页</el-breadcrumb-item
        >
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
    <el-tabs
      value="creature_template"
      @tab-click="switchover"
      style="margin-top: 16px"
    >
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
                  <el-input-number
                    v-model="creatureTemplate.entry"
                    :min="0"
                    controls-position="right"
                    placeholder="entry"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="姓名">
                  <el-input v-model="creatureTemplate.name" placeholder="name">
                    <i
                      class="el-icon-s-operation clickable-icon"
                      slot="suffix"
                      style="margin-right: 8px"
                      @click="showDialog"
                    ></i>
                  </el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="称号">
                  <el-input
                    v-model="creatureTemplate.subname"
                    placeholder="subname"
                  >
                    <i
                      class="el-icon-s-operation clickable-icon"
                      slot="suffix"
                      style="margin-right: 8px"
                      @click="showDialog"
                    ></i>
                  </el-input>
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
                  <template slot="label">
                    <el-tooltip>
                      <div slot="content" style="max-width: 400px">
                        exp，可选值为0-2，详见 creature_classlevelstats.
                      </div>
                      <i class="el-icon-info"></i>
                    </el-tooltip>
                    属性扩展
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
                <el-form-item label="Npc标识">
                  <template slot="label">
                    <el-tooltip>
                      <div slot="content" style="max-width: 400px">
                        A bitmask that represents what NPC flags the creature
                        has. Each bit controls a different flag and to combine
                        flags, you can add each flag that you want, in effect
                        activating the respective bits.
                      </div>
                      <i class="el-icon-info"></i>
                    </el-tooltip>
                    Npc标识
                  </template>
                  <flag-editor
                    v-model="creatureTemplate.npcflag"
                    :flags="npcFlags"
                    title="Npc标识编辑器"
                    placeholder="npcflag"
                  ></flag-editor>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="类型标识">
                  <template slot="label">
                    <el-tooltip>
                      <div slot="content" style="max-width: 400px">
                        This field can control whether a mob is minable or
                        herbable or lootable by engineer. If it is either of
                        those three, then the loot given when it is
                        skinned/mined will be stored in the
                        skinning_loot_template table. It also controls, whether
                        this mob can be tamed by a hunter. Other fields have no
                        special meaning on the serverside. The entire field will
                        be send to the client in SMSG_CREATURE_QUERY_RESPONSE
                      </div>
                      <i class="el-icon-info"></i>
                    </el-tooltip>
                    类型标识
                  </template>
                  <flag-editor
                    v-model="creatureTemplate.type_flags"
                    :flags="typeFlags"
                    title="类型标识编辑器"
                    placeholder="type_flags"
                  ></flag-editor>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="单位标识">
                  <template slot="label">
                    <el-tooltip>
                      <div slot="content" style="max-width: 400px">
                        Allows the manual application of unit flags to
                        creatures. Again this is a bitmask field and to apply
                        more than one flag, just add the different numbers. Some
                        possible flags are:
                      </div>
                      <i class="el-icon-info"></i>
                    </el-tooltip>
                    单位标识
                  </template>
                  <flag-editor
                    v-model="creatureTemplate.unit_flags"
                    :flags="unitFlags"
                    title="单位标识编辑器"
                    placeholder="unit_flags"
                  ></flag-editor>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="单位标识2">
                  <template slot="label">
                    <el-tooltip>
                      <div slot="content" style="max-width: 400px">
                        Allows additional application of unit flags to
                        creatures. Again, this is a bitmask field and to apply
                        more than one flag, just add the different numbers. Some
                        possible flags are:
                      </div>
                      <i class="el-icon-info"></i>
                    </el-tooltip>
                    单位标识2
                  </template>
                  <flag-editor
                    v-model="creatureTemplate.unit_flags2"
                    :flags="unitFlags2"
                    title="单位标识编辑器"
                    placeholder="unit_flags2"
                  ></flag-editor>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="动态标识">
                  <template slot="label">
                    <el-tooltip>
                      <div slot="content" style="max-width: 400px">
                        Flags that control visual appearance of the creature. A
                        few known flags and their use are:
                      </div>
                      <i class="el-icon-info"></i>
                    </el-tooltip>
                    动态标识
                  </template>
                  <flag-editor
                    v-model="creatureTemplate.dynamicflags"
                    :flags="dynamicFlags"
                    title="动态标识编辑器"
                    placeholder="dynamicflags"
                  ></flag-editor>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="额外标识">
                  <template slot="label">
                    <el-tooltip>
                      <div slot="content" style="max-width: 400px">
                        These flags control certain creature specific
                        attributes. Flags can be added together to apply more
                        than one.
                      </div>
                      <i class="el-icon-info"></i>
                    </el-tooltip>
                    额外标识
                  </template>
                  <flag-editor
                    v-model="creatureTemplate.flags_extra"
                    :flags="flagsExtra"
                    title="额外标识编辑器"
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
                <el-form-item label="免疫技能">
                  <template slot="label">
                    <el-tooltip>
                      <div slot="content" style="max-width: 400px">
                        This makes the creature immune to specific spell
                        natures. See Spell.dbc at row effect_X_mechanic_id. Uses
                        references from SpellMechanic.dbc. To combine immunities
                        just add values. Immune to everything corresponds to the
                        value 2147483647 (0x3FFF FFFF).
                      </div>
                      <i class="el-icon-info"></i>
                    </el-tooltip>
                    免疫技能
                  </template>
                  <flag-editor
                    v-model="creatureTemplate.mechanic_immune_mask"
                    :flags="mechanicImmuneMasks"
                    title="免疫技能编辑器"
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
                <el-form-item label="坐骑编号">
                  <template slot="label">
                    <el-tooltip>
                      <div slot="content" style="max-width: 400px">
                        Entry of vehicle if creature is/has a vehicle entry.
                        This field determines how the player appears on the
                        vehicle, how the vehicle moves, and whether or not the
                        vehicle action bar is shown. For example, a vehicleID of
                        292 will make the player invisible, prevent the vehicle
                        from strafing left/right (but will allow
                        forwards/backwards), and will show the vehicle action
                        bar spells (which are defined in spell1-8). An
                        npc_spellclick_spells entry must be made for this
                        creature entry in order for this to work.
                      </div>
                      <i class="el-icon-info"></i>
                    </el-tooltip>
                    坐骑编号
                  </template>
                  <el-input
                    v-model="creatureTemplate.VehicleId"
                    placeholder="VehicleId"
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
                <el-form-item label="伤害类型">
                  <el-input
                    v-model="creatureTemplate.dmgschool"
                    placeholder="dmgschool"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
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
              <el-col :span="6">
                <el-form-item label="远程攻击间隔">
                  <el-input
                    v-model="creatureTemplate.RangeAttackTime"
                    placeholder="RangeAttackTime"
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
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="训练师类型">
                  <template slot="label">
                    <el-tooltip>
                      <div slot="content" style="max-width: 400px">
                        If the NPC is a trainer (has the trainer flag), then
                        this field controls what kind of trainer it is. Both
                        this field and the related field must be filled in for a
                        trainer to work correctly.
                      </div>
                      <i class="el-icon-info"></i>
                    </el-tooltip>
                    训练师类型
                  </template>
                  <el-select
                    v-model="creatureTemplate.trainer_type"
                    placeholder="trainer_type"
                  >
                    <el-option label="职业训练师" :value="0"></el-option>
                    <el-option label="骑术训练师" :value="1"></el-option>
                    <el-option label="专业训练师" :value="2"></el-option>
                    <el-option label="宠物训练师" :value="3"></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="训练师法术">
                  <template slot="label">
                    <el-tooltip>
                      <div slot="content" style="max-width: 400px">
                        If the NPC is a trainer that teaches professions
                        (trainer_type = 2), then the player must already know
                        the spell ID specified here to be able to talk to this
                        NPC.
                      </div>
                      <i class="el-icon-info"></i>
                    </el-tooltip>
                    训练师法术
                  </template>
                  <el-input
                    v-model="creatureTemplate.trainer_spell"
                    placeholder="trainer_spell"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="训练师职业">
                  <template slot="label">
                    <el-tooltip>
                      <div slot="content" style="max-width: 400px">
                        If the NPC is a class trainer or a pet trainer
                        (trainer_type = 0 or 3), then the player's class must be
                        the same as the value specified here to talk to this
                        trainer. For pet trainers, this value must be 3
                        (hunter). See characters.class
                      </div>
                      <i class="el-icon-info"></i>
                    </el-tooltip>
                    训练师职业
                  </template>
                  <el-select
                    v-model="creatureTemplate.trainer_class"
                    placeholder="trainer_class"
                  >
                    <el-option label="战士" :value="1"></el-option>
                    <el-option label="圣骑士" :value="2"></el-option>
                    <el-option label="猎人" :value="3"></el-option>
                    <el-option label="潜行者" :value="4"></el-option>
                    <el-option label="牧师" :value="5"></el-option>
                    <el-option label="死亡骑士" :value="6"></el-option>
                    <el-option label="萨满祭司" :value="7"></el-option>
                    <el-option label="法师" :value="8"></el-option>
                    <el-option label="术士" :value="9"></el-option>
                    <el-option label="德鲁伊" :value="11"></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="训练师种族">
                  <template slot="label">
                    <el-tooltip>
                      <div slot="content" style="max-width:400px">
                        If the NPC is a mount trainer (trainer_type = 1), then
                        the player's race must be the same as the value
                        specified here to talk to this trainer. See
                        characters.race
                      </div>
                      <i class="el-icon-info"></i>
                    </el-tooltip>
                    训练师种族
                  </template>
                  <el-select
                    v-model="creatureTemplate.trainer_race"
                    placeholder="trainer_race"
                  >
                  
                    <el-option label="人类" :value="1"></el-option>
                    <el-option label="兽人" :value="2"></el-option>
                    <el-option label="矮人" :value="3"></el-option>
                    <el-option label="暗夜精灵" :value="4"></el-option>
                    <el-option label="亡灵" :value="5"></el-option>
                    <el-option label="牛头人" :value="6"></el-option>
                    <el-option label="侏儒" :value="7"></el-option>
                    <el-option label="巨魔" :value="8"></el-option>
                    <el-option label="地精" :value="9"></el-option>
                    <el-option label="血精灵" :value="10"></el-option>
                    <el-option label="德莱尼" :value="11"></el-option>
                    <el-option label="邪兽人" :value="12"></el-option>
                    <el-option label="娜迦" :value="13"></el-option>
                    <el-option label="破碎者" :value="14"></el-option>
                    <el-option label="骷髅" :value="15"></el-option>
                    <el-option label="维库人" :value="16"></el-option>
                    <el-option label="海象人" :value="17"></el-option>
                    <el-option label="森林巨魔" :value="18"></el-option>
                    <el-option label="牦牛人" :value="19"></el-option>
                    <el-option label="诺森德骷髅" :value="20"></el-option>
                    <el-option label="冰巨魔" :value="21"></el-option>
                  </el-select>
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
          <el-card v-loading="loading" style="margin-top: 16px">
            <el-button type="primary">保存</el-button>
            <el-button>返回</el-button>
          </el-card>
        </el-form>
      </el-tab-pane>
      <el-tab-pane
        label="模版补充"
        name="creature_template_addon"
        lazy
        v-loading="loading"
      >
        <el-form
          :model="creatureTemplateAddon"
          label-position="right"
          label-width="120px"
        >
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="ID">
                  <el-input
                    v-model="creatureTemplateAddon.entry"
                    placeholder="entry"
                    disabled
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="path_id">
                  <el-input
                    v-model="creatureTemplateAddon.path_id"
                    placeholder="path_id"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="mount">
                  <el-input
                    v-model="creatureTemplateAddon.mount"
                    placeholder="mount"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="bytes1">
                  <el-input
                    v-model="creatureTemplateAddon.bytes1"
                    placeholder="bytes1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="bytes2">
                  <el-input
                    v-model="creatureTemplateAddon.bytes2"
                    placeholder="bytes2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="表情">
                  <el-input
                    v-model="creatureTemplateAddon.emote"
                    placeholder="emote"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="isLarge">
                  <el-input
                    v-model="creatureTemplateAddon.isLarge"
                    placeholder="isLarge"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="光环列表">
                  <el-input
                    v-model="creatureTemplateAddon.auras"
                    placeholder="auras"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
        </el-form>
      </el-tab-pane>
      <el-tab-pane
        label="击杀声望"
        name="creature_onkill_reputation"
        lazy
        v-loading="loading"
      >
        <el-card style="margin-top: 16px">
          <el-form
            :model="creatureOnKillReputation"
            label-position="right"
            label-width="120px"
          >
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="生物ID">
                  <el-input
                    v-model="creatureOnKillReputation.creature_id"
                    placeholder="creature_id"
                    disabled
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="势力1">
                  <el-input
                    v-model="creatureOnKillReputation.RewOnKillRepFaction1"
                    placeholder="RewOnKillRepFaction1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="势力2">
                  <el-input
                    v-model="creatureOnKillReputation.RewOnKillRepFaction2"
                    placeholder="RewOnKillRepFaction2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="TeamDependent">
                  <el-input
                    v-model="creatureOnKillReputation.TeamDependent"
                    placeholder="TeamDependent"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6" :offset="6">
                <el-form-item label="声望值1">
                  <el-input
                    v-model="creatureOnKillReputation.RewOnKillRepValue1"
                    placeholder="RewOnKillRepValue1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="声望值2">
                  <el-input
                    v-model="creatureOnKillReputation.RewOnKillRepValue2"
                    placeholder="RewOnKillRepValue2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6" :offset="6">
                <el-form-item label="最大声望1">
                  <el-input
                    v-model="creatureOnKillReputation.MaxStanding1"
                    placeholder="MaxStanding1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="最大声望2">
                  <el-input
                    v-model="creatureOnKillReputation.MaxStanding2"
                    placeholder="MaxStanding2"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6" :offset="6">
                <el-form-item label="IsTeamAward1">
                  <el-input
                    v-model="creatureOnKillReputation.IsTeamAward1"
                    placeholder="IsTeamAward1"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="IsTeamAward2">
                  <el-input
                    v-model="creatureOnKillReputation.IsTeamAward2"
                    placeholder="IsTeamAward2"
                  ></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-form>
        </el-card>
      </el-tab-pane>
      <el-tab-pane
        label="装备模板"
        name="creature_equip_template"
        lazy
        v-loading="loading"
      >
        <el-card style="margin-top: 16px">
          <el-table :data="creatureEquipTemplates">
            <el-table-column prop="ID" label="ID"></el-table-column>
            <el-table-column label="物品1">
              <template slot-scope="scope">
                {{ scope.row.displayid1 }}
                <template v-if="scope.row.Name1">{{
                  scope.row.Name1
                }}</template>
                <template v-else>{{ scope.row.name1 }}</template>
              </template>
            </el-table-column>
            <el-table-column label="物品2">
              <template slot-scope="scope">
                {{ scope.row.displayid2 }}
                <template v-if="scope.row.Name2">{{
                  scope.row.Name2
                }}</template>
                <template v-else>{{ scope.row.name2 }}</template>
              </template>
            </el-table-column>
            <el-table-column label="物品3">
              <template slot-scope="scope">
                {{ scope.row.displayid3 }}
                <template v-if="scope.row.Name3">{{
                  scope.row.Name3
                }}</template>
                <template v-else>{{ scope.row.name3 }}</template>
              </template>
            </el-table-column>
            <el-table-column
              prop="VerifiedBuild"
              label="VerifiedBuild"
            ></el-table-column>
          </el-table>
        </el-card>
      </el-tab-pane>
      <el-tab-pane label="商人" name="npc_vendor" lazy v-loading="loading">
        <el-card style="margin-top: 16px">
          <el-table :data="npcVendors">
            <el-table-column prop="displayid"></el-table-column>
            <el-table-column
              prop="slot"
              label="插槽"
              sortable
            ></el-table-column>
            <el-table-column prop="item" label="ID" sortable></el-table-column>
            <el-table-column prop="name" label="名称" sortable>
              <span slot-scope="scope">
                <template v-if="scope.row.Name !== null">
                  {{ scope.row.Name }}
                </template>
                <template v-else>{{ scope.row.name }}</template>
              </span>
            </el-table-column>
            <el-table-column
              prop="maxcount"
              label="最大数量"
              sortable
            ></el-table-column>
            <el-table-column
              prop="incrtime"
              label="补货时间"
              sortable
            ></el-table-column>
            <el-table-column sortable>
              <span slot="header">
                <el-tooltip>
                  <div slot="content" style="max-width: 400px">
                    The value here corresponds to the ID in ItemExtendedCost.dbc
                    and that ID controls the item's non monetary price, be it
                    honor points, arena points, different types of badges or any
                    combination of the above.
                  </div>
                  <i class="el-icon-info"></i>
                </el-tooltip>
                扩展价格
              </span>
              <span slot-scope="scope">{{ scope.row.ExtendedCost }}</span>
            </el-table-column>
          </el-table>
        </el-card>
      </el-tab-pane>
      <el-tab-pane label="训练师" name="npc_trainer" lazy v-loading="loading">
        <el-card style="margin-top: 16px">
          <el-table :data="npcTrainers">
            <el-table-column prop="SpellID" label="技能ID" sortable>
              <span slot="header">
                <el-tooltip>
                  <i class="el-icon-info"></i>
                  <div slot="content" style="max-width: 400px">
                    The spell ID from Spell.dbc. If the ID is negative, it's
                    pointing to a reference template.
                  </div>
                </el-tooltip>
                技能ID
              </span>
            </el-table-column>
            <el-table-column
              prop="MoneyCost"
              label="价格"
              sortable
            ></el-table-column>
            <el-table-column
              prop="ReqSkillLine"
              label="需要技能"
              sortable
            ></el-table-column>
            <el-table-column
              prop="ReqSkillRank"
              label="需要熟练度"
              sortable
            ></el-table-column>
            <el-table-column
              prop="ReqLevel"
              label="需要等级"
              sortable
            ></el-table-column>
          </el-table>
        </el-card>
      </el-tab-pane>
      <el-tab-pane
        label="任务物品"
        name="creature_questitem"
        lazy
        v-loading="loading"
      >
        <el-card style="margin-top: 16px">
          <el-table :data="creatureQuestItems">
            <el-table-column prop="displayid"></el-table-column>
            <el-table-column
              prop="Idx"
              label="Index"
              sortable
            ></el-table-column>
            <el-table-column label="名称">
              <span slot-scope="scope">
                <template v-if="scope.row.Name">{{ scope.row.Name }}</template>
                <template v-else>{{ scope.row.name }}</template>
              </span>
            </el-table-column>
            <el-table-column
              prop="VerifiedBuild"
              label="VerifiedBuild"
              sortable
            ></el-table-column>
          </el-table>
        </el-card>
      </el-tab-pane>
      <el-tab-pane
        label="生物掉落"
        name="creature_loot_template"
        lazy
        v-loading="loading"
      >
        <el-card style="margin-top: 16px">
          <el-table :data="creatureLootTemplates">
            <el-table-column prop="displayid"></el-table-column>
            <el-table-column prop="Item" label="物品" sortable>
              <span slot-scope="scope">
                <template v-if="scope.row.Name !== null">
                  {{ scope.row.Name }}
                </template>
                <template v-else>{{ scope.row.name }}</template>
              </span>
            </el-table-column>
            <el-table-column prop="Chance" label="几率" sortable>
              <span slot-scope="scope">
                {{ `${scope.row.Chance}%` }}
              </span>
            </el-table-column>
            <el-table-column prop="QuestRequired" label="需要任务" sortable>
              <span slot-scope="scope">
                <template v-if="scope.row.Title !== null">
                  {{ scope.row.Title }}
                </template>
                <template v-else>{{ scope.row.LogTitle }}</template>
              </span>
            </el-table-column>
            <el-table-column
              prop="MinCount"
              label="最小数量"
              sortable
            ></el-table-column>
            <el-table-column
              prop="MaxCount"
              label="最大数量"
              sortable
            ></el-table-column>
          </el-table>
        </el-card>
      </el-tab-pane>
      <el-tab-pane
        label="偷窃掉落"
        name="pickpocketing_loot_template"
        lazy
        v-loading="loading"
      >
        <el-card style="margin-top: 16px">
          <el-table :data="pickpocketingLootTemplates">
            <el-table-column prop="displayid"></el-table-column>
            <el-table-column prop="Item" label="ID" sortable></el-table-column>
            <el-table-column prop="Name" label="名称" sortable>
              <template slot-scope="scope">
                <template v-if="scope.row.Name !== null">{{
                  scope.row.Name
                }}</template>
                <template v-else>{{ scope.row.name }}</template>
              </template>
            </el-table-column>
            <el-table-column
              prop="Reference"
              label="关联"
              sortable
            ></el-table-column>
            <el-table-column prop="Chance" label="几率" sortable>
              <template slot-scope="scope">
                {{ `${scope.row.Chance}%` }}
              </template>
            </el-table-column>
            <el-table-column prop="QuestRequired" label="需要任务" sortable>
              <template slot-scope="scope">
                <template v-if="scope.row.Title !== null">{{
                  scope.row.Title
                }}</template>
                <template v-else>{{ scope.row.LogTitle }}</template>
              </template>
            </el-table-column>
            <el-table-column
              prop="LootMode"
              label="掉落模式"
              sortable
            ></el-table-column>
            <el-table-column
              prop="GroupId"
              label="组ID"
              sortable
            ></el-table-column>
            <el-table-column
              prop="MinCount"
              label="最小数量"
              sortable
            ></el-table-column>
            <el-table-column
              prop="MaxCount"
              label="最大数量"
              sortable
            ></el-table-column>
          </el-table>
        </el-card>
      </el-tab-pane>
      <el-tab-pane label="剥皮掉落" name="skinning_loot_template">
        <el-card style="margin-top: 16px">
          <el-table :data="skinningLootTemplates">
            <el-table-column prop="displayid"></el-table-column>
            <el-table-column prop="Item" label="ID" sortable></el-table-column>
            <el-table-column prop="Name" label="名称" sortable>
              <template slot-scope="scope">
                <template v-if="scope.row.Name !== null">{{
                  scope.row.Name
                }}</template>
                <template v-else>{{ scope.row.name }}</template>
              </template>
            </el-table-column>
            <el-table-column
              prop="Reference"
              label="关联"
              sortable
            ></el-table-column>
            <el-table-column prop="Chance" label="几率" sortable>
              <template slot-scope="scope">
                {{ `${scope.row.Chance}%` }}
              </template>
            </el-table-column>
            <el-table-column prop="QuestRequired" label="需要任务" sortable>
              <template slot-scope="scope">
                <template v-if="scope.row.Title !== null">{{
                  scope.row.Title
                }}</template>
                <template v-else>{{ scope.row.LogTitle }}</template>
              </template>
            </el-table-column>
            <el-table-column
              prop="LootMode"
              label="掉落模式"
              sortable
            ></el-table-column>
            <el-table-column
              prop="GroupId"
              label="组ID"
              sortable
            ></el-table-column>
            <el-table-column
              prop="MinCount"
              label="最小数量"
              sortable
            ></el-table-column>
            <el-table-column
              prop="MaxCount"
              label="最大数量"
              sortable
            ></el-table-column>
          </el-table>
        </el-card>
      </el-tab-pane>
    </el-tabs>
    <el-dialog
      :visible.sync="localeDialogVisible"
      :show-close="false"
      :close-on-click-modal="false"
    >
      <div slot="title">
        <span style="font-size: 18px;color: #303133;margin-right:16px"
          >名称/称号本地化</span
        >
        <el-button size="mini" @click="addCreatureTemplateLocale"
          >新增</el-button
        >
      </div>
      <el-table :data="creatureTemplate.CreatureTemplateLocales">
        <el-table-column width="48">
          <el-button
            type="danger"
            size="mini"
            icon="el-icon-delete"
            circle=""
            slot-scope="scope"
            @click="() => deleteCreatureTemplateLocale(scope.$index)"
          ></el-button>
        </el-table-column>
        <el-table-column prop="entry" label="编号">
          <template slot-scope="scope">
            <el-input-number
              v-model="scope.row.entry"
              controls-position="right"
              disabled
            ></el-input-number>
          </template>
        </el-table-column>
        <el-table-column prop="locale" label="语言">
          <template slot-scope="scope">
            <el-input
              v-model="scope.row.locale"
              placeholder="locale"
            ></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Name" label="名称">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Name" placeholder="Name"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Title" label="称号">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Title" placeholder="Title"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="VerifiedBuild" label="VerifiedBuild">
          <template slot-scope="scope">
            <el-input-number
              v-model="scope.row.VerifiedBuild"
              :min="0"
              controls-position="right"
              placeholder="VerifiedBuild"
            ></el-input-number>
          </template>
        </el-table-column>
      </el-table>
      <div slot="footer">
        <el-button @click="closeDialog">取消</el-button>
        <el-button type="primary" @click="storeCreatureTemplateLocales"
          >保存</el-button
        >
      </div>
    </el-dialog>
  </div>
</template>

<script>
import axios from "axios";
import { Notification } from "element-ui";
import FlagEditor from "@/components/FlagEditor";
import {
  npcFlags,
  typeFlags,
  unitFlags,
  unitFlags2,
  dynamicFlags,
  flagsExtra,
  mechanicImmuneMasks,
} from "@/locales/creature";

export default {
  data() {
    return {
      loading: false,
      creatureTemplate: {
        entry: 0,
        difficulty_entry_1: 0,
        difficulty_entry_2: 0,
        difficulty_entry_3: 0,
        KillCredit1: 0,
        KillCredit2: 0,
        modelid1: 0,
        modelid2: 0,
        modelid3: 0,
        modelid4: 0,
        name: "",
        subname: "",
        IconName: "",
        gossip_menu_id: 0,
        minlevel: 1,
        maxlevel: 1,
        exp: 0,
        faction: 0,
        npcflag: 0,
        speed_walk: 0,
        speed_run: 1.14286,
        scale: 1,
        rank: 0,
        mindmg: 0,
        maxdmg: 0,
        dmgschool: 0,
        attackpower: 0,
        DamageModifier: 1,
        BaseAttackTime: 0,
        RangeAttackTime: 0,
        unit_class: 0,
        unit_flags: 0,
        unit_flags2: 0,
        dynamicflags: 0,
        family: 0,
        trainer_type: 0,
        trainer_spell: 0,
        trainer_class: 0,
        trainer_race: 0,
        minrangedmg: 0,
        maxrangedmg: 0,
        rangedattackpower: 0,
        type: 0,
        type_flags: 0,
        lootid: 0,
        pickpocketloot: 0,
        skinloot: 0,
        resistance1: 0,
        resistance2: 0,
        resistance3: 0,
        resistance4: 0,
        resistance5: 0,
        resistance6: 0,
        spell1: 0,
        spell2: 0,
        spell3: 0,
        spell4: 0,
        spell5: 0,
        spell6: 0,
        spell7: 0,
        spell8: 0,
        PetSpellDataId: 0,
        VehicleId: 0,
        mingold: 0,
        maxgold: 0,
        AIName: "",
        MovementType: 0,
        InhabitType: 3,
        HoverHeight: 1,
        HealthModifier: 1,
        ManaModifier: 1,
        ArmorModifier: 1,
        RacialLeader: 0,
        movementId: 0,
        RegenHealth: 1,
        mechanic_immune_mask: 0,
        flags_extra: 0,
        ScriptName: "",
        VerifiedBuild: 0,
        CreatureTemplateLocales: [],
      },
      creatureTemplateAddon: {},
      creatureEquipTemplates: [],
      creatureOnKillReputation: {},
      creatureLootTemplates: [],
      creatureQuestItems: [],
      npcVendors: [],
      npcTrainers: [],
      pickpocketingLootTemplates: [],
      skinningLootTemplates: [],
      localeDialogVisible: false,
      npcFlags: npcFlags,
      typeFlags: typeFlags,
      unitFlags: unitFlags,
      unitFlags2: unitFlags2,
      dynamicFlags: dynamicFlags,
      flagsExtra: flagsExtra,
      mechanicImmuneMasks: mechanicImmuneMasks,
    };
  },
  methods: {
    switchover(tab) {
      if (
        tab.name === "creature_template_addon" &&
        JSON.stringify(this.creatureTemplateAddon) === "{}"
      ) {
        this.loading = true;
        axios
          .get(`/creature-template-addon/${this.creatureTemplate.entry}`)
          .then((response) => {
            if (response.data !== null) {
              this.creatureTemplateAddon = response.data;
            } else {
              Notification.warning({
                title: "提示",
                message: "该生物模板没有设置模板补充。",
                type: "warning",
              });
            }
            this.loading = false;
          })
          .catch(() => {
            this.loading = false;
          });
      }
      if (
        tab.name === "creature_onkill_reputation" &&
        JSON.stringify(this.creatureOnKillReputation) === "{}"
      ) {
        this.loading = true;
        axios
          .get(
            `/creature-template/${this.creatureTemplate.entry}/creature-onkill-reputation`
          )
          .then((response) => {
            if (response.data !== null) {
              this.creatureOnKillReputation = response.data;
            } else {
              Notification.warning({
                title: "提示",
                message: "该生物模板没有设置击杀声望。",
                type: "warning",
              });
            }
            this.loading = false;
          })
          .catch(() => {
            this.loading = false;
          });
      }
      if (
        tab.name === "creature_equip_template" &&
        this.creatureEquipTemplates.length === 0
      ) {
        this.loading = true;
        axios
          .get(
            `/creature-template/${this.creatureTemplate.entry}/creature-equip-template`
          )
          .then((response) => {
            this.creatureEquipTemplates = response.data;
            this.loading = false;
          })
          .catch(() => {
            this.loading = false;
          });
      }
      if (
        tab.name === "creature_loot_template" &&
        this.creatureLootTemplates.length === 0
      ) {
        this.loading = true;
        axios
          .get(
            `/creature-template/${this.creatureTemplate.entry}/creature-loot-template`
          )
          .then((response) => {
            this.creatureLootTemplates = response.data;
            this.loading = false;
          });
      }
      if (
        tab.name === "creature_questitem" &&
        this.creatureQuestItems.length === 0
      ) {
        this.loading = true;
        axios
          .get(
            `/creature-template/${this.creatureTemplate.entry}/creature-questitem`
          )
          .then((response) => {
            this.creatureQuestItems = response.data;
            this.loading = false;
          })
          .catch(() => {
            this.loading = false;
          });
      }
      if (tab.name === "npc_vendor" && this.npcVendors.length === 0) {
        this.loading = true;
        axios
          .get(`/npc-vendor/${this.creatureTemplate.entry}`)
          .then((response) => {
            this.npcVendors = response.data;
            this.loading = false;
          })
          .catch(() => {
            this.loading = false;
          });
      }
      if (tab.name === "npc_trainer" && this.npcTrainers.length === 0) {
        this.loading = true;
        axios
          .get(`/creature-template/${this.creatureTemplate.entry}/npc-trainer`)
          .then((response) => {
            this.npcTrainers = response.data;
            this.loading = false;
          })
          .catch(() => {
            this.loading = false;
          });
      }
      if (
        tab.name === "pickpocketing_loot_template" &&
        this.pickpocketingLootTemplates.length === 0
      ) {
        this.loading = true;
        axios
          .get(
            `/creature-template/${this.creatureTemplate.entry}/pickpocketing-loot-template`
          )
          .then((response) => {
            this.pickpocketingLootTemplates = response.data;
            this.loading = false;
          })
          .catch(() => {
            this.loading = false;
          });
      }
      if (
        tab.name === "skinning_loot_template" &&
        this.skinningLootTemplates.length === 0
      ) {
        this.loading = true;
        axios
          .get(
            `/creature-template/${this.creatureTemplate.entry}/skinning-loot-template`
          )
          .then((response) => {
            this.skinningLootTemplates = response.data;
            this.loading = false;
          })
          .catch(() => {
            this.loading = false;
          });
      }
    },
    showDialog() {
      this.localeDialogVisible = true;
    },
    addCreatureTemplateLocale() {
      this.creatureTemplate.CreatureTemplateLocales.push({
        entry: this.creatureTemplate.entry,
        VerifiedBuild: 0,
      });
    },
    deleteCreatureTemplateLocale(index) {
      this.creatureTemplate.CreatureTemplateLocales.splice(index, 1);
    },
    closeDialog() {
      this.localeDialogVisible = false;
    },
    storeCreatureTemplateLocales() {
      this.localeDialogVisible = false;
    },
  },
  created() {
    this.loading = true;
    let id = this.$route.params.id;
    if (id) {
      axios
        .get(`/creature-template/${id}`)
        .then((response) => {
          this.creatureTemplate = response.data;
          this.loading = false;
        })
        .catch(() => {
          this.loading = false;
        });
    } else {
      axios
        .get("/creature-template/max-id")
        .then((response) => {
          this.creatureTemplate.entry = response.data + 1;
          // this.creatureTemplate = {
          //   entry: response.data + 1,
          //   difficulty_entry_1: 0,
          //   difficulty_entry_2: 0,
          //   difficulty_entry_3: 0,
          //   KillCredit1: 0,
          //   KillCredit2: 0,
          //   modelid1: 0,
          //   modelid2:0,
          //   modelid3: 0,
          //   modelid4: 0,
          //   name: '',
          //   subname: '',
          //   IconName: '',
          //   gossip_menu_id: 0,
          //   minlevel: 1,
          //   maxlevel: 1,
          //   exp: 0,
          //   faction: 0,
          //   npcflag:0,
          //   speed_walk: 0,
          //   speed_run: 1.14286,
          //   scale: 1,
          //   rank: 0,
          //   mindmg: 0,
          //   maxdmg: 0,
          //   dmgschool: 0,
          //   attackpower: 0,
          //   DamageModifier: 1,
          //   BaseAttackTime: 0,
          //   RangeAttackTime: 0,
          //   unit_class: 0,
          //   unit_flags: 0,
          //   unit_flags2: 0,
          //   dynamicflags: 0,
          //   family: 0,
          //   trainer_type: 0,
          //   trainer_spell: 0,
          //   trainer_class: 0,
          //   trainer_race: 0,
          //   minrangedmg: 0,
          //   maxrangedmg: 0,
          //   rangedattackpower: 0,
          //   type: 0,
          //   type_flags: 0,
          //   lootid: 0,
          //   pickpocketloot: 0,
          //   skinloot: 0,
          //   resistance1: 0,
          //   resistance2: 0,
          //   resistance3: 0,
          //   resistance4: 0,
          //   resistance5: 0,
          //   resistance6: 0,
          //   spell1: 0,
          //   spell2: 0,
          //   spell3: 0,
          //   spell4: 0,
          //   spell5: 0,
          //   spell6: 0,
          //   spell7: 0,
          //   spell8: 0,
          //   PetSpellDataId: 0,
          //   VehicleId: 0,
          //   mingold: 0,
          //   maxgold: 0,
          //   AIName: '',
          //   MovementType: 0,
          //   InhabitType: 3,
          //   HoverHeight: 1,
          //   HealthModifier: 1,
          //   ManaModifier: 1,
          //   ArmorModifier: 1,
          //   RacialLeader: 0,
          //   movementId: 0,
          //   RegenHealth: 1,
          //   mechanic_immune_mask: 0,
          //   flags_extra: 0,
          //   ScriptName: '',
          //   VerifiedBuild: 0,
          //   CreatureTemplateLocales: [],
          // };
          this.loading = false;
        })
        .catch(() => {
          this.loading = false;
        });
    }
  },
  components: {
    "flag-editor": FlagEditor,
  },
};
</script>
