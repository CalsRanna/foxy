import 'package:foxy/constant/creature_flags.dart';
import 'package:foxy/constant/flag_item.dart';
import 'package:foxy/constant/game_object_constants.dart';

const kActionTypes = <int, String>{
  1: 'TALK',
  2: 'SET_FACTION',
  3: 'MORPH_TO_ENTRY_OR_MODEL',
  4: 'SOUND',
  5: 'PLAY_EMOTE',
  6: 'FAIL_QUEST',
  7: 'OFFER_QUEST',
  8: 'SET_REACT_STATE',
  9: 'ACTIVATE_GOBJECT',
  10: 'RANDOM_EMOTE',
  11: 'CAST',
  12: 'SUMMON_CREATURE',
  13: 'THREAT_SINGLE_PCT',
  14: 'THREAT_ALL_PCT',
  15: 'CALL_AREAEXPLOREDOREVENTHAPPENS',
  17: 'SET_EMOTE_STATE',
  18: 'SET_UNIT_FLAG',
  19: 'REMOVE_UNIT_FLAG',
  20: 'AUTO_ATTACK',
  21: 'ALLOW_COMBAT_MOVEMENT',
  22: 'SET_EVENT_PHASE',
  23: 'INC_EVENT_PHASE',
  24: 'EVADE',
  25: 'FLEE_FOR_ASSIST',
  26: 'CALL_GROUPEVENTHAPPENS',
  27: 'COMBAT_STOP',
  28: 'REMOVEAURASFROMSPELL',
  29: 'FOLLOW',
  30: 'RANDOM_PHASE',
  31: 'RANDOM_PHASE_RANGE',
  32: 'RESET_GOBJECT',
  33: 'CALL_KILLEDMONSTER',
  34: 'SET_INST_DATA',
  35: 'SET_INST_DATA64',
  36: 'UPDATE_TEMPLATE',
  37: 'DIE',
  38: 'SET_IN_COMBAT_WITH_ZONE',
  39: 'CALL_FOR_HELP',
  40: 'SET_SHEATH',
  41: 'FORCE_DESPAWN',
  42: 'SET_INVINCIBILITY_HP_LEVEL',
  43: 'MOUNT_TO_ENTRY_OR_MODEL',
  44: 'SET_INGAME_PHASE_MASK',
  45: 'SET_DATA',
  46: 'MOVE_FORWARD',
  47: 'SET_VISIBILITY',
  48: 'SET_ACTIVE',
  49: 'ATTACK_START',
  50: 'SUMMON_GO',
  51: 'KILL_UNIT',
  52: 'ACTIVATE_TAXI',
  53: 'ESCORT_START',
  54: 'ESCORT_PAUSE',
  55: 'ESCORT_STOP',
  56: 'ADD_ITEM',
  57: 'REMOVE_ITEM',
  58: 'INSTALL_AI_TEMPLATE',
  59: 'SET_RUN',
  60: 'SET_FLY',
  61: 'SET_SWIM',
  62: 'TELEPORT',
  63: 'SET_COUNTER',
  64: 'STORE_TARGET_LIST',
  65: 'ESCORT_RESUME',
  66: 'SET_ORIENTATION',
  67: 'CREATE_TIMED_EVENT',
  68: 'PLAYMOVIE',
  69: 'MOVE_TO_POS',
  70: 'RESPAWN_TARGET',
  71: 'EQUIP',
  72: 'CLOSE_GOSSIP',
  73: 'TRIGGER_TIMED_EVENT',
  74: 'REMOVE_TIMED_EVENT',
  75: 'ADD_AURA',
  76: 'OVERRIDE_SCRIPT_BASE_OBJECT',
  77: 'RESET_SCRIPT_BASE_OBJECT',
  78: 'CALL_SCRIPT_RESET',
  79: 'SET_RANGED_MOVEMENT',
  80: 'CALL_TIMED_ACTIONLIST',
  81: 'SET_NPC_FLAG',
  82: 'ADD_NPC_FLAG',
  83: 'REMOVE_NPC_FLAG',
  84: 'SIMPLE_TALK',
  85: 'SELF_CAST',
  86: 'CROSS_CAST',
  87: 'CALL_RANDOM_TIMED_ACTIONLIST',
  88: 'CALL_RANDOM_RANGE_TIMED_ACTIONLIST',
  89: 'RANDOM_MOVE',
  90: 'SET_UNIT_FIELD_BYTES_1',
  91: 'REMOVE_UNIT_FIELD_BYTES_1',
  92: 'INTERRUPT_SPELL',
  93: 'SEND_GO_CUSTOM_ANIM',
  94: 'SET_DYNAMIC_FLAG',
  95: 'ADD_DYNAMIC_FLAG',
  96: 'REMOVE_DYNAMIC_FLAG',
  97: 'JUMP_TO_POS',
  98: 'SEND_GOSSIP_MENU',
  99: 'GO_SET_LOOT_STATE',
  100: 'SEND_TARGET_TO_TARGET',
  101: 'SET_HOME_POS',
  102: 'SET_HEALTH_REGEN',
  103: 'SET_ROOT',
  104: 'SET_GO_FLAG',
  105: 'ADD_GO_FLAG',
  106: 'REMOVE_GO_FLAG',
  107: 'SUMMON_CREATURE_GROUP',
  108: 'SET_POWER',
  109: 'ADD_POWER',
  110: 'REMOVE_POWER',
  111: 'GAME_EVENT_STOP',
  112: 'GAME_EVENT_START',
  113: 'START_CLOSEST_WAYPOINT',
  114: 'RISE_UP',
  115: 'RANDOM_SOUND',
  116: 'SET_CORPSE_DELAY',
  117: 'DISABLE_EVADE',
  118: 'GO_SET_GO_STATE',
  121: 'SET_SIGHT_DIST',
  122: 'FLEE',
  123: 'ADD_THREAT',
  124: 'LOAD_EQUIPMENT',
  125: 'TRIGGER_RANDOM_TIMED_EVENT',
  126: 'REMOVE_ALL_GAMEOBJECTS',
  131: 'SPAWN_SPAWNGROUP',
  132: 'DESPAWN_SPAWNGROUP',
  134: 'INVOKER_CAST',
  135: 'PLAY_CINEMATIC',
  136: 'SET_MOVEMENT_SPEED',
  142: 'SET_HEALTH_PCT',
  201: 'MOVE_TO_POS_TARGET',
  203: 'EXIT_VEHICLE',
  204: 'SET_UNIT_MOVEMENT_FLAGS',
  205: 'SET_COMBAT_DISTANCE',
  206: 'DISMOUNT',
  207: 'SET_HOVER',
  208: 'ADD_IMMUNITY',
  209: 'REMOVE_IMMUNITY',
  210: 'FALL',
  211: 'SET_EVENT_FLAG_RESET',
  212: 'STOP_MOTION',
  213: 'NO_ENVIRONMENT_UPDATE',
  214: 'ZONE_UNDER_ATTACK',
  215: 'LOAD_GRID',
  216: 'MUSIC',
  217: 'RANDOM_MUSIC',
  218: 'CUSTOM_CAST',
  219: 'CONE_SUMMON',
  220: 'PLAYER_TALK',
  221: 'VORTEX_SUMMON',
  222: 'CU_ENCOUNTER_START',
  223: 'DO_ACTION',
  224: 'ATTACK_STOP',
  225: 'SET_GUID',
  226: 'SCRIPTED_SPAWN',
  227: 'SET_SCALE',
  228: 'SUMMON_RADIAL',
  229: 'PLAY_SPELL_VISUAL',
  230: 'FOLLOW_GROUP',
  231: 'SET_ORIENTATION_TARGET',
  232: 'WAYPOINT_START',
  233: 'WAYPOINT_DATA_RANDOM',
  234: 'MOVEMENT_STOP',
  235: 'MOVEMENT_PAUSE',
  236: 'MOVEMENT_RESUME',
  237: 'WORLD_SCRIPT',
  238: 'DISABLE_REWARD',
  239: 'SET_ANIM_TIER',
  240: 'SET_GOSSIP_MENU',
  241: 'SUMMON_GAMEOBJECT_GROUP',
  242: 'INC_DATA',
};

