const rankTooltip = `
  The rank of the creature:
  Note 1: An NPC's rank is mostly visual (which also requires your Cache to be cleared to see changes).
  Changing this value will not change its health, damage, or loot. However, it will change the respawn
  time of the creature.
  Note 2: Respawn times can be modified in two other places: Creature.spawntimesecs (only for that
  single GUID of the creature) and in the worldserver.conf file under the "Corpse.Decay" settings (for
  ALL creatures of the same rank). The default 'spawntimesecs' for all spawned creatures is 300 seconds
  (5 minutes). For example, using the ".npc add" command to spawn a "Normal" NPC will give it a default
  respawn time of 6 minutes (spawntimesecs + Corpse.Decay time). Also, the creature must decay first
  before it can respawn. For this reason, the Corpse Decay Time of the creature is also it's minimum
  respawn time, since setting the creature's Creature.spawntimesecs = 0 will remove the Default Respawn
  Time. In the example above, setting our Normal NPC's spawntimesecs = 0 will mean the creature's
  respawn time decreases from 6 minutes to 60 seconds.
  Note 3: If you want the creature to show a skull or "??" in the portrait (often with Bosses), set the
  type_flags to 4.
`;

const ranks = ["普通", "精英", "稀有", "稀有精英", "首领"];

const expTooltip = `exp，可选值为0-2，详见 creature_classlevelstats.`;

const exps = ["经典旧世", "燃烧的远征", "巫妖王之怒"];

const unitClassTooltip = `
  This is the creature's class, and it dictates levels of health and mana. Also note that health and
  mana will change according to exp, HealthModifier, and ManaModifier. Not setting this value will
  report a minor warning in the "DB_Errors.log".
`;

const unitClasses = ["战士", "圣骑士", "盗贼", "法师"];

const families = [
  "无",
  "狼",
  "豹",
  "蜘蛛",
  "熊",
  "野猪",
  "鳄鱼",
  "食腐鸟",
  "螃蟹",
  "猩猩",
  "未知",
  "迅猛龙",
  "陆行鸟",
  "未知",
  "未知",
  "地狱犬",
  "虚空行者",
  "魅魔",
  "未知",
  "末日守卫",
  "蝎子",
  "海龟",
  "未知",
  "小鬼",
  "蝙蝠",
  "鬣狗",
  "枭兽",
  "风蛇",
  "遥控装置",
  "恶魔卫士",
  "龙鹰",
  "劫掠者",
  "Warp Stalker",
  "孢子蝠",
  "虚空鳐",
  "毒蛇",
  "飞蛾",
  "奇美拉",
  "魔暴龙",
  "食尸鬼",
  "异种蝎",
  "蠕虫",
  "犀牛",
  "黄蜂",
  "熔岩犬",
  "灵魂兽",
];

const types = [
  "无",
  "野兽",
  "龙人",
  "恶魔",
  "元素生物",
  "巨人",
  "亡灵",
  "人形生物",
  "生物",
  "机械",
  "Not specified",
  "图腾",
  "小宠物",
  "Gas Cloud",
];

const npcFlagTooltip = `
  A bitmask that represents what NPC flags the creature has. Each bit controls a different flag and to
  combine flags, you can add each flag that you want, in effect activating the respective bits.
`;

