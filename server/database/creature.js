import Sequelize from "sequelize";
import { sequelize } from "./sequelize.js";

class CreatureTemplate extends Sequelize.Model {}

CreatureTemplate.init(
  {
    entry: { type: Sequelize.MEDIUMINT, allowNull: false, primaryKey: true },
    difficulty_entry_1: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      defaultValue: 0,
    },
    difficulty_entry_2: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      defaultValue: 0,
    },
    difficulty_entry_3: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      defaultValue: 0,
    },
    KillCredit1: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 0 },
    KillCredit2: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 0 },
    modelid1: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    modelid2: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    modelid3: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    modelid4: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    name: { type: Sequelize.CHAR, allowNull: false, defaultValue: 0 },
    subname: { type: Sequelize.CHAR },
    IconName: { type: Sequelize.CHAR },
    gossip_menu_id: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      defaultValue: 0,
    },
    minlevel: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 1 },
    maxlevel: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 1 },
    exp: { type: Sequelize.SMALLINT, allowNull: false, defaultValue: 0 },
    faction: { type: Sequelize.SMALLINT, allowNull: false, defaultValue: 0 },
    npcflag: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 0 },
    speed_walk: { type: Sequelize.FLOAT, allowNull: false, defaultValue: 1 },
    speed_run: {
      type: Sequelize.FLOAT,
      allowNull: false,
      defaultValue: 1.14286,
    },
    scale: { type: Sequelize.FLOAT, allowNull: false, defaultValue: 1 },
    rank: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    mindmg: { type: Sequelize.FLOAT, allowNull: false, defaultValue: 0 },
    maxdmg: { type: Sequelize.FLOAT, allowNull: false, defaultValue: 0 },
    dmgschool: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    attackpower: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 0 },
    DamageModifier: {
      type: Sequelize.FLOAT,
      allowNull: false,
      defaultValue: 1,
    },
    BaseAttackTime: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: 0,
    },
    RangeAttackTime: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: 0,
    },
    unit_class: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    unit_flags: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 0 },
    unit_flags2: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 0 },
    dynamicflags: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: 0,
    },
    family: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    trainer_type: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    trainer_spell: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      defaultValue: 0,
    },
    trainer_class: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    trainer_race: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    minrangedmg: { type: Sequelize.FLOAT, allowNull: false, defaultValue: 0 },
    maxrangedmg: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    rangedattackpower: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    type: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    type_flags: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 0 },
    lootid: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    pickpocketloot: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      defaultValue: 0,
    },
    skinloot: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    resistance1: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    resistance2: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    resistance3: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    resistance4: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    resistance5: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    resistance6: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    spell1: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    spell2: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    spell3: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    spell4: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    spell5: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    spell6: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    spell7: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    spell8: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    PetSpellDataId: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      defaultValue: 0,
    },
    VehicleId: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    mingold: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    maxgold: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    AIName: { type: Sequelize.CHAR, allowNull: false, defaultValue: "" },
    MovementType: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    InhabitType: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 3 },
    HoverHeight: { type: Sequelize.FLOAT, allowNull: false, defaultValue: 1 },
    HealthModifier: {
      type: Sequelize.FLOAT,
      allowNull: false,
      defaultValue: 1,
    },
    ManaModifier: { type: Sequelize.FLOAT, allowNull: false, defaultValue: 1 },
    ArmorModifier: { type: Sequelize.FLOAT, allowNull: false, defaultValue: 1 },
    RacialLeader: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    movementId: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 0 },
    RegenHealth: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 1 },
    mechanic_immune_mask: {
      type: Sequelize.INTEGER,
      allowNull: false,
      defaultValue: 0,
    },
    flags_extra: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 0 },
    ScriptName: { type: Sequelize.CHAR, allowNull: false, defaultValue: "" },
    VerifiedBuild: { type: Sequelize.SMALLINT, defaultValue: 0 },
  },
  { sequelize, tableName: "creature_template", timestamps: false }
);

class CreatureTemplateLocale extends Sequelize.Model {}

CreatureTemplateLocale.init(
  {
    entry: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      primaryKey: true,
      defaultValue: 0,
    },
    locale: {
      type: Sequelize.CHAR,
      allowNull: false,
      primaryKey: true,
      defaultValue: "",
    },
    Name: { type: Sequelize.STRING, defaultValue: "" },
    Title: { type: Sequelize.STRING, defaultValue: "" },
    VerifiedBuild: { type: Sequelize.SMALLINT, defaultValue: 0 },
  },
  { sequelize, tableName: "creature_template_locale", timestamps: false }
);

class CreatureTemplateAddon extends Sequelize.Model {}

CreatureTemplateAddon.init(
  {
    entry: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      primaryKey: true,
      defaultValue: 0,
    },
    path_id: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 0 },
    mount: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    bytes1: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 0 },
    bytes2: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 0 },
    emote: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    isLarge: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    auras: { type: Sequelize.STRING, defaultValue: "" },
  },
  { sequelize, tableName: "creature_template_addon", timestamps: false }
);

class CreatureLootTemplate extends Sequelize.Model {}