const kEventFlagItems = <FlagItem>[
  FlagItem(0x001, 'NOT_REPEATABLE'),
  FlagItem(0x002, 'DIFFICULTY_0'),
  FlagItem(0x004, 'DIFFICULTY_1'),
  FlagItem(0x008, 'DIFFICULTY_2'),
  FlagItem(0x010, 'DIFFICULTY_3'),
  FlagItem(0x020, 'RESERVED_5'),
  FlagItem(0x040, 'RESERVED_6'),
  FlagItem(0x080, 'DEBUG_ONLY'),
  FlagItem(0x100, 'DONT_RESET'),
  FlagItem(0x200, 'WHILE_CHARMED'),
];

const kEventPhaseFlagItems = <FlagItem>[
  FlagItem(1, 'Phase 1'),
  FlagItem(2, 'Phase 2'),
  FlagItem(4, 'Phase 3'),
  FlagItem(8, 'Phase 4'),
  FlagItem(16, 'Phase 5'),
  FlagItem(32, 'Phase 6'),
  FlagItem(64, 'Phase 7'),
  FlagItem(128, 'Phase 8'),
  FlagItem(256, 'Phase 9'),
  FlagItem(512, 'Phase 10'),
  FlagItem(1024, 'Phase 11'),
  FlagItem(2048, 'Phase 12'),
];

const kEventPhaseMasks = <int, String>{
  1: 'Phase 1',
  2: 'Phase 2',
  4: 'Phase 3',
  8: 'Phase 4',
  16: 'Phase 5',
  32: 'Phase 6',
  64: 'Phase 7',
  128: 'Phase 8',
  256: 'Phase 9',
  512: 'Phase 10',
  1024: 'Phase 11',
  2048: 'Phase 12',
};

const kEventTypes = <int, String>{
  0: 'UPDATE_IC',
  1: 'UPDATE_OOC',
  2: 'HEALTH_PCT',
  3: 'MANA_PCT',
  4: 'AGGRO',
  5: 'KILL',
  6: 'DEATH',
  7: 'EVADE',
  8: 'SPELLHIT',
  9: 'RANGE',
  10: 'OOC_LOS',
  11: 'RESPAWN',
  12: 'TARGET_HEALTH_PCT',
  13: 'VICTIM_CASTING',
  14: 'FRIENDLY_HEALTH',
  15: 'FRIENDLY_IS_CC',
  16: 'FRIENDLY_MISSING_BUFF',
  17: 'SUMMONED_UNIT',
  18: 'TARGET_MANA_PCT',
  19: 'ACCEPTED_QUEST',
  20: 'REWARD_QUEST',
  21: 'REACHED_HOME',
  22: 'RECEIVE_EMOTE',
  23: 'HAS_AURA',
  24: 'TARGET_BUFFED',
  25: 'RESET',
  26: 'IC_LOS',
  27: 'PASSENGER_BOARDED',
  28: 'PASSENGER_REMOVED',
  29: 'CHARMED',
  30: 'CHARMED_TARGET',
  31: 'SPELLHIT_TARGET',
  32: 'DAMAGED',
  33: 'DAMAGED_TARGET',
  34: 'MOVEMENTINFORM',
  35: 'SUMMON_DESPAWNED',
  36: 'CORPSE_REMOVED',
  37: 'AI_INIT',
  38: 'DATA_SET',
  39: 'ESCORT_START',
  40: 'ESCORT_REACHED',
  41: 'TRANSPORT_ADDPLAYER',
  42: 'TRANSPORT_ADDCREATURE',
  43: 'TRANSPORT_REMOVE_PLAYER',
  44: 'TRANSPORT_RELOCATE',
  45: 'INSTANCE_PLAYER_ENTER',
  46: 'AREATRIGGER_ONTRIGGER',
  47: 'QUEST_ACCEPTED',
  48: 'QUEST_OBJ_COMPLETION',
  49: 'QUEST_COMPLETION',
  50: 'QUEST_REWARDED',
  51: 'QUEST_FAIL',
  52: 'TEXT_OVER',
  53: 'RECEIVE_HEAL',
  54: 'JUST_SUMMONED',
  55: 'ESCORT_PAUSED',
  56: 'ESCORT_RESUMED',
  57: 'ESCORT_STOPPED',
  58: 'ESCORT_ENDED',
  59: 'TIMED_EVENT_TRIGGERED',
  60: 'UPDATE',
  61: 'LINK',
  62: 'GOSSIP_SELECT',
  63: 'JUST_CREATED',
  64: 'GOSSIP_HELLO',
  65: 'FOLLOW_COMPLETED',
  66: 'EVENT_PHASE_CHANGE',
  67: 'IS_BEHIND_TARGET',
  68: 'GAME_EVENT_START',
  69: 'GAME_EVENT_END',
  70: 'GO_STATE_CHANGED',
  71: 'GO_EVENT_INFORM',
  72: 'ACTION_DONE',
  73: 'ON_SPELLCLICK',
  74: 'FRIENDLY_HEALTH_PCT',
  75: 'DISTANCE_CREATURE',
  76: 'DISTANCE_GAMEOBJECT',
  77: 'COUNTER_SET',
  82: 'SUMMONED_UNIT_DIES',
  101: 'NEAR_PLAYERS',
  102: 'NEAR_PLAYERS_NEGATION',
  103: 'NEAR_UNIT',
  104: 'NEAR_UNIT_NEGATION',
  105: 'AREA_CASTING',
  106: 'AREA_RANGE',
  107: 'SUMMONED_UNIT_EVADE',
  108: 'WAYPOINT_REACHED',
  109: 'WAYPOINT_ENDED',
  110: 'IS_IN_MELEE_RANGE',
};