const npcFlags = [
  {
    index: 0,
    flag: 1,
    name: "可对话",
    comment:
      "If creature has more gossip options, add this flag to bring up a menu.",
  },
  {
    index: 1,
    flag: 2,
    name: "交接任务",
    comment: "Any creature giving or taking quests needs to have this flag.",
  },
  {
    index: 2,
    flag: 4,
    name: "未知",
    comment: "未知",
  },
  {
    index: 3,
    flag: 8,
    name: "未知",
    comment: "未知",
  },
  {
    index: 4,
    flag: 16,
    name: "技能训练师",
    comment: "Allows the creature to have a trainer list to teach spells.",
  },
  {
    index: 5,
    flag: 32,
    name: "职业训练师",
    comment: "职业训练师",
  },
  {
    index: 6,
    flag: 64,
    name: "专业训练师",
    comment: "专业训练师",
  },
  {
    index: 7,
    flag: 128,
    name: "商人",
    comment: "Any creature selling items needs to have this flag.",
  },
  {
    index: 8,
    flag: 256,
    name: "护甲商人",
    comment: "护甲商人",
  },
  {
    index: 9,
    flag: 512,
    name: "食物商人",
    comment: "食物商人",
  },
  {
    index: 10,
    flag: 1024,
    name: "毒药商人",
    comment: "毒药商人",
  },
  {
    index: 11,
    flag: 2048,
    name: "药剂商人",
    comment: "药剂商人",
  },
  {
    index: 12,
    flag: 4096,
    name: "修理商",
    comment: "Creatures with this flag can repair items.",
  },
  {
    index: 13,
    flag: 8192,
    name: "飞行师",
    comment: "Any creature serving as flight master has this.",
  },
  {
    index: 14,
    flag: 16384,
    name: "灵魂医者",
    comment:
      "Makes the creature invisible to alive characters and has the resurrect function.",
  },
  {
    index: 15,
    flag: 32768,
    name: "灵魂使者",
    comment: "灵魂使者",
  },
  {
    index: 16,
    flag: 65536,
    name: "旅馆老板",
    comment: "Creatures with this flag can set hearthstone locations.",
  },
  {
    index: 17,
    flag: 131072,
    name: "银行职员",
    comment: "Creatures with this flag can show the bank",
  },
  {
    index: 18,
    flag: 262144,
    name: "兽栏管理员",
    comment: "兽栏管理员",
  },
  {
    index: 19,
    flag: 524288,
    name: "徽章设计师",
    comment: "Allows the designing of guild tabards.",
  },
  {
    index: 20,
    flag: 1048576,
    name: "战场军官",
    comment: "Creatures with this flag port players to battlegrounds.",
  },
  {
    index: 21,
    flag: 2097152,
    name: "拍卖师",
    comment: "Allows creature to display auction list.",
  },
  {
    index: 22,
    flag: 4194304,
    name: "宠物训练师",
    comment: "Has the option to stable pets for hunters.",
  },
  {
    index: 23,
    flag: 8388608,
    name: "工会银行",
    comment: "工会银行",
  },
  {
    index: 24,
    flag: 16777216,
    name: "Spellclick",
    comment: "Needs data on npc_spellclick_spells table.",
  },
  {
    index: 25,
    flag: 33554432,
    name: "Player vehicle",
    comment: "Players with mounts that have vehicle data should have it set.",
  },
  {
    index: 26,
    flag: 67108864,
    name: "邮箱",
    comment: "NPC will act like a mailbox (opens mailbox with right-click).",
  },
];

const typeFlagsTooltip = `
  This field can control whether a mob is minable or herbable or lootable by engineer. If it is either
  of those three, then the loot given when it is skinned/mined will be stored in the
  skinning_loot_template table. It also controls, whether this mob can be tamed by a hunter. Other
  fields have no special meaning on the serverside. The entire field will be send to the client in
  SMSG_CREATURE_QUERY_RESPONSE
`;

const typeFlags = [
  {
    index: 0,
    flag: 1,
    name: "可控制",
    comment:
      "Makes the mob tameable (must also be a beast and have family set).",
  },
  {
    index: 1,
    flag: 2,
    name: "鬼魂",
    comment:
      "Creature are also visible for not alive player. Allow gossip interaction if npcflag allow?",
  },
  {
    index: 2,
    flag: 4,
    name: "BOSS",
    comment:
      "Changes creature's visible level to  '??' in the creature's portrait - Immune to Knockback.",
  },
  {
    index: 3,
    flag: 8,
    name: "不播放受伤动画",
    comment: "Does not play wound animation on parry.",
  },
  {
    index: 4,
    flag: 16,
    name: "隐藏阵营提示",
    comment: "Hides tooltip faction.",
  },
  {
    index: 5,
    flag: 32,
    name: "未知",
    comment: "未知",
  },
  {
    index: 6,
    flag: 64,
    name: "可法术攻击",
    comment: "Spell attackable.",
  },
  {
    index: 7,
    flag: 128,
    name: "死亡后可互动",
    comment:
      "Player can interact with the creature if its dead (not player dead).",
  },
  {
    index: 8,
    flag: 256,
    name: "可采草药",
    comment: "Makes mob herbable.",
  },
  {
    index: 9,
    flag: 512,
    name: "可采矿",
    comment: "Makes mob minable.",
  },
  {
    index: 10,
    flag: 1024,
    name: "没有死亡战斗记录",
    comment: "Does not combatlog death.",
  },
  {
    index: 11,
    flag: 2048,
    name: "战斗保持骑乘",
    comment: "Creature can remain mounted when entering combat.",
  },
  {
    index: 12,
    flag: 4096,
    name: "可以玩家为目标",
    comment: "Can aid any player in combat if in range?",
  },
  {
    index: 13,
    flag: 8192,
    name: "有宠物条",
    comment: "Is using pet bar.",
  },
  {
    index: 14,
    flag: 16384,
    name: "隐藏UID",
    comment: "隐藏UID",
  },
  {
    index: 15,
    flag: 32768,
    name: "工程学掉落",
    comment: "Makes mob lootable by engineer.",
  },
  {
    index: 16,
    flag: 65536,
    name: "可控制为奇异宠物",
    comment: "Tamable as an exotic pet. Normal tamable flag must also be set.",
  },
  {
    index: 17,
    flag: 131072,
    name: "默认碰撞盒子",
    comment: "Collision related. (always using default collision box?)",
  },
  {
    index: 18,
    flag: 262144,
    name: "围攻武器",
    comment: "Is siege weapon.",
  },
  {
    index: 19,
    flag: 524288,
    name: "可与弹药碰撞",
    comment:
      "Projectiles can collide with this creature - interacts with TARGET_DEST_TRAJ.",
  },
  {
    index: 20,
    flag: 1048576,
    name: "隐藏姓名版",
    comment: "Hides nameplate.",
  },
  {
    index: 21,
    flag: 2097152,
    name: "不播放骑乘动画",
    comment: "Does not play mounted animations.",
  },
  {
    index: 22,
    flag: 4194304,
    name: "关联所有",
    comment: "关联所有",
  },
  {
    index: 23,
    flag: 8388608,
    name: "只与创建者互动",
    comment: "Can only interact with its creator.",
  },
  {
    index: 24,
    flag: 16777216,
    name: "未知",
    comment: "Do not paly unit event sounds.",
  },
  {
    index: 25,
    flag: 33554432,
    name: "未知",
    comment: "Has no shadow blob.",
  },
  {
    index: 26,
    flag: 67108864,
    name: "未知",
    comment: "Treat as raid unit.",
  },
  {
    index: 27,
    flag: 134217728,
    name: "强制对话",
    comment: "Allows the creature to display a single gossip option.",
  },
  {
    index: 28,
    flag: 268435456,
    name: "未知",
    comment: "Do not sheathe.",
  },
  {
    index: 29,
    flag: 536870912,
    name: "未知",
    comment: "Do not target on interaction.",
  },
  {
    index: 30,
    flag: 1073741824,
    name: "未知",
    comment: "Do not render object name.",
  },
  {
    index: 31,
    flag: 2147483648,
    name: "未知",
    comment: "Unit is quest boss.",
  },
];