CreatureLootTemplate.init(
  {
    Entry: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      primaryKey: true,
      defaultValue: 0,
    },
    Item: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      primaryKey: true,
      defaultValue: 0,
    },
    Reference: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    Chance: { type: Sequelize.FLOAT, allowNull: false, defaultValue: 100 },
    QuestRequired: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    LootMode: { type: Sequelize.SMALLINT, allowNull: false, defaultValue: 1 },
    GroupId: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 1 },
    MinCount: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 1 },
    MaxCount: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    Comment: { type: Sequelize.MEDIUMINT, defaultValue: null },
  },
  { sequelize, tableName: "creature_loot_template", timestamps: false }
);

class CreatureOnKillReputation extends Sequelize.Model {}

CreatureOnKillReputation.init(
  {
    creature_id: {
      type: Sequelize.MEDIUMINT,
      primaryKey: true,
      allowNull: false,
      defaultValue: 0,
    },
    RewOnKillRepFaction1: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    RewOnKillRepFaction2: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    RewOnKillRepValue1: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    RewOnKillRepValue2: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    MaxStanding1: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      defaultValue: 0,
    },
    MaxStanding2: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    IsTeamAward1: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
    IsTeamAward2: {
      type: Sequelize.MEDIUMINT,
      allowNull: false,
      defaultValue: 0,
    },
    TeamDependent: {
      type: Sequelize.TINYINT,
      allowNull: false,
      defaultValue: 0,
    },
  },
  { sequelize, tableName: "creature_onkill_reputation", timestamps: false }
);

class CreatureEquipTemplate extends Sequelize.Model {}

CreatureEquipTemplate.init(
  {
    CreatureID: {
      type: Sequelize.MEDIUMINT,
      primaryKey: true,
      allowNull: false,
      defaultValue: 0,
    },
    ID: {
      type: Sequelize.TINYINT,
      primaryKey: true,
      allowNull: false,
      defaultValue: 1,
    },
    ItemID1: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    ItemID2: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    ItemID3: { type: Sequelize.MEDIUMINT, allowNull: false, defaultValue: 0 },
    VerifiedBuild: { type: Sequelize.SMALLINT, defaultValue: 0 },
  },
  { sequelize, tableName: "creature_equip_template", timestamps: false }
);

class CreatureQuestItem extends Sequelize.Model {}

CreatureQuestItem.init(
  {
    CreatureEntry: {
      type: Sequelize.INTEGER,
      primaryKey: true,
      allowNull: false,
      defaultValue: 0,
    },
    Idx: {
      type: Sequelize.INTEGER,
      primaryKey: true,
      allowNull: false,
      defaultValue: 0,
    },
    ItemId: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 0 },
    VerifiedBuild: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
  },
  { sequelize, tableName: "creature_questitem", timestamps: false }
);

class NpcVendor extends Sequelize.Model {}

NpcVendor.init(
  {
    entry: {
      type: Sequelize.MEDIUMINT,
      primaryKey: true,
      allowNull: false,
      defaultValue: 0,
    },
    slot: { type: Sequelize.SMALLINT, allowNull: false, defaultValue: 0 },
    item: {
      type: Sequelize.MEDIUMINT,
      primaryKey: true,
      allowNull: false,
      defaultValue: 0,
    },
    maxcount: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
    incrtime: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 0 },
    ExtendedCost: {
      type: Sequelize.MEDIUMINT,
      primaryKey: true,
      allowNull: false,
      defaultValue: 0,
    },
    VerifiedBuild: { type: Sequelize.SMALLINT, defaultValue: 0 },
  },
  { sequelize, tableName: "npc_vendor", timestamps: false }
);

class NpcTrainer extends Sequelize.Model {}

NpcTrainer.init(
  {
    ID: {
      type: Sequelize.MEDIUMINT,
      primaryKey: true,
      allowNull: false,
      defaultValue: 0,
    },
    SpellID: {
      type: Sequelize.MEDIUMINT,
      primaryKey: true,
      allowNull: false,
      defaultValue: 0,
    },
    MoneyCost: { type: Sequelize.INTEGER, allowNull: false, defaultValue: 0 },
    ReqSkillLine: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    ReqSkillRank: {
      type: Sequelize.SMALLINT,
      allowNull: false,
      defaultValue: 0,
    },
    ReqLevel: { type: Sequelize.TINYINT, allowNull: false, defaultValue: 0 },
  },
  { sequelize, tableName: "npc_trainer", timestamps: false }
);

CreatureTemplate.hasMany(CreatureTemplateLocale, {
  foreignKey: "entry",
  sourceKey: "entry",
});
CreatureTemplateLocale.belongsTo(CreatureTemplate, {
  foreignKey: "entry",
  targetKey: "entry",
});

export {
  CreatureTemplate,
  CreatureTemplateLocale,
  CreatureTemplateAddon,
  CreatureOnKillReputation,
  CreatureEquipTemplate,
  CreatureLootTemplate,
  CreatureQuestItem,
  NpcVendor,
  NpcTrainer,
};