const kFormationTargetTypeOptions = <int, String>{
  0: 'MEMBERS',
  1: 'LEADER',
  2: 'ALL',
};

const kGossipHelloFilterOptions = <int, String>{
  0: '无过滤',
  1: '仅 GossipHello',
  2: '仅 reportUse',
};

const kInstanceStorageTypeOptions = <int, String>{
  1: 'CREATURE',
  2: 'GAMEOBJECT',
};

const kLivingStateOptions = <int, String>{0: 'ANY', 1: 'ALIVE', 2: 'DEAD'};

const kLosHostilityOptions = <int, String>{
  0: 'HOSTILE',
  1: 'NOT_HOSTILE',
  2: 'ANY',
};

const kNearUnitTypeOptions = <int, String>{0: 'CREATURE', 1: 'GAMEOBJECT'};
const kRespawnConditionOptions = <int, String>{0: 'NONE', 1: 'MAP', 2: 'AREA'};
const kSmartBooleanOptions = <int, String>{0: '否', 1: '是'};
const kSmartCastFlagItems = <FlagItem>[
  FlagItem(0x001, 'INTERRUPT_PREVIOUS'),
  FlagItem(0x002, 'TRIGGERED'),
  FlagItem(0x020, 'AURA_NOT_PRESENT'),
  FlagItem(0x040, 'COMBAT_MOVE'),
  FlagItem(0x080, 'THREATLIST_NOT_SINGLE'),
  FlagItem(0x100, 'TARGET_POWER_MANA'),
  FlagItem(0x200, 'ENABLE_COMBAT_MOVE_ON_LOS'),
  FlagItem(0x400, 'MAIN_SPELL'),
];
// AzerothCore master@a0b6553b, SmartScriptMgr.h / SmartScriptMgr.cpp.
// Only source types accepted by SmartAIMgr::LoadSmartAIFromDB are exposed.
const kSourceTypes = <int, String>{
  0: 'CREATURE',
  1: 'GAMEOBJECT',
  2: 'AREATRIGGER',
  9: 'TIMED_ACTIONLIST',
};
const kSummonCreatureFlagItems = <FlagItem>[
  FlagItem(0x1, 'PERSONAL_SPAWN'),
  FlagItem(0x2, 'PREFER_UNIT'),
];
const kTargetRoleFlagItems = <FlagItem>[
  FlagItem(0x1, 'TANKS'),
  FlagItem(0x2, 'HEALERS'),
  FlagItem(0x4, 'DAMAGERS'),
];
const kTargetTypes = <int, String>{
  0: 'NONE',
  1: 'SELF',
  2: 'VICTIM',
  3: 'HOSTILE_SECOND_AGGRO',
  4: 'HOSTILE_LAST_AGGRO',
  5: 'HOSTILE_RANDOM',
  6: 'HOSTILE_RANDOM_NOT_TOP',
  7: 'ACTION_INVOKER',
  8: 'POSITION',
  9: 'CREATURE_RANGE',
  10: 'CREATURE_GUID',
  11: 'CREATURE_DISTANCE',
  12: 'STORED',
  13: 'GAMEOBJECT_RANGE',
  14: 'GAMEOBJECT_GUID',
  15: 'GAMEOBJECT_DISTANCE',
  16: 'INVOKER_PARTY',
  17: 'PLAYER_RANGE',
  18: 'PLAYER_DISTANCE',
  19: 'CLOSEST_CREATURE',
  20: 'CLOSEST_GAMEOBJECT',
  21: 'CLOSEST_PLAYER',
  22: 'ACTION_INVOKER_VEHICLE',
  23: 'OWNER_OR_SUMMONER',
  24: 'THREAT_LIST',
  25: 'CLOSEST_ENEMY',
  26: 'CLOSEST_FRIENDLY',
  28: 'FARTHEST',
  29: 'VEHICLE_PASSENGER',
  201: 'PLAYER_WITH_AURA',
  202: 'RANDOM_POINT',
  203: 'ROLE_SELECTION',
  204: 'SUMMONED_CREATURES',
  205: 'INSTANCE_STORAGE',
  206: 'FORMATION',
};