const unitFlagsTooltip = `
  Allows the manual application of unit flags to creatures. Again this is a bitmask field and to apply
  more than one flag, just add the different numbers. Some possible flags are:
`;

const unitFlags = [
  {
    index: 0,
    flag: 1,
    name: "服务端控制",
    comment: "服务端控制",
  },
  {
    index: 1,
    flag: 2,
    name: "不可攻击",
    comment: "不可攻击",
  },
  {
    index: 2,
    flag: 4,
    name: "不能移动",
    comment: "不能移动",
  },
  {
    index: 3,
    flag: 8,
    name: "可以PVP",
    comment:
      "Allows to apply PvP rules to attackable state in addition to faction dependent state.",
  },
  {
    index: 4,
    flag: 16,
    name: "改名",
    comment: "改名",
  },
  {
    index: 5,
    flag: 32,
    name: "配置",
    comment:
      "Don't take reagents for spells with SPELL_ATTR_EX5_NO_REAGENT_WHILE_PREP",
  },
  {
    index: 6,
    flag: 64,
    name: "未知",
    comment:
      "not sure what it does, but it is needed to cast nontriggered spells in smart_scripts.",
  },
  {
    index: 7,
    flag: 128,
    name: "不能PVP",
    comment: "UNIT_FLAG_PVP_ATTACKABLE.",
  },
  {
    index: 8,
    flag: 256,
    name: "不能与玩家战斗或交流",
    comment: "disables combat/assistance with PlayerCharacters (PC).",
  },
  {
    index: 9,
    flag: 512,
    name: "不能与其他生物战斗和交流",
    comment: "disables combat/assistance with NonPlayerCharacters (NPC).",
  },
  {
    index: 10,
    flag: 1024,
    name: "掉落",
    comment: "Loot animation.",
  },
  {
    index: 11,
    flag: 2048,
    name: "宠物进入战斗",
    comment: "In combat? 2.0.8",
  },
  {
    index: 12,
    flag: 4096,
    name: "PVP",
    comment: "Changed in 3.0.3",
  },
  {
    index: 13,
    flag: 8192,
    name: "不能施放法术",
    comment: "Can't cast spells.",
  },
  {
    index: 14,
    flag: 16384,
    name: "不能游泳",
    comment: "2.0.8",
  },
  {
    index: 15,
    flag: 32768,
    name: "未知",
    comment: "Only Swim ('OnlySwim' from UnitFlags.cs in WPP)",
  },
  {
    index: 16,
    flag: 65536,
    name: "未知",
    comment: "No Attack 2 ('NoAttack2' from UnitFlags.cs in WPP).",
  },
  {
    index: 17,
    flag: 131072,
    name: "不主动攻击",
    comment: "Creature will not attack.",
  },
  {
    index: 18,
    flag: 262144,
    name: "晕眩",
    comment: "3.0.3 ok.",
  },
  {
    index: 19,
    flag: 524288,
    name: "进入战斗",
    comment: "('AffectingCombat' from UnitFlags.cs in WPP).",
  },
  {
    index: 20,
    flag: 1048576,
    name: "在坐骑上飞行（不能施法）",
    comment:
      "Disable casting at client side spell not allowed by taxi flight (mounted?), probably used with 0x4 flag.",
  },
  {
    index: 21,
    flag: 2097152,
    name: "缴械",
    comment:
      "3.0.3, disable melee spells casting..., 'Required melee weapon' added to melee spells tooltip.",
  },
  {
    index: 22,
    flag: 4194304,
    name: "混乱",
    comment: "Confused.",
  },
  {
    index: 23,
    flag: 8388608,
    name: "逃跑",
    comment: "('Feared' from UnitFlags.cs in WPP).",
  },
  {
    index: 24,
    flag: 16777216,
    name: "被玩家控制",
    comment:
      "Used in spell Eyes of the Beast for pet... let attack by controlled creature. Also used by Vehicles (PCV).",
  },
  {
    index: 25,
    flag: 33554432,
    name: "不能选中",
    comment: "Can't be selected by mouse or with /target {name} command.",
  },
  {
    index: 26,
    flag: 67108864,
    name: "可剥皮",
    comment: "Skinnable.",
  },
  {
    index: 27,
    flag: 134217728,
    name: "坐骑",
    comment:
      "The client seems to handle it perfectly. Also used when making custom mounts.",
  },
  {
    index: 28,
    flag: 268435456,
    name: "未知",
    comment: "(PreventKneelingWhenLooting from UnitFlags.cs in WPP).",
  },
  {
    index: 29,
    flag: 536870912,
    name: "假装死亡或者做出死亡的动作",
    comment:
      "Used in Feign Death spell or NPC will play dead. (PreventEmotes).",
  },
  {
    index: 30,
    flag: 1073741824,
    name: "武器入鞘",
    comment: "武器入鞘",
  },
  {
    index: 31,
    flag: 2147483648,
    name: "未知",
    comment: "未知",
  },
];

