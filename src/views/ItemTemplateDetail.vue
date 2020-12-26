<template>
  <div>
    <el-card>
      <el-breadcrumb separator="/">
        <el-breadcrumb-item :to="{ path: '/dashboard' }">首页</el-breadcrumb-item>
        <el-breadcrumb-item :to="{ path: '/item' }">物品管理</el-breadcrumb-item>
        <el-breadcrumb-item>物品详情</el-breadcrumb-item>
      </el-breadcrumb>
      <h3 style="margin: 16px 0 0 0">
        {{ localeName }}
        <small>
          {{ localeDescription }}
        </small>
      </h3>
    </el-card>
    <el-tabs value="item_template" @tab-click="switchover" style="margin-top: 16px">
      <el-tab-pane label="物品模版" name="item_template">
        <el-form :model="itemTemplate" label-position="right" label-width="120px">
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="ID">
                  <el-input v-model="itemTemplate.entry" placeholder="entry" disabled></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="名称">
                  <el-input v-model="itemTemplate.name" placeholder="name">
                    <i
                      class="el-icon-s-operation clickable-icon"
                      slot="suffix"
                      style="margin-right: 8px"
                      @click="showDialog"
                    ></i
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="描述">
                  <el-input v-model="itemTemplate.description" placeholder="description">
                    <i
                      class="el-icon-s-operation clickable-icon"
                      slot="suffix"
                      style="margin-right: 8px"
                      @click="showDialog"
                    ></i
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="脚本">
                  <el-input v-model="itemTemplate.ScriptName" placeholder="ScriptName"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="类别">
                  <el-select v-model="itemTemplate.class" placeholder="class">
                    <el-option
                      v-for="(localeClass, index) in localeClasses"
                      :key="`localeClass-${index}`"
                      :label="localeClass"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="子类别">
                  <el-select v-model="itemTemplate.subclass" placeholder="subclass">
                    <el-option
                      v-for="(localeSubclass, index) in localeSubclasses[itemTemplate.class]"
                      :key="`localeSubclass-${index}`"
                      :label="localeSubclass"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item>
                  <template slot="label">
                    <el-tooltip>
                      <div slot="content" style="max-width: 400px">
                        Weapons have special sounds on impact. This column is used to override these sounds by
                        specifying another subclass. For example an item with misc subclass can sound like a stave on
                        impact by overriding the subclass here.
                      </div>
                      <i class="el-icon-info"></i>
                    </el-tooltip>
                    声音覆盖
                  </template>
                  <el-input v-model="itemTemplate.SoundOverrideSubclass" placeholder="SoundOverrideSubclass"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="图标">
                  <el-input v-model="itemTemplate.displayid" placeholder="displayid"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="品质">
                  <el-select v-model="itemTemplate.Quality" placeholder="Quality">
                    <el-option
                      v-for="(localeQuality, index) in localeQualities"
                      :key="`localeQuality-${index}`"
                      :label="localeQuality"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="购买数量">
                  <el-input v-model="itemTemplate.BuyCount" placeholder="BuyCount"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="购买价格">
                  <el-input v-model="itemTemplate.BuyPrice" placeholder="BuyPrice"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="出售价格">
                  <el-input v-model="itemTemplate.SellPrice" placeholder="SellPrice"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="佩戴位置">
                  <el-select v-model="itemTemplate.InventoryType" placeholder="InventoryType">
                    <el-option
                      v-for="(localeInventoryType, index) in localeInventoryTypes"
                      :key="`localeInventoryType-${index}`"
                      :label="localeInventoryType"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="最大数量">
                  <el-input v-model="itemTemplate.maxcount" placeholder="maxcount"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="堆叠数量">
                  <el-input v-model="itemTemplate.stackable" placeholder="stackable"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="开始任务">
                  <el-input v-model="itemTemplate.startquest" placeholder="startquest"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item>
                  <template slot="label">
                    <el-tooltip>
                      <div slot="content" style="max-width: 400px">
                        The material that the item is made of. The value here affects the sound that the item makes when
                        moved. Use -1 for consumable items like food, reagents, etc.
                      </div>
                      <i class="el-icon-info"></i>
                    </el-tooltip>
                    材质
                  </template>
                  <el-select v-model="itemTemplate.Material" placeholder="Material">
                    <el-option label="消耗品" :value="-1"></el-option>
                    <el-option
                      v-for="(localeMaterial, index) in localeMaterials"
                      :key="`localeMaterial-${index}`"
                      :label="localeMaterial"
                      :value="index"
                    ></el-option>
                  </el-select>
                  <!-- <el-input
                v-model="itemTemplate.Material"
                placeholder="Material"
              ></el-input> -->
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="随机属性">
                  <el-input v-model="itemTemplate.RandomProperty" placeholder="RandomProperty"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="随机后缀">
                  <el-input v-model="itemTemplate.RandomSuffix" placeholder="RandomSuffix"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="背包类别">
                  <el-input v-model="itemTemplate.BagFamily" placeholder="BagFamily"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="背包容量">
                  <el-input v-model="itemTemplate.ContainerSlots" placeholder="ContainerSlots"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="图腾类别">
                  <el-input v-model="itemTemplate.TotemCategory" placeholder="TotemCategory"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="持续时间">
                  <el-input v-model="itemTemplate.duration" placeholder="duration"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="ItemLimitCategory">
                  <el-input v-model="itemTemplate.ItemLimitCategory" placeholder="ItemLimitCategory"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="分解掉落">
                  <el-input v-model="itemTemplate.DisenchantID" placeholder="DisenchantID"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="食物类型">
                  <el-input v-model="itemTemplate.FoodType" placeholder="FoodType"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="最小金钱">
                  <el-input v-model="itemTemplate.minMoneyLoot" placeholder="minMoneyLoot"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="最大金钱">
                  <el-input v-model="itemTemplate.maxMoneyLoot" placeholder="maxMoneyLoot"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="套装">
                  <el-input v-model="itemTemplate.itemset" placeholder="itemset"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="绑定">
                  <el-select v-model="itemTemplate.bonding" placeholder="bonding">
                    <el-option
                      v-for="(bonding, index) in bondings"
                      :key="`bonding-${index}`"
                      :label="bonding"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="标识">
                  <el-input v-model="itemTemplate.Flags" placeholder="Flags"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="额外标识">
                  <el-input v-model="itemTemplate.FlagsExtra" placeholder="FlagsExtra"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="自定义标识">
                  <el-input v-model="itemTemplate.flagsCustom" placeholder="flagsCustom"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item>
                  <template slot="label">
                    <el-tooltip>
                      <div slot="content" style="max-width: 400px">
                        Page text.
                      </div>
                      <i class="el-icon-info"></i>
                    </el-tooltip>
                    页面ID
                  </template>
                  <el-input v-model="itemTemplate.PageText" placeholder="PageText"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item>
                  <template slot="label">
                    <el-tooltip>
                      <div slot="content" style="max-width: 400px">
                        Page material.
                      </div>
                      <i class="el-icon-info"></i>
                    </el-tooltip>
                    页面材料
                  </template>
                  <el-input v-model="itemTemplate.PageMaterial" placeholder="PageMaterial"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="语言ID">
                  <el-input v-model="itemTemplate.LanguageID" placeholder="LanguageID"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="需要职业">
                  <el-input v-model="itemTemplate.AllowableClass" placeholder="AllowableClass"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="需要种族">
                  <el-input v-model="itemTemplate.AllowableRace" placeholder="AllowableRace"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="物品等级">
                  <el-input v-model="itemTemplate.ItemLevel" placeholder="ItemLevel"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="需要等级">
                  <el-input v-model="itemTemplate.RequiredLevel" placeholder="RequiredLevel"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="需要技能">
                  <el-input v-model="itemTemplate.RequiredSkill" placeholder="RequiredSkill"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="需要技能等级">
                  <el-input v-model="itemTemplate.RequiredSkillRank" placeholder="RequiredSkillRank"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="需要法术">
                  <el-input v-model="itemTemplate.requiredspell" placeholder="requiredspell"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="需要荣誉等级">
                  <el-input v-model="itemTemplate.requiredhonorrank" placeholder="requiredhonorrank"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="需要城市等级">
                  <el-input v-model="itemTemplate.RequiredCityRank" placeholder="RequiredCityRank"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="需要势力声望">
                  <el-input
                    v-model="itemTemplate.RequiredReputationFaction"
                    placeholder="RequiredReputationFaction"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="需要声望等级">
                  <el-input
                    v-model="itemTemplate.RequiredReputationRank"
                    placeholder="RequiredReputationRank"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="需要分解熟练度">
                  <el-input
                    v-model="itemTemplate.RequiredDisenchantSkill"
                    placeholder="RequiredDisenchantSkill"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="可用地图">
                  <el-input v-model="itemTemplate.Map" placeholder="PageText"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="可用区域">
                  <el-input v-model="itemTemplate.area" placeholder="area"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="节日ID">
                  <el-input v-model="itemTemplate.HolidayId" placeholder="HolidayId"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="锁ID">
                  <el-input v-model="itemTemplate.lockid" placeholder="lockid"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <!-- 抗性相关 -->
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="神圣抗性">
                  <el-input v-model="itemTemplate.holy_res" placeholder="holy_res"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="暗影抗性">
                  <el-input v-model="itemTemplate.shadow_res" placeholder="shadow_res"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="冰霜抗性">
                  <el-input v-model="itemTemplate.frost_res" placeholder="frost_res"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="火焰抗性">
                  <el-input v-model="itemTemplate.fire_res" placeholder="fire_res"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="自然抗性">
                  <el-input v-model="itemTemplate.nature_res" placeholder="nature_res"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="奥术抗性">
                  <el-input v-model="itemTemplate.arcane_res" placeholder="arcane_res"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <!-- 传家宝相关 -->
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="传家宝属性分配">
                  <el-input
                    v-model="itemTemplate.ScalingStatDistribution"
                    placeholder="ScalingStatDistribution"
                  ></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="传家宝属性标识">
                  <el-input v-model="itemTemplate.ScalingStatValue" placeholder="ScalingStatValue"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <!-- 属性相关 -->
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="属性数量">
                  <el-input-number
                    v-model="itemTemplate.StatsCount"
                    :min="0"
                    controls-position="right"
                    placeholder="StatsCount"
                  ></el-input-number>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="属性类型1">
                  <el-select v-model="itemTemplate.stat_type1" placeholder="stat_type1">
                    <el-option
                      v-for="(localeStatType, index) in localeStatTypes"
                      :key="`localeStatType-${index}`"
                      :label="localeStatType"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性值1">
                  <el-input-number
                    v-model="itemTemplate.stat_value1"
                    controls-position="right"
                    placeholder="stat_value1"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性类型2">
                  <el-select v-model="itemTemplate.stat_type2" placeholder="stat_type2">
                    <el-option
                      v-for="(localeStatType, index) in localeStatTypes"
                      :key="`localeStatType-${index}`"
                      :label="localeStatType"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性值2">
                  <el-input-number
                    v-model="itemTemplate.stat_value2"
                    controls-position="right"
                    placeholder="stat_value2"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性类型3">
                  <el-select v-model="itemTemplate.stat_type3" placeholder="stat_type3">
                    <el-option
                      v-for="(localeStatType, index) in localeStatTypes"
                      :key="`localeStatType-${index}`"
                      :label="localeStatType"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性值3">
                  <el-input-number
                    v-model="itemTemplate.stat_value3"
                    controls-position="right"
                    placeholder="stat_value3"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性类型4">
                  <el-select v-model="itemTemplate.stat_type4" placeholder="stat_type4">
                    <el-option
                      v-for="(localeStatType, index) in localeStatTypes"
                      :key="`localeStatType-${index}`"
                      :label="localeStatType"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性值4">
                  <el-input-number
                    v-model="itemTemplate.stat_value4"
                    controls-position="right"
                    placeholder="stat_value4"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性类型5">
                  <el-select v-model="itemTemplate.stat_type5" placeholder="stat_type5">
                    <el-option
                      v-for="(localeStatType, index) in localeStatTypes"
                      :key="`localeStatType-${index}`"
                      :label="localeStatType"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性值5">
                  <el-input-number
                    v-model="itemTemplate.stat_value5"
                    controls-position="right"
                    placeholder="stat_value5"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性类型6">
                  <el-select v-model="itemTemplate.stat_type6" placeholder="stat_type6">
                    <el-option
                      v-for="(localeStatType, index) in localeStatTypes"
                      :key="`localeStatType-${index}`"
                      :label="localeStatType"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性值6">
                  <el-input-number
                    v-model="itemTemplate.stat_value6"
                    controls-position="right"
                    placeholder="stat_value6"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性类型7">
                  <el-select v-model="itemTemplate.stat_type7" placeholder="stat_type7">
                    <el-option
                      v-for="(localeStatType, index) in localeStatTypes"
                      :key="`localeStatType-${index}`"
                      :label="localeStatType"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性值7">
                  <el-input-number
                    v-model="itemTemplate.stat_value7"
                    controls-position="right"
                    placeholder="stat_value7"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性类型8">
                  <el-select v-model="itemTemplate.stat_type8" placeholder="stat_type8">
                    <el-option
                      v-for="(localeStatType, index) in localeStatTypes"
                      :key="`localeStatType-${index}`"
                      :label="localeStatType"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性值8">
                  <el-input-number
                    v-model="itemTemplate.stat_value8"
                    controls-position="right"
                    placeholder="stat_value8"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性类型9">
                  <el-select v-model="itemTemplate.stat_type9" placeholder="stat_type9">
                    <el-option
                      v-for="(localeStatType, index) in localeStatTypes"
                      :key="`localeStatType-${index}`"
                      :label="localeStatType"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性值9">
                  <el-input-number
                    v-model="itemTemplate.stat_value9"
                    controls-position="right"
                    placeholder="stat_value9"
                  ></el-input-number>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性类型10">
                  <el-select v-model="itemTemplate.stat_type10" placeholder="stat_type10">
                    <el-option
                      v-for="(localeStatType, index) in localeStatTypes"
                      :key="`localeStatType-${index}`"
                      :label="localeStatType"
                      :value="index"
                    ></el-option>
                  </el-select>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="属性值10">
                  <el-input-number
                    v-model="itemTemplate.stat_value10"
                    controls-position="right"
                    placeholder="stat_value10"
                  ></el-input-number>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <!-- 战斗相关 -->
          <el-card style="margin-top: 16px">
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="护甲">
                  <el-input v-model="itemTemplate.armor" placeholder="armor"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="护甲伤害系数">
                  <el-input v-model="itemTemplate.ArmorDamageModifier" placeholder="ArmorDamageModifier"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="攻击间隔">
                  <el-input v-model="itemTemplate.delay" placeholder="delay"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="护甲类型">
                  <el-input v-model="itemTemplate.ammo_type" placeholder="ammo_type"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="攻击距离系数">
                  <el-input v-model="itemTemplate.RangedModRange" placeholder="RangedModRange"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="格挡几率">
                  <el-input v-model="itemTemplate.block" placeholder="block"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="最大持续时间">
                  <el-input v-model="itemTemplate.MaxDurability" placeholder="MaxDurability"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="鞘">
                  <el-input v-model="itemTemplate.sheath" placeholder="sheath"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="伤害类型1">
                  <el-input v-model="itemTemplate.dmg_type1" placeholder="dmg_type1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="最小伤害1">
                  <el-input v-model="itemTemplate.dmg_min1" placeholder="dmg_min1"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="最大伤害1">
                  <el-input v-model="itemTemplate.dmg_max1" placeholder="dmg_max1"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="16">
              <el-col :span="6">
                <el-form-item label="伤害类型2">
                  <el-input v-model="itemTemplate.dmg_type2" placeholder="dmg_type2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="最小伤害2">
                  <el-input v-model="itemTemplate.dmg_min2" placeholder="dmg_min2"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="6">
                <el-form-item label="最大伤害2">
                  <el-input v-model="itemTemplate.dmg_max2" placeholder="dmg_max2"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-card>
          <!-- 技能相关 -->
          <el-card style="margin-top: 16px">
            <div style="width: 100%;">
              <div style="width: 20%; float: left">
                <el-form-item label="技能1">
                  <spell-selector v-model="itemTemplate.spellid_1" placeholder="spellid_1"></spell-selector>
                </el-form-item>
                <el-form-item label="触发方式">
                  <el-select v-model="itemTemplate.spelltrigger_1" placeholder="spelltrigger_1">
                    <el-option label="使用" :value="0"></el-option>
                    <el-option label="装备" :value="1"></el-option>
                    <el-option label="击中时可能" :value="2"></el-option>
                    <el-option label="Soulstone" :value="4"></el-option>
                    <el-option label="Use with no delay" :value="5"></el-option>
                    <el-option label="Learn Spell ID" :value="6"></el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="充能次数">
                  <el-input v-model="itemTemplate.spellcharges_1" placeholder="spellcharges_1"></el-input>
                </el-form-item>
                <el-form-item label="几率">
                  <el-input v-model="itemTemplate.spellppmRate_1" placeholder="spellppmRate_1"></el-input>
                </el-form-item>
                <el-form-item label="冷却时间">
                  <el-input v-model="itemTemplate.spellcooldown_1" placeholder="spellcooldown_1"></el-input>
                </el-form-item>
                <el-form-item label="技能组">
                  <el-input v-model="itemTemplate.spellcategory_1" placeholder="spellcategory_1"></el-input>
                </el-form-item>
                <el-form-item label="技能组冷却时间">
                  <el-input
                    v-model="itemTemplate.spellcategorycooldown_1"
                    placeholder="spellcategorycooldown_1"
                  ></el-input>
                </el-form-item>
              </div>
              <div style="width: 20%; float: left">
                <el-form-item label="技能2">
                  <spell-selector v-model="itemTemplate.spellid_2" placeholder="spellid_2"></spell-selector>
                </el-form-item>
                <el-form-item label="触发方式">
                  <el-select v-model="itemTemplate.spelltrigger_2" placeholder="spelltrigger_2">
                    <el-option label="使用" :value="0"></el-option>
                    <el-option label="装备" :value="1"></el-option>
                    <el-option label="击中时可能" :value="2"></el-option>
                    <el-option label="Soulstone" :value="4"></el-option>
                    <el-option label="Use with no delay" :value="5"></el-option>
                    <el-option label="Learn Spell ID" :value="6"></el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="充能次数">
                  <el-input v-model="itemTemplate.spellcharges_2" placeholder="spellcharges_2"></el-input>
                </el-form-item>
                <el-form-item label="几率">
                  <el-input v-model="itemTemplate.spellppmRate_2" placeholder="spellppmRate_2"></el-input>
                </el-form-item>
                <el-form-item label="冷却时间">
                  <el-input v-model="itemTemplate.spellcooldown_2" placeholder="spellcooldown_2"></el-input>
                </el-form-item>
                <el-form-item label="技能组">
                  <el-input v-model="itemTemplate.spellcategory_2" placeholder="spellcategory_2"></el-input>
                </el-form-item>
                <el-form-item label="技能组冷却时间">
                  <el-input
                    v-model="itemTemplate.spellcategorycooldown_2"
                    placeholder="spellcategorycooldown_2"
                  ></el-input>
                </el-form-item>
              </div>
              <div style="width: 20%; float: left">
                <el-form-item label="技能3">
                  <spell-selector v-model="itemTemplate.spellid_3" placeholder="spellid_3"></spell-selector>
                </el-form-item>
                <el-form-item label="触发方式">
                  <el-select v-model="itemTemplate.spelltrigger_3" placeholder="spelltrigger_3">
                    <el-option label="使用" :value="0"></el-option>
                    <el-option label="装备" :value="1"></el-option>
                    <el-option label="击中时可能" :value="2"></el-option>
                    <el-option label="Soulstone" :value="4"></el-option>
                    <el-option label="Use with no delay" :value="5"></el-option>
                    <el-option label="Learn Spell ID" :value="6"></el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="充能次数">
                  <el-input v-model="itemTemplate.spellcharges_3" placeholder="spellcharges_3"></el-input>
                </el-form-item>
                <el-form-item label="几率">
                  <el-input v-model="itemTemplate.spellppmRate_3" placeholder="spellppmRate_3"></el-input>
                </el-form-item>
                <el-form-item label="冷却时间">
                  <el-input v-model="itemTemplate.spellcooldown_3" placeholder="spellcooldown_3"></el-input>
                </el-form-item>
                <el-form-item label="技能组">
                  <el-input v-model="itemTemplate.spellcategory_3" placeholder="spellcategory_3"></el-input>
                </el-form-item>
                <el-form-item label="技能组冷却时间">
                  <el-input
                    v-model="itemTemplate.spellcategorycooldown_3"
                    placeholder="spellcategorycooldown_3"
                  ></el-input>
                </el-form-item>
              </div>
              <div style="width: 20%; float: left">
                <el-form-item label="技能4">
                  <spell-selector v-model="itemTemplate.spellid_4" placeholder="spellid_4"></spell-selector>
                </el-form-item>
                <el-form-item label="触发方式">
                  <el-select v-model="itemTemplate.spelltrigger_4" placeholder="spelltrigger_4">
                    <el-option label="使用" :value="0"></el-option>
                    <el-option label="装备" :value="1"></el-option>
                    <el-option label="击中时可能" :value="2"></el-option>
                    <el-option label="Soulstone" :value="4"></el-option>
                    <el-option label="Use with no delay" :value="5"></el-option>
                    <el-option label="Learn Spell ID" :value="6"></el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="充能次数">
                  <el-input v-model="itemTemplate.spellcharges_4" placeholder="spellcharges_4"></el-input>
                </el-form-item>
                <el-form-item label="几率">
                  <el-input v-model="itemTemplate.spellppmRate_4" placeholder="spellppmRate_4"></el-input>
                </el-form-item>
                <el-form-item label="冷却时间">
                  <el-input v-model="itemTemplate.spellcooldown_4" placeholder="spellcooldown_4"></el-input>
                </el-form-item>
                <el-form-item label="技能组">
                  <el-input v-model="itemTemplate.spellcategory_4" placeholder="spellcategory_4"></el-input>
                </el-form-item>
                <el-form-item label="技能组冷却时间">
                  <el-input
                    v-model="itemTemplate.spellcategorycooldown_4"
                    placeholder="spellcategorycooldown_4"
                  ></el-input>
                </el-form-item>
              </div>
              <div style="width: 20%; float: left">
                <el-form-item label="技能5">
                  <spell-selector v-model="itemTemplate.spellid_5" placeholder="spellid_5"></spell-selector>
                </el-form-item>
                <el-form-item label="触发方式">
                  <el-select v-model="itemTemplate.spelltrigger_5" placeholder="spelltrigger_5">
                    <el-option label="使用" :value="0"></el-option>
                    <el-option label="装备" :value="1"></el-option>
                    <el-option label="击中时可能" :value="2"></el-option>
                    <el-option label="Soulstone" :value="4"></el-option>
                    <el-option label="Use with no delay" :value="5"></el-option>
                    <el-option label="Learn Spell ID" :value="6"></el-option>
                  </el-select>
                </el-form-item>
                <el-form-item label="充能次数">
                  <el-input v-model="itemTemplate.spellcharges_5" placeholder="spellcharges_5"></el-input>
                </el-form-item>
                <el-form-item label="几率">
                  <el-input v-model="itemTemplate.spellppmRate_5" placeholder="spellppmRate_5"></el-input>
                </el-form-item>
                <el-form-item label="冷却时间">
                  <el-input v-model="itemTemplate.spellcooldown_5" placeholder="spellcooldown_5"></el-input>
                </el-form-item>
                <el-form-item label="技能组">
                  <el-input v-model="itemTemplate.spellcategory_5" placeholder="spellcategory_5"></el-input>
                </el-form-item>
                <el-form-item label="技能组冷却时间">
                  <el-input
                    v-model="itemTemplate.spellcategorycooldown_5"
                    placeholder="spellcategorycooldown_5"
                  ></el-input>
                </el-form-item>
              </div>
              <div style="clear:both"></div>
            </div>
          </el-card>
          <el-card style="margin-top: 16px">
            <el-button type="primary" @click="() => store('item_template')">保存</el-button>
            <el-button @click="cancle">返回</el-button>
          </el-card>
        </el-form>
      </el-tab-pane>
      <el-tab-pane label="附魔模版" name="item_enchantment_template">
        <el-card style="margin-top: 16px">
          <el-button type="primary">新增</el-button>
          <el-button disabled>复制</el-button>
          <el-button type="danger" disabled>删除</el-button>
        </el-card>
        <el-card style="margin-top: 16px">
          <el-table :data="itemEnchantmentTemplates">
            <el-table-column prop="entry" label="ID"></el-table-column>
            <el-table-column prop="ench" label="附魔"></el-table-column>
            <el-table-column prop="Chance" label="几率"></el-table-column>
          </el-table>
        </el-card>
      </el-tab-pane>
      <el-tab-pane label="物品掉落" name="item_loot_template">
        <el-card style="margin-top: 16px">
          <el-button type="primary">新增</el-button>
          <el-button disabled>复制</el-button>
          <el-button type="danger" disabled>删除</el-button>
        </el-card>
        <el-card style="margin-top: 16px">
          <el-table :data="itemLootTemplates">
            <el-table-column prop="Entry" label="ID"></el-table-column>
            <el-table-column prop="Item" label="物品"></el-table-column>
            <el-table-column prop="Reference" label="关联"></el-table-column>
            <el-table-column prop="Chance" label="几率"></el-table-column>
            <el-table-column prop="QuestRequired" label="需要任务"></el-table-column>
            <el-table-column prop="LootMode" label="掉落模式"></el-table-column>
            <el-table-column prop="GroupId" label="组"></el-table-column>
            <el-table-column prop="MinCount" label="最小数量"></el-table-column>
            <el-table-column prop="MaxCount" label="最大数量"></el-table-column>
            <el-table-column prop="Comment" label="Comment"></el-table-column>
          </el-table>
        </el-card>
      </el-tab-pane>
      <el-tab-pane label="分解掉落" name="disenchant_loot_template">
        <el-card style="margin-top: 16px">
          <el-button type="primary">新增</el-button>
          <el-button disabled>复制</el-button>
          <el-button type="danger" disabled>删除</el-button>
        </el-card>
        <el-card style="margin-top: 16px">
          <el-table :data="disenchantLootTemplates">
            <el-table-column prop="Entry" label="ID"></el-table-column>
            <el-table-column prop="Item" label="物品"></el-table-column>
            <el-table-column prop="Reference" label="关联"></el-table-column>
            <el-table-column prop="Chance" label="几率"></el-table-column>
            <el-table-column prop="QuestRequired" label="需要任务"></el-table-column>
            <el-table-column prop="LootMode" label="掉落模式"></el-table-column>
            <el-table-column prop="GroupId" label="组"></el-table-column>
            <el-table-column prop="MinCount" label="最小数量"></el-table-column>
            <el-table-column prop="MaxCount" label="最大数量"></el-table-column>
            <el-table-column prop="Comment" label="Comment"></el-table-column>
          </el-table>
        </el-card>
      </el-tab-pane>
      <el-tab-pane label="挖矿掉落" name="prospecting_loot_template">
        <el-card style="margin-top: 16px">
          <el-button type="primary">新增</el-button>
          <el-button disabled>复制</el-button>
          <el-button type="danger" disabled>删除</el-button>
        </el-card>
        <el-card style="margin-top: 16px">
          <el-table :data="prospectingLootTemplates">
            <el-table-column prop="Entry" label="ID"></el-table-column>
            <el-table-column prop="Item" label="物品"></el-table-column>
            <el-table-column prop="Reference" label="关联"></el-table-column>
            <el-table-column prop="Chance" label="几率"></el-table-column>
            <el-table-column prop="QuestRequired" label="需要任务"></el-table-column>
            <el-table-column prop="LootMode" label="掉落模式"></el-table-column>
            <el-table-column prop="GroupId" label="组"></el-table-column>
            <el-table-column prop="MinCount" label="最小数量"></el-table-column>
            <el-table-column prop="MaxCount" label="最大数量"></el-table-column>
            <el-table-column prop="Comment" label="Comment"></el-table-column>
          </el-table>
        </el-card>
      </el-tab-pane>
      <el-tab-pane label="铭文掉落" name="milling_loot_template">
        <el-card style="margin-top: 16px">
          <el-button type="primary">新增</el-button>
          <el-button disabled>复制</el-button>
          <el-button type="danger" disabled>删除</el-button>
        </el-card>
        <el-card style="margin-top: 16px">
          <el-table :data="millingLootTemplates">
            <el-table-column prop="Entry" label="ID"></el-table-column>
            <el-table-column prop="Item" label="物品"></el-table-column>
            <el-table-column prop="Reference" label="关联"></el-table-column>
            <el-table-column prop="Chance" label="几率"></el-table-column>
            <el-table-column prop="QuestRequired" label="需要任务"></el-table-column>
            <el-table-column prop="LootMode" label="掉落模式"></el-table-column>
            <el-table-column prop="GroupId" label="组"></el-table-column>
            <el-table-column prop="MinCount" label="最小数量"></el-table-column>
            <el-table-column prop="MaxCount" label="最大数量"></el-table-column>
            <el-table-column prop="Comment" label="Comment"></el-table-column>
          </el-table>
        </el-card>
      </el-tab-pane>
    </el-tabs>
    <el-dialog :visible.sync="localeDialogVisible" :show-close="false" :close-on-click-modal="false">
      <div slot="title">
        <span style="font-size: 18px;color: #303133;margin-right:16px">名称/描述本地化</span>
        <el-button size="mini" @click="addItemTemplateLocale">新增</el-button>
      </div>
      <el-table :data="itemTemplateLocales">
        <el-table-column width="48">
          <el-button
            type="danger"
            size="mini"
            icon="el-icon-delete"
            circle=""
            slot-scope="scope"
            @click="() => deleteItemTemplateLocale(scope.$index)"
          ></el-button>
        </el-table-column>
        <el-table-column prop="ID" label="编号">
          <template slot-scope="scope">
            <el-input-number v-model="scope.row.ID" controls-position="right" disabled></el-input-number>
          </template>
        </el-table-column>
        <el-table-column prop="locale" label="语言">
          <template slot-scope="scope">
            <el-input v-model="scope.row.locale" placeholder="locale"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Name" label="名称">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Name" placeholder="Name"></el-input>
          </template>
        </el-table-column>
        <el-table-column prop="Description" label="称号">
          <template slot-scope="scope">
            <el-input v-model="scope.row.Description" placeholder="Description"></el-input>
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
        <el-button type="primary" @click="submitItemTemplateLocales">保存</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