const _creatureEvents = <int>{
  0,
  1,
  2,
  3,
  4,
  5,
  6,
  7,
  8,
  9,
  10,
  11,
  12,
  13,
  14,
  15,
  16,
  17,
  18,
  19,
  20,
  21,
  22,
  23,
  24,
  25,
  26,
  27,
  28,
  29,
  30,
  31,
  32,
  33,
  34,
  35,
  36,
  37,
  38,
  39,
  40,
  52,
  53,
  54,
  55,
  56,
  57,
  58,
  59,
  60,
  61,
  62,
  63,
  64,
  65,
  66,
  67,
  68,
  69,
  72,
  73,
  74,
  75,
  76,
  77,
  82,
  101,
  102,
  103,
  104,
  105,
  106,
  107,
  108,
  109,
  110,
};

const _gameObjectEvents = <int>{
  1,
  8,
  11,
  17,
  19,
  20,
  35,
  37,
  38,
  52,
  59,
  60,
  61,
  62,
  63,
  64,
  66,
  68,
  69,
  70,
  71,
  77,
  82,
  101,
  102,
  103,
  104,
  107,
};

const _minMaxRepeatEvents = <int>{
  0,
  1,
  2,
  3,
  9,
  12,
  18,
  32,
  33,
  53,
  60,
  67,
  74,
  105,
  106,
  110,
};

const _none = SmartParameterGroupConfig(
  _unused,
  _unused,
  _unused,
  _unused,
  _unused,
  _unused,
);
const _unused = SmartParameterFieldConfig('未使用', editable: false);