const unitFlags2Tooltip = `
  Allows additional application of unit flags to creatures. Again, this is a bitmask field and to apply
  more than one flag, just add the different numbers. Some possible flags are:
`;

const unitFlags2 = [
  {
    index: 0,
    flag: 1,
    name: "假装死亡",
    comment: "假装死亡",
  },
  {
    index: 1,
    flag: 2,
    name: "主体隐形，只显示装备",
    comment: "Hide unit model (show only player equip).",
  },
  {
    index: 2,
    flag: 4,
    name: "忽略声望",
    comment: "忽略声望",
  },
  {
    index: 3,
    flag: 8,
    name: "了解语言",
    comment: "了解语言",
  },
  {
    index: 4,
    flag: 16,
    name: "镜像",
    comment: "镜像",
  },
  {
    index: 5,
    flag: 32,
    name: "INSTANTLY_APPEAR_MODEL",
    comment: "Unit model instantly appears when summoned (does not fade in).",
  },
  {
    index: 6,
    flag: 64,
    name: "强制移动",
    comment: "强制移动",
  },
  {
    index: 7,
    flag: 128,
    name: "不装备手",
    comment: "不装备手",
  },
  {
    index: 8,
    flag: 256,
    name: "DISABLE_PRED_STATS",
    comment: "Player has disabled predicted stats (Used by raid frames).",
  },
  {
    index: 9,
    flag: 512,
    name: "未知",
    comment: "未知",
  },
  {
    index: 10,
    flag: 1024,
    name: "不装备远程武器",
    comment:
      "this does not disable ranged weapon display (maybe additional flag needed?).",
  },
  {
    index: 11,
    flag: 2048,
    name: "再生能力",
    comment: "In combat? 2.0.8",
  },
  {
    index: 12,
    flag: 4096,
    name: "RESTRICT_PARTY_INTERACT",
    comment: "Restrict interaction to party or raid.",
  },
  {
    index: 13,
    flag: 8192,
    name: "PREVENT_SPELL_CLICK",
    comment: "Prevent spellclick.",
  },
  {
    index: 14,
    flag: 16384,
    name: "跟敌人互动",
    comment: "跟敌人互动",
  },
  {
    index: 15,
    flag: 32768,
    name: "DISABLE_TURN",
    comment: "DISABLE_TURN",
  },
  {
    index: 16,
    flag: 65536,
    name: "未知",
    comment: "未知",
  },
  {
    index: 17,
    flag: 131072,
    name: "允许法术作弊",
    comment: "Plays special death animation upon death.",
  },
  {
    index: 18,
    flag: 262144,
    name: "ALLOW_CHEAT_SPELLS",
    comment:
      "Allows casting spells with AttributesEx7 & SPELL_ATTR7_IS_CHEAT_SPELL.",
  },
];