// import icons from "@/libs/icons";

import {
  // colors,
  localeClasses,
  localeSubclasses,
  localeInventoryTypes,
  localeQualities,
  localeMaterials,
  localeStatTypes,
  bondings
} from "../locales/item.js";

import { mapState, mapActions } from "vuex";
// import * as types from "@/store/MUTATION_TYPES";

import SpellSelector from "@/components/SpellSelector";

export default {
  data() {
    return {
      isCreating: false,
      loading: false,
      localeClasses: localeClasses,
      localeSubclasses: localeSubclasses,
      localeInventoryTypes: localeInventoryTypes,
      localeQualities: localeQualities,
      localeMaterials: localeMaterials,
      localeStatTypes: localeStatTypes,
      bondings: bondings,
      localeDialogVisible: false
    };
  },
  computed: {
    ...mapState("item", [
      "itemTemplate",
      "itemTemplateLocales",
      "itemEnchantmentTemplates",
      "itemLootTemplates",
      "disenchantLootTemplates",
      "prospectingLootTemplates",
      "millingLootTemplates"
    ]),
    localeName() {
      if (this.itemTemplateLocales.length > 0) {
        let name = undefined;
        for (let itemTemplateLocale of this.itemTemplateLocales) {
          if (itemTemplateLocale.locale === "zhCN") {
            name = itemTemplateLocale.Name;
          }
        }
        return name !== undefined ? name : this.itemTemplate.name;
      } else {
        return this.itemTemplate.name;
      }
    },
    localeDescription() {
      if (this.itemTemplateLocales.length > 0) {
        let description = undefined;
        for (let itemTemplateLocale of this.itemTemplateLocales) {
          if (itemTemplateLocale.locale === "zhCN") {
            description = itemTemplateLocale.Description;
          }
        }
        return description !== undefined ? description : this.itemTemplate.description;
      } else {
        return this.itemTemplate.description;
      }
    }
  },
  methods: {
    ...mapActions("item", {
      storeItemTemplate: "store",
      findItemTemplate: "find",
      updateItemTemplate: "update",
      searchItemTemplateLocales: "searchItemTemplateLocales"
    }),
    async switchover(tab) {
      let id = this.itemTemplate.entry;
      if (tab.name === "enchantment_template") {
        this.loading = true;
        // await this.findCreatureTemplateAddon({ entry: id });
        console.log(id);
        this.loading = false;
      }
      // if (tab.name === "creature_onkill_reputation") {
      //   this.loading = true;
      //   await this.findCreatureOnKillReputation({ creatureId: id });
      //   this.loading = false;
      // }
      // if (tab.name === "creature_equip_template") {
      //   this.loading = true;
      //   await this.searchCreatureEquipTemplates({ creatureId: id });
      //   this.loading = false;
      // }
      // if (tab.name === "npc_vendor") {
      //   this.loading = true;
      //   await this.searchNpcVendors({ entry: id });
      //   this.loading = false;
      // }
      // if (tab.name === "npc_trainer") {
      //   this.loading = true;
      //   await this.searchNpcTrainers({ id: id });
      //   this.loading = false;
      // }
      // if (tab.name === "creature_questitem") {
      //   await this.searchCreatureQuestItems({ creatureEntry: id });
      //   this.loading = true;
      // }
      // if (tab.name === "creature_loot_template") {
      //   await this.searchCreatureLootTemplates({ entry: id });
      //   this.loading = true;
      // }
      // if (tab.name === "pickpocketing_loot_template") {
      //   await this.searchPickpocketingLootTemplates({ entry: id });
      //   this.loading = true;
      // }
      // if (tab.name === "skinning_loot_template") {
      //   await this.searchSkinningLootTemplates({ entry: id });
      //   this.loading = true;
      // }
      // this.loading = false;
    },
    showDialog() {
      this.localeDialogVisible = true;
    },
    closeDialog() {
      this.localeDialogVisible = false;
    },
    addItemTemplateLocale() {},
    deleteItemTemplateLocale() {},
    submitItemTemplateLocales() {},
    store(module) {
      this.loading = true;
      switch (module) {
        case "item_template":
          if (this.isCreating) {
            this.storeItemTemplate(this.itemTemplate);
          } else {
            this.updateItemTemplate(this.itemTemplate);
          }
          break;
        default:
          break;
      }
      this.loading = false;
    },
    cancle() {
      this.$router.go(-1);
    },
    async init() {
      this.loading = true;
      let id = this.$route.params.id;
      let path = this.$route.path;
      if (path === "/item-template/create") {
        this.findItemTemplate({ entry: 0 });
        let maxEntry = await this.getMaxEntryOfItemTemplate();
        this.itemTemplate.ID = maxEntry + 1;
        this.min = maxEntry + 1;
      } else {
        this.isCreating = false;
        await Promise.all([this.findItemTemplate({ entry: id }), this.searchItemTemplateLocales({ ID: id })]);
      }
      this.loading = false;
    }
  },
  created() {
    this.init();
  },
  components: {
    "spell-selector": SpellSelector
  }
};
</script>