SmartParameterGroupConfig smartActionParameterConfig(int type) {
  switch (type) {
    case 1:
      return _g(
        _f('creature_text 组 ID'),
        _f('持续时间'),
        _f('使用动作目标', options: kSmartBooleanOptions),
        _f('延迟'),
      );
    case 2:
      return _g(
        _f(
          'FactionTemplate ID',
          reference: SmartParameterReference.factionTemplate,
        ),
      );
    case 3:
    case 43:
      return _g(
        _f('生物 Entry', reference: SmartParameterReference.creature),
        _f('模型 ID', reference: SmartParameterReference.creatureDisplay),
      );
    case 4:
      return _g(
        _f('声音 ID'),
        _f('仅自身', options: kSmartBooleanOptions),
        _f('距离'),
      );
    case 5:
    case 17:
      return _g(_f('Emotes ID', reference: SmartParameterReference.emote));
    case 6:
    case 15:
    case 26:
      return _g(_f('任务 ID', reference: SmartParameterReference.quest));
    case 7:
      return _g(
        _f('任务 ID', reference: SmartParameterReference.quest),
        _f('直接添加', options: kSmartBooleanOptions),
      );
    case 8:
      return _g(_f('ReactState'));
    case 10:
      return _g(
        _f('Emotes ID 1', reference: SmartParameterReference.emote),
        _f('Emotes ID 2', reference: SmartParameterReference.emote),
        _f('Emotes ID 3', reference: SmartParameterReference.emote),
        _f('Emotes ID 4', reference: SmartParameterReference.emote),
        _f('Emotes ID 5', reference: SmartParameterReference.emote),
        _f('Emotes ID 6', reference: SmartParameterReference.emote),
      );
    case 11:
    case 85:
    case 134:
      return _g(
        _f('法术 ID', reference: SmartParameterReference.spell),
        _f('施法标志', flags: kSmartCastFlagItems),
        _f('触发标志'),
        _f('目标数量限制'),
      );
    case 12:
      return _g(
        _f('生物 Entry', reference: SmartParameterReference.creature),
        _f('TempSummonType'),
        _f('持续时间'),
        _f('攻击触发者', options: kSmartBooleanOptions),
        _f('攻击脚本所有者', options: kSmartBooleanOptions),
        _f('召唤标志', flags: kSummonCreatureFlagItems),
      );
    case 13:
    case 14:
      return _g(_f('增加仇恨百分比'), _f('减少仇恨百分比'));
    case 18:
    case 19:
      return _g(_f('UnitFlags', flags: kUnitFlagOptions), _f('字段索引'));
    case 20:
      return _g(_f('允许自动攻击', options: kSmartBooleanOptions));
    case 21:
      return _g(_f('允许战斗移动', options: kSmartBooleanOptions));
    case 22:
      return _g(_f('事件阶段'));
    case 23:
      return _g(_f('增加阶段'), _f('减少阶段'));
    case 25:
      return _g(_f('播放表情', options: kSmartBooleanOptions));
    case 28:
      return _g(
        _f('法术 ID', reference: SmartParameterReference.spell),
        _f('层数'),
      );
    case 29:
      return _g(
        _f('距离'),
        _f('角度'),
        _f('结束生物 Entry', reference: SmartParameterReference.creature),
        _f('Credit ID'),
        _f('Credit 类型'),
        _f('存活状态', options: kLivingStateOptions),
      );
    case 30:
      return _g(
        _f('阶段 1'),
        _f('阶段 2'),
        _f('阶段 3'),
        _f('阶段 4'),
        _f('阶段 5'),
        _f('阶段 6'),
      );
    case 31:
      return _g(_f('最小阶段'), _f('最大阶段'));
    case 33:
      return _g(_f('生物 Entry', reference: SmartParameterReference.creature));
    case 34:
      return _g(_f('字段'), _f('数据'), _f('数据类型'));
    case 35:
      return _g(_f('字段'));
    case 36:
      return _g(
        _f('生物 Entry', reference: SmartParameterReference.creature),
        _f('更新等级', options: kSmartBooleanOptions),
      );
    case 37:
      return _g(_f('延迟毫秒'));
    case 38:
      return _g(_f('范围'));
    case 39:
      return _g(_f('半径'), _f('播放表情', options: kSmartBooleanOptions));
    case 40:
      return _g(_f('武器状态'));
    case 41:
      return _g(
        _f('延迟'),
        _f('强制刷新计时'),
        _f('从世界移除', options: kSmartBooleanOptions),
      );
    case 42:
      return _g(_f('最低生命值'), _f('百分比'));
    case 44:
      return _g(_f('PhaseMask'));
    case 45:
    case 242:
      return _g(_f('数据字段'), _f(type == 242 ? '增量' : '数据值'));
    case 46:
    case 89:
    case 114:
      return _g(_f('距离'));
    case 47:
    case 48:
    case 59:
    case 61:
    case 102:
    case 103:
    case 117:
    case 207:
    case 211:
      return _g(_f('状态', options: kSmartBooleanOptions));
    case 50:
      return _g(
        _f('游戏对象 Entry', reference: SmartParameterReference.gameObject),
        _f('消失时间'),
        _f('目标召唤'),
        _f('召唤类型'),
      );
    case 52:
      return _g(_f('TaxiPath ID', reference: SmartParameterReference.taxiPath));
    case 53:
      return _g(
        _f('强制移动'),
        _f('路径 ID', reference: SmartParameterReference.waypointPath),
        _f('重复', options: kSmartBooleanOptions),
        _f('任务 ID', reference: SmartParameterReference.quest),
        _f('消失时间'),
        _f('ReactState'),
      );
    case 54:
      return _g(_f('暂停时间'));
    case 55:
      return _g(
        _f('消失时间'),
        _f('任务 ID', reference: SmartParameterReference.quest),
        _f('任务失败', options: kSmartBooleanOptions),
      );
    case 56:
    case 57:
      return _g(
        _f('物品 Entry', reference: SmartParameterReference.item),
        _f('数量'),
      );
    case 58:
      return _g(
        _f('AI 模板 ID'),
        _f('参数 1'),
        _f('参数 2'),
        _f('参数 3'),
        _f('参数 4'),
        _f('参数 5'),
      );
    case 60:
      return _g(
        _f('飞行', options: kSmartBooleanOptions),
        _f('速度'),
        _f('禁用重力', options: kSmartBooleanOptions),
      );
    case 62:
      return _g(_f('地图 ID', reference: SmartParameterReference.map));
    case 63:
      return _g(
        _f('计数器 ID'),
        _f('值'),
        _f('重置', options: kSmartBooleanOptions),
        _f('减法值'),
      );
    case 64:
    case 100:
      return _g(_f('目标列表 ID'));
    case 66:
      return _g(
        _f('立即转向', options: kSmartBooleanOptions),
        _f('随机朝向', options: kSmartBooleanOptions),
        _f('转向角度'),
      );
    case 67:
      return _g(
        _f('定时事件 ID'),
        _f('首次最短时间'),
        _f('首次最长时间'),
        _f('重复最短时间'),
        _f('重复最长时间'),
        _f('几率'),
      );
    case 68:
      return _g(_f('Movie ID'));
    case 69:
      return _g(
        _f('点 ID'),
        _f('运输坐标', options: kSmartBooleanOptions),
        _f('受控移动', options: kSmartBooleanOptions),
        _f('接触距离'),
        _f('战斗距离'),
        _f('禁用强制终点', options: kSmartBooleanOptions),
      );
    case 70:
      return _g(_f('游戏对象刷新时间'));
    case 71:
      return _g(_f('装备 ID'), _f('槽位掩码'), _f('主手物品'), _f('副手物品'), _f('远程物品'));
    case 73:
    case 74:
      return _g(_f('定时事件 ID'));
    case 75:
      return _g(_f('法术 ID', reference: SmartParameterReference.spell));
    case 79:
      return _g(_f('距离'), _f('角度'));
    case 80:
      return _g(
        _f('定时动作列表 ID'),
        _f('计时类型'),
        _f('允许覆盖', options: kSmartBooleanOptions),
      );
    case 81:
    case 82:
    case 83:
      return _g(_f('NPCFlags', flags: kNpcFlagOptions));
    case 84:
      return _g(_f('creature_text 组 ID'), _f('持续时间'));
    case 86:
      return _g(
        _f('法术 ID', reference: SmartParameterReference.spell),
        _f('施法标志', flags: kSmartCastFlagItems),
        _f('施法者目标类型', options: kTargetTypes),
        _f('施法者目标参数 1'),
        _f('施法者目标参数 2'),
        _f('施法者目标参数 3'),
      );
    case 87:
      return _g(
        _f('动作列表 1'),
        _f('动作列表 2'),
        _f('动作列表 3'),
        _f('动作列表 4'),
        _f('动作列表 5'),
        _f('动作列表 6'),
      );
    case 88:
      return _g(_f('最小动作列表 ID'), _f('最大动作列表 ID'));
    case 90:
    case 91:
      return _g(_f('UNIT_FIELD_BYTES_1 值'), _f('字段类型'));
    case 92:
      return _g(
        _f('包含延迟法术', options: kSmartBooleanOptions),
        _f('法术 ID', reference: SmartParameterReference.spell),
        _f('包含瞬发法术', options: kSmartBooleanOptions),
      );
    case 93:
      return _g(_f('自定义动画 ID'));
    case 94:
    case 95:
    case 96:
      return _g(_f('DynamicFlags', flags: kDynamicFlagOptions));
    case 97:
      return _g(
        _f('水平速度'),
        _f('垂直速度'),
        _f('自身跳跃', options: kSmartBooleanOptions),
      );
    case 98:
      return _g(
        _f('GossipMenu ID', reference: SmartParameterReference.gossipMenu),
        _f('NpcText ID', reference: SmartParameterReference.npcText),
      );
    case 99:
    case 118:
      return _g(_f(type == 99 ? 'LootState' : 'GOState'));
    case 101:
      return _g(_f('生成位置'));
    case 104:
    case 105:
    case 106:
      return _g(_f('GameObjectFlags', flags: kGameObjectFlagItems));
    case 107:
      return _g(
        _f('生物组 ID'),
        _f('攻击触发者', options: kSmartBooleanOptions),
        _f('攻击脚本所有者', options: kSmartBooleanOptions),
      );
    case 108:
    case 109:
    case 110:
      return _g(_f('能量类型'), _f('能量值'));
    case 111:
    case 112:
      return _g(_f('game_event Entry'));
    case 113:
      return _g(
        _f('路径 ID 1', reference: SmartParameterReference.waypointPath),
        _f('路径 ID 2', reference: SmartParameterReference.waypointPath),
        _f('重复', options: kSmartBooleanOptions),
        _f('强制移动'),
        _f('路径来源'),
      );
    case 115:
      return _g(
        _f('声音 ID 1'),
        _f('声音 ID 2'),
        _f('声音 ID 3'),
        _f('声音 ID 4'),
        _f('仅自身', options: kSmartBooleanOptions),
        _f('距离'),
      );
    case 116:
      return _g(_f('尸体延迟'));
    case 121:
      return _g(_f('视野距离'));
    case 122:
      return _g(_f('逃跑时间'));
    case 123:
      return _g(_f('增加仇恨'), _f('减少仇恨'));
    case 124:
      return _g(_f('装备 ID'), _f('强制加载', options: kSmartBooleanOptions));
    case 125:
      return _g(_f('最小定时事件 ID'), _f('最大定时事件 ID'));
    case 131:
    case 132:
      return _g(
        _f('SpawnGroup ID'),
        _f('忽略刷新', options: kSmartBooleanOptions),
        _f('强制', options: kSmartBooleanOptions),
      );
    case 135:
      return _g(
        _f(
          'Cinematic ID',
          reference: SmartParameterReference.cinematicSequence,
        ),
      );
    case 136:
      return _g(_f('移动类型'), _f('速度整数部分'), _f('速度小数部分'));
    case 142:
      return _g(_f('生命百分比'));
    case 201:
      return _g(_f('点 ID'), _f('禁用强制终点', options: kSmartBooleanOptions));
    case 204:
      return _g(_f('单位移动标志'));
    case 205:
      return _g(_f('战斗距离'));
    case 208:
    case 209:
      return _g(_f('免疫类型'), _f('免疫 ID'), _f('值'));
    case 212:
      return _g(
        _f('停止移动', options: kSmartBooleanOptions),
        _f('移动过期', options: kSmartBooleanOptions),
      );
    case 216:
      return _g(
        _f('声音 ID'),
        _f('仅自身', options: kSmartBooleanOptions),
        _f('音乐类型'),
      );
    case 217:
      return _g(
        _f('声音 ID 1'),
        _f('声音 ID 2'),
        _f('声音 ID 3'),
        _f('声音 ID 4'),
        _f('仅自身', options: kSmartBooleanOptions),
        _f('音乐类型'),
      );
    case 218:
      return _g(
        _f('法术 ID', reference: SmartParameterReference.spell),
        _f('施法标志', flags: kSmartCastFlagItems),
        _f('BasePoint 0'),
        _f('BasePoint 1'),
        _f('BasePoint 2'),
      );
    case 219:
      return _g(
        _f('召唤生物 Entry', reference: SmartParameterReference.creature),
        _f('持续时间'),
        _f('环间距'),
        _f('召唤间距'),
        _f('锥体长度'),
        _f('锥体角度'),
      );
    case 220:
      return _g(
        _f('acore_string Entry'),
        _f('喊话', options: kSmartBooleanOptions),
      );
    case 221:
      return _g(
        _f('召唤生物 Entry', reference: SmartParameterReference.creature),
        _f('持续时间'),
        _f('螺旋 A'),
        _f('螺旋 K'),
        _f('最大范围'),
        _f('Phi 增量'),
      );
    case 223:
      return _g(
        _f('Action ID'),
        _f('负值', options: kSmartBooleanOptions),
        _f('副本目标', options: kSmartBooleanOptions),
      );
    case 225:
      return _g(_f('使用触发者 GUID', options: kSmartBooleanOptions), _f('索引'));
    case 226:
      return _g(
        _f('状态', options: kSmartBooleanOptions),
        _f('生成最短时间'),
        _f('生成最长时间'),
        _f('刷新延迟'),
        _f('尸体延迟'),
        _f('不消失', options: kSmartBooleanOptions),
      );
    case 227:
      return _g(_f('缩放值'));
    case 228:
      return _g(
        _f('召唤生物 Entry', reference: SmartParameterReference.creature),
        _f('持续时间'),
        _f('重复次数'),
        _f('起始角度'),
        _f('步进角度'),
        _f('距离'),
      );
    case 229:
      return _g(_f('法术视觉 ID'));
    case 230:
      return _g(
        _f('跟随状态', options: kSmartBooleanOptions),
        _f('跟随类型'),
        _f('距离'),
      );
    case 231:
      return _g(
        _f('朝向模式'),
        _f('目标类型', options: kTargetTypes),
        _f('目标参数 1'),
        _f('目标参数 2'),
        _f('目标参数 3'),
        _f('目标参数 4'),
      );
    case 232:
      return _g(
        _f('路径 ID', reference: SmartParameterReference.waypointPath),
        _f('重复', options: kSmartBooleanOptions),
        _f('路径来源'),
      );
    case 233:
      return _g(
        _f('路径 ID 1', reference: SmartParameterReference.waypointPath),
        _f('路径 ID 2', reference: SmartParameterReference.waypointPath),
        _f('重复', options: kSmartBooleanOptions),
      );
    case 235:
      return _g(_f('暂停时间'));
    case 236:
      return _g(_f('覆盖计时器'));
    case 237:
      return _g(_f('世界脚本事件 ID'), _f('参数'));
    case 238:
      return _g(
        _f('禁用声望奖励', options: kSmartBooleanOptions),
        _f('禁用掉落奖励', options: kSmartBooleanOptions),
      );
    case 239:
      return _g(_f('动画层级'));
    case 240:
      return _g(
        _f('GossipMenu ID', reference: SmartParameterReference.gossipMenu),
      );
    case 241:
      return _g(_f('游戏对象组 ID'));
    default:
      return _none;
  }
}