const dynamicFlagsTooltip = `
  Flags that control visual appearance of the creature. A few known flags and their use are:
`;

const dynamicFlags = [
  {
    index: 0,
    flag: 1,
    name: "可掉落",
    comment: "可掉落",
  },
  {
    index: 1,
    flag: 2,
    name: "小地图显示",
    comment: "Creature's location will be seen as a small dot in the minimap.",
  },
  {
    index: 2,
    flag: 4,
    name: "名字变灰",
    comment: "Makes creatures name appear grey (Lua_UnitIsTapped)",
  },
  {
    index: 3,
    flag: 8,
    name: "被玩家控制",
    comment:
      "Lua_UnitIsTappedByPlayer usually used by PCVs (Player Controlled Vehicles).",
  },
  {
    index: 4,
    flag: 16,
    name: "特殊信息",
    comment: "特殊信息",
  },
  {
    index: 5,
    flag: 32,
    name: "看起来死亡",
    comment:
      "Makes the creature appear dead (this DOES NOT make the creature's name grey or not attack players).",
  },
  {
    index: 6,
    flag: 64,
    name: "求教伙伴",
    comment: "求教伙伴",
  },
  {
    index: 7,
    flag: 128,
    name: "TAPPED_BY_ALL_THREAT_LIST",
    comment: "Lua_UnitIsTappedByAllThreatList.",
  },
];

const flagsExtraTooltip = `
  These flags control certain creature specific attributes. Flags can be added together to apply more
  than one.
`;

const flagsExtra = [
  {
    index: 0,
    flag: 1,
    name: "副本生物",
    comment: "creature kill binds instance to killer and killer's group",
  },
  {
    index: 1,
    flag: 2,
    name: "不产生仇恨",
    comment: "creature does not aggro (ignore faction/reputation hostility)",
  },
  {
    index: 2,
    flag: 4,
    name: "不躲避",
    comment: "creature does not parry",
  },
  {
    index: 3,
    flag: 8,
    name: "不反击",
    comment: "creature does not counter-attack at parry.",
  },
  {
    index: 4,
    flag: 16,
    name: "不格挡",
    comment: "creature does not block",
  },
  {
    index: 5,
    flag: 32,
    name: "不碾压",
    comment: "creature does not do crush-attacks",
  },
  {
    index: 6,
    flag: 64,
    name: "不提供经验",
    comment: "creature kill does not give XP",
  },
  {
    index: 7,
    flag: 128,
    name: "触发器",
    comment: "creature is trigger-NPC (invisible to players only)",
  },
  {
    index: 8,
    flag: 256,
    name: "免疫嘲讽",
    comment: "creature is immune to taunt-auras and 'attack me'-effects",
  },
  {
    index: 9,
    flag: 512,
    name: "NO_MOVE_FLAGS_UPDATE",
    comment: "creature won't update movement flags.",
  },
  {
    index: 10,
    flag: 1024,
    name: "GHOST_VISIBILITY",
    comment: "creature will be only visible for dead players.",
  },
  {
    index: 11,
    flag: 2048,
    name: "USE_OFFHAND_ATTACK",
    comment: "creature will use offhand attacks",
  },
  {
    index: 12,
    flag: 4096,
    name: "NO_SELL_VENDOR",
    comment: "players can't sell items to this vendor",
  },
  {
    index: 13,
    flag: 8192,
    name: "未知",
    comment: "未知",
  },
  {
    index: 14,
    flag: 16384,
    name: "世界事件",
    comment: "custom flag for world events (left room for merging)",
  },
  {
    index: 15,
    flag: 32768,
    name: "守卫",
    comment: "creature is a guard (Will ignore feign death and vanish)",
  },
  {
    index: 16,
    flag: 65536,
    name: "未知",
    comment: "未知",
  },
  {
    index: 17,
    flag: 131072,
    name: "不暴击",
    comment: "Creature does not do critical strikes.",
  },
  {
    index: 18,
    flag: 262144,
    name: "不提高武器熟练度",
    comment: "Creature won't increase weapon skills.",
  },
  {
    index: 19,
    flag: 524288,
    name: "嘲讽递减",
    comment: "Creature taunt is subject to diminishing returns.",
  },
  {
    index: 20,
    flag: 1048576,
    name: "所有效果递减",
    comment: "Creature is subject to all diminishing returns.",
  },
  {
    index: 21,
    flag: 2097152,
    name: "NO_PLAYER_DAMAGE_REQ",
    comment:
      "NPCs can help with killing this creature and player will still be credited if he tags the creature.",
  },
  {
    index: 22,
    flag: 4194304,
    name: "AVOID_AOE",
    comment:
      "ignored by aoe attacks (for icc blood prince council npc - Dark Nucleus)",
  },
  {
    index: 23,
    flag: 8388608,
    name: "NO_DODGE ",
    comment: "target cannot dodge",
  },
  {
    index: 24,
    flag: 16777216,
    name: "未知",
    comment: "未知",
  },
  {
    index: 25,
    flag: 33554432,
    name: "未知",
    comment: "未知",
  },
  {
    index: 26,
    flag: 67108864,
    name: "未知",
    comment: "未知",
  },
  {
    index: 27,
    flag: 134217728,
    name: "未知",
    comment: "未知",
  },
  {
    index: 28,
    flag: 268435456,
    name: "地下城副本BOSS",
    comment:
      "Creature is a dungeon boss. This flag is generically set by core during runtime. Setting this in database will give you startup error.",
  },
  {
    index: 29,
    flag: 536870912,
    name: "忽略寻路",
    comment:
      "Creature will ignore pathfinding. This is like disabling Mmaps, only for one creature.",
  },
  {
    index: 30,
    flag: 1073741824,
    name: "IMMUNITY_KNOCKBACK",
    comment: "Creature will immune all knockback effects。",
  },
];

