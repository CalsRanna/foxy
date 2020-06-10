const Sequelize = require("sequelize");

const sequelize = new Sequelize(
  "mysql://root:password@10.0.0.13:3306/acore_world"
);

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

class NpcVendor extends Sequelize.Model {}

NpcVendor.init({
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
});

CreatureTemplate.hasMany(CreatureTemplateLocale, {
  foreignKey: "entry",
  sourceKey: "entry",
});
CreatureTemplateLocale.belongsTo(CreatureTemplate, {
  foreignKey: "entry",
  targetKey: "entry",
});

export { CreatureTemplate, CreatureTemplateLocale, sequelize };