SmartParameterGroupConfig smartEventParameterConfig(int type) {
  if (_minMaxRepeatEvents.contains(type)) {
    final percent = const {2, 3, 12, 18, 74}.contains(type);
    final hasParam5 = const {9, 32, 67, 74, 105, 106, 110}.contains(type);
    final hasParam6 = const {9, 67, 74, 105, 106, 110}.contains(type);
    return _g(
      _f(percent ? '最小百分比' : '最小值'),
      _f(percent ? '最大百分比' : '最大值'),
      _f('重复最短时间'),
      _f('重复最长时间'),
      hasParam5
          ? _f(
              type == 74
                  ? '生命百分比'
                  : type == 110
                  ? '距离'
                  : '范围最小值',
            )
          : _unused,
      hasParam6
          ? _f(
              type == 74
                  ? '半径'
                  : type == 110
                  ? '反向'
                  : '范围最大值',
              options: type == 110 ? kSmartBooleanOptions : null,
            )
          : _unused,
    );
  }
  return switch (type) {
    5 => _g(
      _f('冷却最短时间'),
      _f('冷却最长时间'),
      _f('仅玩家', options: kSmartBooleanOptions),
      _f('生物 Entry', reference: SmartParameterReference.creature),
    ),
    8 || 31 => _g(
      _f('法术 ID', reference: SmartParameterReference.spell),
      _f('法术学派掩码'),
      _f('冷却最短时间'),
      _f('冷却最长时间'),
    ),
    10 || 26 => _g(
      _f('敌对模式', options: kLosHostilityOptions),
      _f('最大距离'),
      _f('冷却最短时间'),
      _f('冷却最长时间'),
      _f('仅玩家', options: kSmartBooleanOptions),
    ),
    11 => _g(
      _f('重生条件', options: kRespawnConditionOptions),
      _f('地图 ID', reference: SmartParameterReference.map),
      _f('区域 ID', reference: SmartParameterReference.area),
    ),
    13 => _g(
      _f('重复最短时间'),
      _f('重复最长时间'),
      _f('法术 ID', reference: SmartParameterReference.spell),
    ),
    14 => _g(_f('生命缺口'), _f('半径'), _f('重复最短时间'), _f('重复最长时间')),
    15 => _g(_f('半径'), _f('重复最短时间'), _f('重复最长时间')),
    16 => _g(
      _f('法术 ID', reference: SmartParameterReference.spell),
      _f('半径'),
      _f('重复最短时间'),
      _f('重复最长时间'),
      _f('仅战斗中', options: kSmartBooleanOptions),
    ),
    17 || 35 || 82 || 107 => _g(
      _f('生物 Entry', reference: SmartParameterReference.creature),
      _f('冷却最短时间'),
      _f('冷却最长时间'),
    ),
    19 || 20 => _g(
      _f('任务 ID', reference: SmartParameterReference.quest),
      _f('冷却最短时间'),
      _f('冷却最长时间'),
    ),
    22 => _g(
      _f('文本表情 ID', reference: SmartParameterReference.textEmote),
      _f('冷却最短时间'),
      _f('冷却最长时间'),
    ),
    23 || 24 => _g(
      _f('法术 ID', reference: SmartParameterReference.spell),
      _f('层数'),
      _f('重复最短时间'),
      _f('重复最长时间'),
    ),
    27 || 28 => _g(_f('冷却最短时间'), _f('冷却最长时间')),
    29 => _g(_f('移除时触发', options: kSmartBooleanOptions)),
    34 => _g(
      _f('移动类型'),
      _f('点 ID'),
      _f('路径 ID', reference: SmartParameterReference.waypointPath),
    ),
    38 => _g(_f('数据 ID'), _f('值'), _f('冷却最短时间'), _f('冷却最长时间')),
    39 || 40 || 55 || 56 || 57 || 58 || 108 || 109 => _g(
      _f('点 ID'),
      _f('路径 ID', reference: SmartParameterReference.waypointPath),
    ),
    42 => _g(_f('生物 Entry', reference: SmartParameterReference.creature)),
    44 => _g(_f('点 ID')),
    45 => _g(_f('阵营'), _f('冷却最短时间'), _f('冷却最长时间')),
    46 => _g(_f('AreaTrigger ID')),
    52 => _g(
      _f('creature_text 组 ID'),
      _f('生物 Entry', reference: SmartParameterReference.creature),
    ),
    59 => _g(_f('定时事件 ID')),
    62 => _g(
      _f('菜单 ID', reference: SmartParameterReference.gossipMenu),
      _f('Action ID'),
    ),
    64 => _g(_f('过滤方式', options: kGossipHelloFilterOptions)),
    66 => _g(_f('事件阶段掩码', flags: kEventPhaseFlagItems)),
    68 || 69 => _g(_f('game_event Entry')),
    70 => _g(_f('GO 状态')),
    71 => _g(_f('事件 ID')),
    72 => _g(_f('事件 ID'), _f('冷却最短时间'), _f('冷却最长时间')),
    75 => _g(
      _f('生物 GUID'),
      _f('生物 Entry', reference: SmartParameterReference.creature),
      _f('距离'),
      _f('重复时间'),
    ),
    76 => _g(
      _f('游戏对象 GUID'),
      _f('游戏对象 Entry', reference: SmartParameterReference.gameObject),
      _f('距离'),
      _f('重复时间'),
    ),
    77 => _g(_f('计数器 ID'), _f('值'), _f('冷却最短时间'), _f('冷却最长时间')),
    101 => _g(_f('最少玩家数'), _f('半径'), _f('首次时间'), _f('重复最短时间'), _f('重复最长时间')),
    102 => _g(_f('最多玩家数'), _f('半径'), _f('首次时间'), _f('重复最短时间'), _f('重复最长时间')),
    103 || 104 => _g(
      _f('单位类型', options: kNearUnitTypeOptions),
      _f('Entry'),
      _f('数量'),
      _f('范围'),
      _f('计时器'),
    ),
    _ => _none,
  };
}

