import Sequelize from "sequelize";
import { sequelize } from "./sequelize.js";

class ItemTemplate extends Sequelize.Model {}

ItemTemplate.init(
  {
    entry: {
      type: Sequelize.MEDIUMINT,
      primaryKey: true,
      allowNull: false,
      defaultValue: 0,
    },
    class: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    subclass: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    SoundOverrideSubclass: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: -1,
    },
    name: { type: Sequelize.CHAR, allowNull: false, defaultValue: "" },
    displayid: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    Quality: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    Flags: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 0 },
    FlagsExtra: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 0 },
    BuyCount: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 1 },
    BuyPrice: { type: Sequelize.BIGINT, allowNull: false, defaultValue: 0 },
    SellPrice: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 0 },
    InventoryType: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    AllowableClass: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: -1,
    },
    AllowableRace: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: -1,
    },
    ItemLevel: { type: Sequelize.SMALLINT, allowNull: false, defaultValue: 0 },
    RequiredLevel: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    RequiredSkill: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    RequiredSkillRank: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    requiredspell: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      defaultValue: 0,
    },
    requiredhonorrank: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      defaultValue: 0,
    },
    RequiredCityRank: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      defaultValue: 0,
    },
    RequiredReputationFaction: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    RequiredReputationRank: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    maxcount: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 0 },
    stackable: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 1 },
    ContainerSlots: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    StatsCount: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    stat_type1: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    stat_value1: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    stat_type2: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    stat_value2: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    stat_type3: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    stat_value3: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    stat_type4: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    stat_value4: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    stat_type5: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    stat_value5: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    stat_type6: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    stat_value6: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    stat_type7: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    stat_value7: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    stat_type8: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    stat_value8: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    stat_type9: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    stat_value9: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    stat_type10: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    stat_value10: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    ScalingStatDistribution: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    ScalingStatValue: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: 0,
    },
    dmg_min1: { type: Sequelize.FLOAT, allowNull: false, defaultValue: 0 },
    dmg_max1: { type: Sequelize.FLOAT, allowNull: false, defaultValue: 0 },
    dmg_type1: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    dmg_min2: { type: Sequelize.FLOAT, allowNull: false, defaultValue: 0 },
    dmg_max2: { type: Sequelize.FLOAT, allowNull: false, defaultValue: 0 },
    dmg_type2: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    armor: { type: Sequelize.SMALLINT, allowNull: false, defaultValue: 0 },
    holy_res: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    fire_res: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    nature_res: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    frost_res: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    shadow_res: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    arcane_res: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    delay: { type: Sequelize.SMALLINT, allowNull: false, defaultValue: 1000 },
    ammo_type: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    RangedModRange: {
      type: Sequelize.FLOAT,
      allowNull: false,
      defaultValue: 0,
    },
    spellid_1: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    spelltrigger_1: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    spellcharges_1: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    spellppmRate_1: {
      type: Sequelize.FLOAT,
      allowNull: false,
      defaultValue: 0,
    },
    spellcooldown_1: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: -1,
    },
    spellcategory_1: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    spellcategorycooldown_1: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: -1,
    },
    spellid_2: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    spelltrigger_2: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    spellcharges_2: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    spellppmRate_2: {
      type: Sequelize.FLOAT,
      allowNull: false,
      defaultValue: 0,
    },
    spellcooldown_2: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: -1,
    },
    spellcategory_2: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    spellcategorycooldown_2: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: -1,
    },
    spellid_3: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    spelltrigger_3: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    spellcharges_3: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    spellppmRate_3: {
      type: Sequelize.FLOAT,
      allowNull: false,
      defaultValue: 0,
    },
    spellcooldown_3: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: -1,
    },
    spellcategory_3: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    spellcategorycooldown_3: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: -1,
    },
    spellid_4: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    spelltrigger_4: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    spellcharges_4: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    spellppmRate_4: {
      type: Sequelize.FLOAT,
      allowNull: false,
      defaultValue: 0,
    },
    spellcooldown_4: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: -1,
    },
    spellcategory_4: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    spellcategorycooldown_4: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: -1,
    },
    spellid_5: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    spelltrigger_5: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    spellcharges_5: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    spellppmRate_5: {
      type: Sequelize.FLOAT,
      allowNull: false,
      defaultValue: 0,
    },
    spellcooldown_5: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: -1,
    },
    spellcategory_5: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    spellcategorycooldown_5: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: -1,
    },
    bonding: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    description: { type: Sequelize.CHAR, allowNull: false, defaultValue: "" },
    PageText: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    LanguageID: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    PageMaterial: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    startquest: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      defaultValue: 0,
    },
    lockid: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    Material: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    sheath: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    RandomProperty: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      defaultValue: 0,
    },
    RandomSuffix: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      defaultValue: 0,
    },
    block: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    itemset: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    MaxDurability: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    area: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    Map: { type: Sequelize.SMALLINT, allowNull: false, defaultValue: 0 },
    BagFamily: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    TotemCategory: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      defaultValue: 0,
    },
    socketColor_1: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    socketContent_1: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      defaultValue: 0,
    },
    socketColor_2: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    socketContent_2: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      defaultValue: 0,
    },
    socketColor_3: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    socketContent_3: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      defaultValue: 0,
    },
    socketBonus: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      defaultValue: 0,
    },
    GemProperties: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      defaultValue: 0,
    },
    RequiredDisenchantSkill: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: -1,
    },
    ArmorDamageModifier: {
      type: Sequelize.FLOAT,
      allowNull: false,
      defaultValue: 0,
    },
    duration: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 0 },
    ItemLimitCategory: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    HolidayId: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 0 },
    ScriptName: { type: Sequelize.CHAR, allowNull: false, defaultValue: "" },
    DisenchantID: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      defaultValue: 0,
    },
    FoodType: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    minMoneyLoot: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: 0,
    },
    maxMoneyLoot: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: 0,
    },
    flagsCustom: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 0 },
    VerifiedBuild: { type: Sequelize.SMALLINT, defaultValue: 0 },
  },
  { sequelize, tableName: "item_template", timestamps: false }
);

class ItemTemplateLocale extends Sequelize.Model {}

ItemTemplateLocale.init(
  {
    ID: {
      type: Sequelize.MEDIUMINT,
      primaryKey: true,
      allowNull: false,
      defaultValue: 0,
    },
    locale: {
      type: Sequelize.CHAR,
      primaryKey: true,
      allowNull: false,
      defaultValue: 0,
    },
    Name: { type: Sequelize.TEXT, defaultValue: "" },
    Description: { type: Sequelize.TEXT, defaultValue: "" },
    VerifiedBuild: { type: Sequelize.SMALLINT, defaultValue: 0 },
  },
  { sequelize, tableName: "item_template_locale", timestamps: false }
);

ItemTemplate.hasMany(ItemTemplateLocale, {
  foreignKey: "ID",
  sourceKey: "entry",
});
ItemTemplateLocale.belongsTo(ItemTemplate, {
  foreignKey: "ID",
  targetKey: "entry",
});

export { ItemTemplate, ItemTemplateLocale };