const mechanicImmuneMasksTooltip = `
  This makes the creature immune to specific spell natures. See Spell.dbc at row effect_X_mechanic_id.
  Uses references from SpellMechanic.dbc. To combine immunities just add values. Immune to everything
  corresponds to the value 2147483647 (0x3FFF FFFF).
`;

const mechanicImmuneMasks = [
  {
    index: 0,
    flag: 1,
    name: "魅惑",
    comment: "Charm",
  },
  {
    index: 1,
    flag: 2,
    name: "迷惑",
    comment: "Disoriented",
  },
  {
    index: 2,
    flag: 4,
    name: "缴械",
    comment: "Disarm",
  },
  {
    index: 3,
    flag: 8,
    name: "吸引",
    comment: "Distract",
  },
  {
    index: 4,
    flag: 16,
    name: "FEAR",
    comment: "FEAR",
  },
  {
    index: 5,
    flag: 32,
    name: "GRIP",
    comment: "Death Grip and similar effects",
  },
  {
    index: 6,
    flag: 64,
    name: "ROOT",
    comment: "creature kill does not give XP",
  },
  {
    index: 7,
    flag: 128,
    name: "SLOW_ATTACK",
    comment: "SLOW_ATTACK",
  },
  {
    index: 8,
    flag: 256,
    name: "沉默",
    comment: "SILENCE",
  },
  {
    index: 9,
    flag: 512,
    name: "沉睡",
    comment: "SLEEP",
  },
  {
    index: 10,
    flag: 1024,
    name: "诱捕",
    comment: "SNARE",
  },
  {
    index: 11,
    flag: 2048,
    name: "昏迷",
    comment: "STUN",
  },
  {
    index: 12,
    flag: 4096,
    name: "冻结",
    comment: "FREEZE",
  },
  {
    index: 13,
    flag: 8192,
    name: "KNOCKOUT",
    comment: "Incapacitate effects such as Repetance (Paladin)",
  },
  {
    index: 14,
    flag: 16384,
    name: "BLEED",
    comment: "BLEED",
  },
  {
    index: 15,
    flag: 32768,
    name: "BANDAGE",
    comment: "Healing etc.",
  },
  {
    index: 16,
    flag: 65536,
    name: "POLYMORPH",
    comment: "POLYMORPH",
  },
  {
    index: 17,
    flag: 131072,
    name: "BANISH",
    comment: "BANISH",
  },
  {
    index: 18,
    flag: 262144,
    name: "SHIELD",
    comment: "SHIELD",
  },
  {
    index: 19,
    flag: 524288,
    name: "SHACKLE",
    comment: "Shackle Undead only",
  },
  {
    index: 20,
    flag: 1048576,
    name: "MOUNT",
    comment: "Any effect that summons a mount",
  },
  {
    index: 21,
    flag: 2097152,
    name: "INFECTED",
    comment: "Frost Fever, Blood Plague etc.",
  },
  {
    index: 22,
    flag: 4194304,
    name: "TURN",
    comment: "e.g. Turn Evil",
  },
  {
    index: 23,
    flag: 8388608,
    name: "HORROR",
    comment: "e.g. Death Coil (Warlock)",
  },
  {
    index: 24,
    flag: 16777216,
    name: "INVULNERABILITY",
    comment: "Forbearance, Nether Protection, Diplomatic Immunity only",
  },
  {
    index: 25,
    flag: 33554432,
    name: "INTERRUPT",
    comment: "INTERRUPT",
  },
  {
    index: 26,
    flag: 67108864,
    name: "DAZE",
    comment: "DAZE",
  },
  {
    index: 27,
    flag: 134217728,
    name: "DISCOVERY",
    comment: "Any Create Item effect",
  },
  {
    index: 28,
    flag: 268435456,
    name: "IMMUNE_SHIELD",
    comment: "Divine Shield, Ice Block, Hand of Protection...",
  },
  {
    index: 29,
    flag: 536870912,
    name: "SAPPED",
    comment: "SAPPED",
  },
  {
    index: 30,
    flag: 1073741824,
    name: "ENRAGED",
    comment: "ENRAGED",
  },
];

