<template>
  <el-form :model="itemTemplate" label-position="right" label-width="120px">
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="ID">
            <el-input-number
              v-model="itemTemplate.entry"
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
          <el-form-item label="名称">
            <item-template-localizer
              v-model="itemTemplate.name"
              placeholder="name"
            ></item-template-localizer>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="描述">
            <item-template-localizer
              v-model="itemTemplate.description"
              placeholder="description"
            ></item-template-localizer>
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
                v-for="(localeSubclass, index) in localeSubclasses[
                  itemTemplate.class
                ]"
                :key="`localeSubclass-${index}`"
                :label="localeSubclass"
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="声音覆盖"
              :tooltip="soundOverrideSubclassTooltip"
              slot="label"
            ></hint-label>
            <el-input
              v-model="itemTemplate.SoundOverrideSubclass"
              placeholder="SoundOverrideSubclass"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item>
            <hint-label
              label="材质"
              :tooltip="materialTooltip"
              slot="label"
            ></hint-label>
            <el-select v-model="itemTemplate.Material" placeholder="Material">
              <el-option label="消耗品" :value="-1"></el-option>
              <el-option
                v-for="(localeMaterial, index) in localeMaterials"
                :key="`localeMaterial-${index}`"
                :label="localeMaterial"
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="外观">
            <el-input
              v-model="itemTemplate.displayid"
              placeholder="displayid"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="佩戴位置">
            <el-select
              v-model="itemTemplate.InventoryType"
              placeholder="InventoryType"
            >
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
          <el-form-item label="武器位置">
            <el-select v-model="itemTemplate.sheath" placeholder="sheath">
              <el-option
                v-for="(sheath, index) in sheaths"
                :key="`sheath-${index}`"
                :label="sheath"
                :value="index"
              ></el-option>
            </el-select>
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
          <el-form-item label="套装">
            <item-set-selector
              v-model="itemTemplate.itemset"
              placeholder="itemset"
            ></item-set-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="随机属性">
            <item-random-properties-selector
              v-model="itemTemplate.RandomProperty"
              placeholder="RandomProperty"
              :disabled="
                !Boolean(itemTemplate.RandomProperty) &&
                  Boolean(itemTemplate.RandomSuffix)
              "
            ></item-random-properties-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="随机前缀">
            <el-input
              v-model="itemTemplate.RandomSuffix"
              controls-position="right"
              placeholder="RandomSuffix"
              :disabled="
                !Boolean(itemTemplate.RandomSuffix) &&
                  Boolean(itemTemplate.RandomProperty)
              "
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="耐久度">
            <el-input-number
              v-model="itemTemplate.MaxDurability"
              controls-position="right"
              placeholder="MaxDurability"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="购买价格">
            <el-input-number
              v-model="itemTemplate.BuyPrice"
              controls-position="right"
              placeholder="BuyPrice"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="出售价格">
            <el-input-number
              v-model="itemTemplate.SellPrice"
              controls-position="right"
              placeholder="SellPrice"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="购买数量">
            <el-input-number
              v-model="itemTemplate.BuyCount"
              controls-position="right"
              placeholder="BuyCount"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="持有数量">
            <el-input-number
              v-model="itemTemplate.maxcount"
              controls-position="right"
              placeholder="maxcount"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="堆叠数量">
            <el-input-number
              v-model="itemTemplate.stackable"
              controls-position="right"
              placeholder="stackable"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="图腾类别">
            <el-input
              v-model="itemTemplate.TotemCategory"
              placeholder="TotemCategory"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="食物类型">
            <el-select v-model="itemTemplate.FoodType" placeholder="FoodType">
              <el-option
                v-for="(foodType, index) in foodTypes"
                :key="`foodType-${index}`"
                :label="foodType"
                :value="index"
              ></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="背包类别">
            <flag-editor
              v-model="itemTemplate.BagFamily"
              title="背包类别编辑器"
              :flags="bagFamilies"
              placeholder="BagFamily"
            ></flag-editor>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="背包容量">
            <el-input-number
              v-model="itemTemplate.ContainerSlots"
              controls-position="right"
              placeholder="ContainerSlots"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="限制分类">
            <el-input
              v-model="itemTemplate.ItemLimitCategory"
              placeholder="ItemLimitCategory"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="开始任务">
            <el-input
              v-model="itemTemplate.startquest"
              placeholder="startquest"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="持续时间">
            <el-input-number
              v-model="itemTemplate.duration"
              controls-position="right"
              placeholder="duration"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="分解掉落">
            <el-input
              v-model="itemTemplate.DisenchantID"
              placeholder="DisenchantID"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="最小金钱">
            <el-input-number
              v-model="itemTemplate.minMoneyLoot"
              controls-position="right"
              placeholder="minMoneyLoot"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="最大金钱">
            <el-input-number
              v-model="itemTemplate.maxMoneyLoot"
              controls-position="right"
              placeholder="maxMoneyLoot"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="标识">
            <flag-editor
              v-model="itemTemplate.Flags"
              title="标识编辑器"
              :flags="flags"
              placeholder="Flags"
            ></flag-editor>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="额外标识">
            <flag-editor
              v-model="itemTemplate.FlagsExtra"
              title="额外标识编辑器"
              :flags="flagsExtra"
              placeholder="FlagsExtra"
            ></flag-editor>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="自定义标识">
            <flag-editor
              v-model="itemTemplate.flagsCustom"
              title="自定义标识编辑器"
              :flags="flagsCustom"
              placeholder="flagsCustom"
            ></flag-editor>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="攻击间隔">
            <el-input-number
              v-model="itemTemplate.delay"
              controls-position="right"
              placeholder="delay"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="攻击距离系数">
            <el-input-number
              v-model="itemTemplate.RangedModRange"
              controls-position="right"
              placeholder="RangedModRange"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="护甲伤害系数">
            <el-input-number
              v-model="itemTemplate.ArmorDamageModifier"
              controls-position="right"
              placeholder="ArmorDamageModifier"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="伤害类型1">
            <el-input
              v-model="itemTemplate.dmg_type1"
              placeholder="dmg_type1"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="最小伤害1">
            <el-input-number
              v-model="itemTemplate.dmg_min1"
              controls-position="right"
              placeholder="dmg_min1"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="最大伤害1">
            <el-input-number
              v-model="itemTemplate.dmg_max1"
              controls-position="right"
              placeholder="dmg_max1"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="伤害类型2">
            <el-input
              v-model="itemTemplate.dmg_type2"
              placeholder="dmg_type2"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="最小伤害2">
            <el-input-number
              v-model="itemTemplate.dmg_min2"
              controls-position="right"
              placeholder="dmg_min2"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="最大伤害2">
            <el-input-number
              v-model="itemTemplate.dmg_max2"
              controls-position="right"
              placeholder="dmg_max2"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="护甲类型">
            <el-input
              v-model="itemTemplate.ammo_type"
              placeholder="ammo_type"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="护甲">
            <el-input-number
              v-model="itemTemplate.armor"
              controls-position="right"
              placeholder="armor"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="格挡几率">
            <el-input-number
              v-model="itemTemplate.block"
              controls-position="right"
              placeholder="block"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="缩放属性分配">
            <scaling-stat-distribution-selector
              v-model="itemTemplate.ScalingStatDistribution"
              placeholder="ScalingStatDistribution"
            ></scaling-stat-distribution-selector>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="缩放属性标识">
            <flag-editor
              v-model="itemTemplate.ScalingStatValue"
              title="缩放属性标识编辑器"
              :flags="scalingStatValues"
              placeholder="ScalingStatValue"
            ></flag-editor>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
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
            <el-select
              v-model="itemTemplate.stat_type1"
              placeholder="stat_type1"
            >
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
            <el-select
              v-model="itemTemplate.stat_type2"
              placeholder="stat_type2"
            >
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
            <el-select
              v-model="itemTemplate.stat_type3"
              placeholder="stat_type3"
            >
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
            <el-select
              v-model="itemTemplate.stat_type4"
              placeholder="stat_type4"
            >
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
            <el-select
              v-model="itemTemplate.stat_type5"
              placeholder="stat_type5"
            >
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
            <el-select
              v-model="itemTemplate.stat_type6"
              placeholder="stat_type6"
            >
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
            <el-select
              v-model="itemTemplate.stat_type7"
              placeholder="stat_type7"
            >
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
            <el-select
              v-model="itemTemplate.stat_type8"
              placeholder="stat_type8"
            >
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
            <el-select
              v-model="itemTemplate.stat_type9"
              placeholder="stat_type9"
            >
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
            <el-select
              v-model="itemTemplate.stat_type10"
              placeholder="stat_type10"
            >
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
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="神圣抗性">
            <el-input-number
              v-model="itemTemplate.holy_res"
              controls-position="right"
              placeholder="holy_res"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="火焰抗性">
            <el-input-number
              v-model="itemTemplate.fire_res"
              controls-position="right"
              placeholder="fire_res"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="自然抗性">
            <el-input-number
              v-model="itemTemplate.nature_res"
              controls-position="right"
              placeholder="nature_res"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="暗影抗性">
            <el-input-number
              v-model="itemTemplate.shadow_res"
              controls-position="right"
              placeholder="shadow_res"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="冰霜抗性">
            <el-input-number
              v-model="itemTemplate.frost_res"
              controls-position="right"
              placeholder="frost_res"
            ></el-input-number>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="奥术抗性">
            <el-input-number
              v-model="itemTemplate.arcane_res"
              controls-position="right"
              placeholder="arcane_res"
            ></el-input-number>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <div style="width: 100%">
        <div style="width: 20%; float: left">
          <el-form-item label="技能1">
            <spell-selector
              v-model="itemTemplate.spellid_1"
              placeholder="spellid_1"
            ></spell-selector>
          </el-form-item>
          <el-form-item label="触发方式">
            <el-select
              v-model="itemTemplate.spelltrigger_1"
              placeholder="spelltrigger_1"
            >
              <el-option label="使用" :value="0"></el-option>
              <el-option label="装备" :value="1"></el-option>
              <el-option label="击中时可能" :value="2"></el-option>
              <el-option label="Soulstone" :value="4"></el-option>
              <el-option label="Use with no delay" :value="5"></el-option>
              <el-option label="Learn Spell ID" :value="6"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="充能次数">
            <el-input
              v-model="itemTemplate.spellcharges_1"
              placeholder="spellcharges_1"
            ></el-input>
          </el-form-item>
          <el-form-item label="几率">
            <el-input
              v-model="itemTemplate.spellppmRate_1"
              placeholder="spellppmRate_1"
            ></el-input>
          </el-form-item>
          <el-form-item label="冷却时间">
            <el-input
              v-model="itemTemplate.spellcooldown_1"
              placeholder="spellcooldown_1"
            ></el-input>
          </el-form-item>
          <el-form-item label="技能组">
            <el-input
              v-model="itemTemplate.spellcategory_1"
              placeholder="spellcategory_1"
            ></el-input>
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
            <spell-selector
              v-model="itemTemplate.spellid_2"
              placeholder="spellid_2"
            ></spell-selector>
          </el-form-item>
          <el-form-item label="触发方式">
            <el-select
              v-model="itemTemplate.spelltrigger_2"
              placeholder="spelltrigger_2"
            >
              <el-option label="使用" :value="0"></el-option>
              <el-option label="装备" :value="1"></el-option>
              <el-option label="击中时可能" :value="2"></el-option>
              <el-option label="Soulstone" :value="4"></el-option>
              <el-option label="Use with no delay" :value="5"></el-option>
              <el-option label="Learn Spell ID" :value="6"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="充能次数">
            <el-input
              v-model="itemTemplate.spellcharges_2"
              placeholder="spellcharges_2"
            ></el-input>
          </el-form-item>
          <el-form-item label="几率">
            <el-input
              v-model="itemTemplate.spellppmRate_2"
              placeholder="spellppmRate_2"
            ></el-input>
          </el-form-item>
          <el-form-item label="冷却时间">
            <el-input
              v-model="itemTemplate.spellcooldown_2"
              placeholder="spellcooldown_2"
            ></el-input>
          </el-form-item>
          <el-form-item label="技能组">
            <el-input
              v-model="itemTemplate.spellcategory_2"
              placeholder="spellcategory_2"
            ></el-input>
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
            <spell-selector
              v-model="itemTemplate.spellid_3"
              placeholder="spellid_3"
            ></spell-selector>
          </el-form-item>
          <el-form-item label="触发方式">
            <el-select
              v-model="itemTemplate.spelltrigger_3"
              placeholder="spelltrigger_3"
            >
              <el-option label="使用" :value="0"></el-option>
              <el-option label="装备" :value="1"></el-option>
              <el-option label="击中时可能" :value="2"></el-option>
              <el-option label="Soulstone" :value="4"></el-option>
              <el-option label="Use with no delay" :value="5"></el-option>
              <el-option label="Learn Spell ID" :value="6"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="充能次数">
            <el-input
              v-model="itemTemplate.spellcharges_3"
              placeholder="spellcharges_3"
            ></el-input>
          </el-form-item>
          <el-form-item label="几率">
            <el-input
              v-model="itemTemplate.spellppmRate_3"
              placeholder="spellppmRate_3"
            ></el-input>
          </el-form-item>
          <el-form-item label="冷却时间">
            <el-input
              v-model="itemTemplate.spellcooldown_3"
              placeholder="spellcooldown_3"
            ></el-input>
          </el-form-item>
          <el-form-item label="技能组">
            <el-input
              v-model="itemTemplate.spellcategory_3"
              placeholder="spellcategory_3"
            ></el-input>
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
            <spell-selector
              v-model="itemTemplate.spellid_4"
              placeholder="spellid_4"
            ></spell-selector>
          </el-form-item>
          <el-form-item label="触发方式">
            <el-select
              v-model="itemTemplate.spelltrigger_4"
              placeholder="spelltrigger_4"
            >
              <el-option label="使用" :value="0"></el-option>
              <el-option label="装备" :value="1"></el-option>
              <el-option label="击中时可能" :value="2"></el-option>
              <el-option label="Soulstone" :value="4"></el-option>
              <el-option label="Use with no delay" :value="5"></el-option>
              <el-option label="Learn Spell ID" :value="6"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="充能次数">
            <el-input
              v-model="itemTemplate.spellcharges_4"
              placeholder="spellcharges_4"
            ></el-input>
          </el-form-item>
          <el-form-item label="几率">
            <el-input
              v-model="itemTemplate.spellppmRate_4"
              placeholder="spellppmRate_4"
            ></el-input>
          </el-form-item>
          <el-form-item label="冷却时间">
            <el-input
              v-model="itemTemplate.spellcooldown_4"
              placeholder="spellcooldown_4"
            ></el-input>
          </el-form-item>
          <el-form-item label="技能组">
            <el-input
              v-model="itemTemplate.spellcategory_4"
              placeholder="spellcategory_4"
            ></el-input>
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
            <spell-selector
              v-model="itemTemplate.spellid_5"
              placeholder="spellid_5"
            ></spell-selector>
          </el-form-item>
          <el-form-item label="触发方式">
            <el-select
              v-model="itemTemplate.spelltrigger_5"
              placeholder="spelltrigger_5"
            >
              <el-option label="使用" :value="0"></el-option>
              <el-option label="装备" :value="1"></el-option>
              <el-option label="击中时可能" :value="2"></el-option>
              <el-option label="Soulstone" :value="4"></el-option>
              <el-option label="Use with no delay" :value="5"></el-option>
              <el-option label="Learn Spell ID" :value="6"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="充能次数">
            <el-input
              v-model="itemTemplate.spellcharges_5"
              placeholder="spellcharges_5"
            ></el-input>
          </el-form-item>
          <el-form-item label="几率">
            <el-input
              v-model="itemTemplate.spellppmRate_5"
              placeholder="spellppmRate_5"
            ></el-input>
          </el-form-item>
          <el-form-item label="冷却时间">
            <el-input
              v-model="itemTemplate.spellcooldown_5"
              placeholder="spellcooldown_5"
            ></el-input>
          </el-form-item>
          <el-form-item label="技能组">
            <el-input
              v-model="itemTemplate.spellcategory_5"
              placeholder="spellcategory_5"
            ></el-input>
          </el-form-item>
          <el-form-item label="技能组冷却时间">
            <el-input
              v-model="itemTemplate.spellcategorycooldown_5"
              placeholder="spellcategorycooldown_5"
            ></el-input>
          </el-form-item>
        </div>
        <div style="clear: both"></div>
      </div>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="需要职业">
            <el-input
              v-model="itemTemplate.AllowableClass"
              placeholder="AllowableClass"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="需要种族">
            <el-input
              v-model="itemTemplate.AllowableRace"
              placeholder="AllowableRace"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="物品等级">
            <el-input
              v-model="itemTemplate.ItemLevel"
              placeholder="ItemLevel"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="需要等级">
            <el-input
              v-model="itemTemplate.RequiredLevel"
              placeholder="RequiredLevel"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="需要技能">
            <el-input
              v-model="itemTemplate.RequiredSkill"
              placeholder="RequiredSkill"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="需要技能等级">
            <el-input
              v-model="itemTemplate.RequiredSkillRank"
              placeholder="RequiredSkillRank"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="需要法术">
            <el-input
              v-model="itemTemplate.requiredspell"
              placeholder="requiredspell"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="需要荣誉等级">
            <el-input
              v-model="itemTemplate.requiredhonorrank"
              placeholder="requiredhonorrank"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="需要城市等级">
            <el-input
              v-model="itemTemplate.RequiredCityRank"
              placeholder="RequiredCityRank"
            ></el-input>
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
            <el-input
              v-model="itemTemplate.Map"
              placeholder="PageText"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="可用区域">
            <el-input v-model="itemTemplate.area" placeholder="area"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="节日ID">
            <el-input
              v-model="itemTemplate.HolidayId"
              placeholder="HolidayId"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="锁ID">
            <el-input
              v-model="itemTemplate.lockid"
              placeholder="lockid"
            ></el-input>
          </el-form-item>
        </el-col>
      </el-row>
    </el-card>
    <el-card style="margin-top: 16px">
      <el-row :gutter="16">
        <el-col :span="6">
          <el-form-item label="页面ID">
            <el-input
              v-model="itemTemplate.PageText"
              placeholder="PageText"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="页面材料">
            <el-input
              v-model="itemTemplate.PageMaterial"
              placeholder="PageMaterial"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="语言ID">
            <el-input
              v-model="itemTemplate.LanguageID"
              placeholder="LanguageID"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="脚本">
            <el-input
              v-model="itemTemplate.ScriptName"
              placeholder="ScriptName"
            ></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="6">
          <el-form-item label="VerifiedBuild">
            <el-input
              v-model="itemTemplate.VerifiedBuild"
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
  localeClasses,
  localeSubclasses,
  localeInventoryTypes,
  localeQualities,
  soundOverrideSubclassTooltip,
  materialTooltip,
  localeMaterials,
  localeStatTypes,
  bondings,
  foodTypes,
  bagFamilies,
  sheaths,
  flags,
  flagsExtra,
  flagsCustom,
  scalingStatValues,
} from "@/locales/item.js";