Map<int, String> smartEventTypesForSource(int sourceType) {
  if (sourceType == 9) return kEventTypes;
  final allowed = switch (sourceType) {
    0 => _creatureEvents,
    1 => _gameObjectEvents,
    2 => const <int>{46, 61},
    _ => const <int>{},
  };
  return Map.unmodifiable(
    Map.fromEntries(
      kEventTypes.entries.where((entry) => allowed.contains(entry.key)),
    ),
  );
}

SmartParameterGroupConfig smartTargetParameterConfig(
  int type,
) => switch (type) {
  3 || 4 || 5 || 6 => _g(
    _f('最大距离'),
    _f('仅玩家', options: kSmartBooleanOptions),
    _f('能量类型 + 1'),
    _f('缺少的光环', reference: SmartParameterReference.spell),
  ),
  9 => _g(
    _f('生物 Entry', reference: SmartParameterReference.creature),
    _f('最小距离'),
    _f('最大距离'),
    _f('存活状态', options: kLivingStateOptions),
  ),
  10 => _g(
    _f('生物 GUID'),
    _f('生物 Entry', reference: SmartParameterReference.creature),
  ),
  11 => _g(
    _f('生物 Entry', reference: SmartParameterReference.creature),
    _f('最大距离'),
    _f('存活状态', options: kLivingStateOptions),
  ),
  12 => _g(_f('已存储目标 ID')),
  13 => _g(
    _f('游戏对象 Entry', reference: SmartParameterReference.gameObject),
    _f('最小距离'),
    _f('最大距离'),
  ),
  14 => _g(
    _f('游戏对象 GUID'),
    _f('游戏对象 Entry', reference: SmartParameterReference.gameObject),
  ),
  15 => _g(
    _f('游戏对象 Entry', reference: SmartParameterReference.gameObject),
    _f('最大距离'),
  ),
  16 => _g(_f('包含宠物', options: kSmartBooleanOptions)),
  17 => _g(_f('最小距离'), _f('最大距离'), _f('最大数量')),
  18 || 21 => _g(_f('最大距离')),
  19 => _g(
    _f('生物 Entry', reference: SmartParameterReference.creature),
    _f('最大距离'),
    _f('死亡目标', options: kSmartBooleanOptions),
  ),
  20 => _g(
    _f('游戏对象 Entry', reference: SmartParameterReference.gameObject),
    _f('最大距离'),
    _f('仅已生成', options: kSmartBooleanOptions),
  ),
  23 => _g(_f('使用控制者/所有者', options: kSmartBooleanOptions)),
  24 => _g(_f('最大距离')),
  25 || 26 => _g(_f('最大距离'), _f('仅玩家', options: kSmartBooleanOptions)),
  28 => _g(
    _f('最大距离'),
    _f('仅玩家', options: kSmartBooleanOptions),
    _f('要求视线', options: kSmartBooleanOptions),
    _f('最小距离'),
  ),
  29 => _g(_f('座位掩码')),
  201 => _g(
    _f('法术 ID', reference: SmartParameterReference.spell),
    _f('反向', options: kSmartBooleanOptions),
    _f('最大距离'),
    _f('最小距离'),
  ),
  202 => _g(_f('范围'), _f('数量'), _f('以自身为中心', options: kSmartBooleanOptions)),
  203 => _g(_f('最大范围'), _f('职责掩码', flags: kTargetRoleFlagItems), _f('结果数量')),
  204 => _g(_f('生物 Entry', reference: SmartParameterReference.creature)),
  205 => _g(_f('存储索引'), _f('对象类型', options: kInstanceStorageTypeOptions)),
  206 => _g(
    _f('编队目标', options: kFormationTargetTypeOptions),
    _f('生物 Entry', reference: SmartParameterReference.creature),
    _f('排除自身', options: kSmartBooleanOptions),
  ),
  _ => _none,
};