const spellSchoolImmuneMasksTooltip = `
  This makes the creature immune to specific spell schools.
`;

const spellSchoolImmuneMasks = [
  {
    index: 0,
    flag: 1,
    name: "普通伤害",
    comment: "SPELL_SCHOOL_NORMAL",
  },
  {
    index: 1,
    flag: 2,
    name: "神圣伤害",
    comment: "SPELL_SCHOOL_HOLY",
  },
  {
    index: 2,
    flag: 4,
    name: "火焰伤害",
    comment: "SPELL_SCHOOL_FIRE",
  },
  {
    index: 3,
    flag: 8,
    name: "自然伤害",
    comment: "SPELL_SCHOOL_NATURE",
  },
  {
    index: 4,
    flag: 16,
    name: "冰霜伤害",
    comment: "SPELL_SCHOOL_FROST",
  },
  {
    index: 5,
    flag: 32,
    name: "暗影伤害",
    comment: "SPELL_SCHOOL_SHADOW",
  },
  {
    index: 6,
    flag: 64,
    name: "奥术伤害",
    comment: "SPELL_SCHOOL_ARCANE",
  },
];

const petSpellDataIdTooltip = `
  ID, found in CreatureSpellData.dbc, that displays what spells the pet has in the client.
`;

const vehicleIdTooltip = `
  Entry of vehicle if creature is/has a vehicle entry. This field determines how the player appears on
  the vehicle, how the vehicle moves, and whether or not the vehicle action bar is shown. For example, a
  vehicleID of 292 will make the player invisible, prevent the vehicle from strafing left/right (but
  will allow forwards/backwards), and will show the vehicle action bar spells (which are defined in
  spell1-8). An npc_spellclick_spells entry must be made for this creature entry in order for this to
  work.
`;

const dmgSchools = [
  {
    label: "物理伤害",
    value: 0,
  },
  {
    label: "神圣伤害",
    value: 1,
  },
  {
    label: "暗影伤害",
    value: 5,
  },
  {
    label: "火焰伤害",
    value: 2,
  },
  {
    label: "冰霜伤害",
    value: 4,
  },
  {
    label: "自然伤害",
    value: 3,
  },
  {
    label: "奥术伤害",
    value: 6,
  },
];

const localeResistanceSchools = [
  "",
  "神圣抗性",
  "火焰抗性",
  "自然抗性",
  "冰霜抗性",
  "暗影抗性",
  "奥术抗性",
];

const trainerTypeTooltip = `
  If the NPC is a trainer (has the trainer flag), then this field controls what kind of trainer it is.
  Both this field and the related field must be filled in for a trainer to work correctly.
`;

const trainerTypes = ["职业训练师", "骑术训练师", "专业训练师", "宠物训练师"];

const trainerSpellTooltip = `
  If the NPC is a trainer that teaches professions (trainer_type
  = 2), then the player must already know the spell ID specified
  here to be able to talk to this NPC.
`;

const trainerClassTooltip = `
  If the NPC is a trainer that teaches professions (trainer_type
  = 2), then the player must already know the spell ID specified
  here to be able to talk to this NPC.
`;

const trainerClasses = [
  "",
  "战士",
  "圣骑士",
  "猎人",
  "潜行者",
  "牧师",
  "死亡骑士",
  "萨满祭司",
  "法师",
  "术士",
  "",
  "德鲁伊",
];

const trainerRaceTooltip = `
  If the NPC is a mount trainer (trainer_type = 1), then the
  player's race must be the same as the value specified here to
  talk to this trainer. See characters.race
`;

const trainerRaces = [
  "人类",
  "兽人",
  "矮人",
  "暗夜精灵",
  "亡灵",
  "牛头人",
  "侏儒",
  "巨魔",
  "地精",
  "血精灵",
  "德莱尼",
  "邪兽人",
  "娜迦",
  "破碎者",
  "骷髅",
  "维库人",
  "海象人",
  "森林巨魔",
  "牦牛人",
  "诺森德骷髅",
  "冰巨魔",
];