import ItemTemplateLocalizer from "@/views/Item/components/ItemTemplateLocalizer";
import FlagEditor from "@/components/FlagEditor";
import HintLabel from "@/components/HintLabel";
import SpellSelector from "@/components/SpellSelector";
import ScalingStatDistributionSelector from "@/components/ScalingStatDistributionSelector.vue";
import ItemSetSelector from "@/components/ItemSetSelector.vue";
import ItemRandomPropertiesSelector from "@/components/ItemRandomPropertiesSelector.vue";

import { mapState, mapActions } from "vuex";

export default {
  data() {
    return {
      initing: false,
      loading: false,
      creating: false,
      localeClasses: localeClasses,
      localeSubclasses: localeSubclasses,
      localeInventoryTypes: localeInventoryTypes,
      localeQualities: localeQualities,
      soundOverrideSubclassTooltip: soundOverrideSubclassTooltip,
      materialTooltip: materialTooltip,
      localeMaterials: localeMaterials,
      localeStatTypes: localeStatTypes,
      bondings: bondings,
      foodTypes: foodTypes,
      bagFamilies: bagFamilies,
      sheaths: sheaths,
      flags: flags,
      flagsExtra: flagsExtra,
      flagsCustom: flagsCustom,
      scalingStatValues: scalingStatValues,
    };
  },
  computed: {
    ...mapState("itemTemplate", ["itemTemplate"]),
    ...mapState("itemTemplateLocale", ["itemTemplateLocales"]),
    credential() {
      return {
        entry: this.$route.params.id,
      };
    },
  },
  methods: {
    ...mapActions("itemTemplate", [
      "storeItemTemplate",
      "findItemTemplate",
      "updateItemTemplate",
      "createItemTemplate",
    ]),
    ...mapActions("itemTemplateLocale", ["searchItemTemplateLocales"]),
    async store() {
      this.loading = true;
      if (this.creating) {
        await this.storeItemTemplate(this.itemTemplate);
        this.$notify({
          title: "保存成功",
          position: "bottom-left",
          type: "success",
        });
        this.creating = false;
      } else {
        await this.updateItemTemplate({
          credential: this.credential,
          itemTemplate: this.itemTemplate,
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
      if (this.$route.path == "/item/create") {
        this.creating = true;
        await Promise.all([
          this.createItemTemplate(),
          this.searchItemTemplateLocales({ ID: 0 }),
        ]);
      } else {
        await this.findItemTemplate(this.credential);
        await this.searchItemTemplateLocales({ ID: this.itemTemplate.entry });
      }
      this.initing = false;
    },
  },
  mounted() {
    this.init();
  },
  components: {
    ItemTemplateLocalizer,
    FlagEditor,
    HintLabel,
    SpellSelector,
    ScalingStatDistributionSelector,
    ItemSetSelector,
    ItemRandomPropertiesSelector,
  },
};
</script>