SmartParameterFieldConfig _f(
  String label, {
  SmartParameterReference reference = SmartParameterReference.none,
  Map<int, String>? options,
  List<FlagItem>? flags,
}) => SmartParameterFieldConfig(
  label,
  reference: reference,
  options: options,
  flags: flags,
);

SmartParameterGroupConfig _g(
  SmartParameterFieldConfig p1, [
  SmartParameterFieldConfig p2 = _unused,
  SmartParameterFieldConfig p3 = _unused,
  SmartParameterFieldConfig p4 = _unused,
  SmartParameterFieldConfig p5 = _unused,
  SmartParameterFieldConfig p6 = _unused,
]) => SmartParameterGroupConfig(p1, p2, p3, p4, p5, p6);

class SmartParameterFieldConfig {
  final String label;
  final bool editable;
  final SmartParameterReference reference;
  final Map<int, String>? options;
  final List<FlagItem>? flags;

  const SmartParameterFieldConfig(
    this.label, {
    this.editable = true,
    this.reference = SmartParameterReference.none,
    this.options,
    this.flags,
  });
}

class SmartParameterGroupConfig {
  final SmartParameterFieldConfig param1;
  final SmartParameterFieldConfig param2;
  final SmartParameterFieldConfig param3;
  final SmartParameterFieldConfig param4;
  final SmartParameterFieldConfig param5;
  final SmartParameterFieldConfig param6;

  const SmartParameterGroupConfig(
    this.param1,
    this.param2,
    this.param3,
    this.param4,
    this.param5,
    this.param6,
  );

  SmartParameterFieldConfig field(int index) => switch (index) {
    1 => param1,
    2 => param2,
    3 => param3,
    4 => param4,
    5 => param5,
    6 => param6,
    _ => throw RangeError.range(index, 1, 6, 'index'),
  };
}

enum SmartParameterReference {
  none,
  area,
  cinematicSequence,
  creature,
  creatureDisplay,
  emote,
  factionTemplate,
  gameObject,
  gossipMenu,
  item,
  map,
  npcText,
  quest,
  spell,
  taxiPath,
  textEmote,
  waypointPath,
}