const killCredit1Tooltip = `
  If this is a kill credit template -- one that is a dummy
  template that is used when more than one creature can count as
  a kill in a quest, then this is a link to the first entry of
  the creature that could be killed to give quest credit.
`;

const killCredit2Tooltip = `
  If this is a kill credit template -- one that is a dummy
  template that is used when more than one creature can count as
  a kill in a quest, then this is a link to the second entry of
  the creature that could be killed to give quest credit. If
  more than two creatures can be killed and count toward a
  single objective, an smart or C++ script will be required.
`;

const difficultyEntry1Tooltip = `
  Anomalus is a 5 man boss located in The Nexus. You can fight
  him on two types of difficulties (normal dungeon and heroic
  dungeon). Depending on the type of difficulty, bosses have
  different statistics like health and damage. In case of
  Anomalus information from entry 26763 is used when you fight
  him at normal difficulty and entry 30529 is used when you
  fight him at heroic difficulty.
  Sindragosa, a raid boss encounter located in the
  Icecrown Citadel can be fought on 4 different difficulties due
  to the introduction of heroic raid modes in Patch 3.2 (10man
  normal/heroic, 25man normal/heroic). Depending on the type of
  difficulty, she must have different statistics. So if you see
  her in 10man normal raid she will use information from entry
  36853, in a 25man normal raid entry 38265 will be used and so
  on. This is in stark contrast to raid bosses such as Patchwerk
  and XT-002 Deconstructor, located in Naxxramas and Ulduar
  respectively, who only have two different raid modes (10-man
  'normal'/25-man 'normal'). Hardmodes within the Ulduar raid do
  not have their own template, due to game mechanics engaging
  the harder difficulty during the encounter itself.
  Here is a special case with the Alterac Valley
  battleground. There are 4 level brackets where the NPCs are
  made easier or harder, depending on your level bracket (Added
  in WoW patch 3.2.2 when level 80 characters received their own
  bracket for this battleground and all brackets below level 80
  received their own level of difficulty). The same concept
  applies to the Isle of Conquest battleground, with only two
  brackets. If you look at the database you will
  notice a very characteristic pattern which is summarized in
  table below:
`;

const movementTypes = ["空闲", "巡逻", "路径"];

const movementIdTooltip = `
  We have no idea what this field does. It is passed directly to
  the client.
`;

const inhabitTypeTooltip = `
  Controls where the creature can move and attack.
  This is a bitmask. You can add values together: 1+4=5 would
  make the creature walk on ground and fly.
  Note: If your vehicle is a flying vehicle then your accessory
  MUST have it's InhabitType set to (4 - Flying). This being if
  you set it for both ground and flying it will spawn on the
  ground if the vehicle is initially spawned on the ground.
`;

const inhabitTypes = [
  {
    index: 0,
    flag: 1,
    name: "地面",
    comment: "地面",
  },
  {
    index: 1,
    flag: 2,
    name: "水下",
    comment: "水下",
  },
  {
    index: 2,
    flag: 4,
    name: "空中",
    comment: "空中",
  },
  {
    index: 3,
    flag: 8,
    name: "Rooted",
    comment: "Not implemented.",
  },
];

const hoverHeightTooltip = `
  Distance above the ground that the creature will hover if it
  has MOVEMENTFLAG_DISABLE_GRAVITY enabled. Value taken from
  sniffs.
`;

const maxStandings = [
  {
    label: "仇恨",
    value: 0,
  },
  {
    label: "敌对",
    value: 1,
  },
  {
    label: "冷淡",
    value: 2,
  },
  {
    label: "中立",
    value: 3,
  },
  {
    label: "友善",
    value: 4,
  },
  {
    label: "尊敬",
    value: 5,
  },
  {
    label: "崇敬",
    value: 6,
  },
  {
    label: "崇拜",
    value: 7,
  },
];

const extendedCostTooltip = `
  The value here corresponds to the ID in ItemExtendedCost.dbc
  and that ID controls the item's non monetary price, be it
  honor points, arena points, different types of badges or any
  combination of the above.
`;

const spellIdTooltip = `
  The spell ID from Spell.dbc. If the ID is negative, it's
  pointing to a reference template.
`;

export {
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
  spellSchoolImmuneMasksTooltip,
  spellSchoolImmuneMasks,
  petSpellDataIdTooltip,
  vehicleIdTooltip,
  dmgSchools,
  localeResistanceSchools,
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
  maxStandings,
  extendedCostTooltip,
  spellIdTooltip,
};
