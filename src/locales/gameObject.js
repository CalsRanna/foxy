const types = [
  "门",
  "按钮",
  "任务发放者",
  "箱子",
  "BINDER",
  "通用",
  "陷阱",
  "椅子",
  "SPELL_FOCUS",
  "文本",
  "GOOBER",
  "交通工具",
  "区域伤害",
  "相机",
  "地图物体",
  "MO_TRANSPORT",
  "决斗仲裁",
  "钓鱼点",
  "仪式",
  "邮箱",
  "拍卖行",
  "岗哨",
  "法术施放者",
  "集合石",
  "FLAGSTAND",
  "渔点",
  "FLAGDROP",
  "MINI_GAME",
  "LOTTERY_KIOSK",
  "CAPTURE_POINT",
  "AURA_GENERATOR",
  "地下城难度",
  "理发椅",
  "DESTRUCTIBLE_BUILDING",
  "工会银行",
  "TRAPDOOR",
];

const datas = [
  [
    { label: "startOpen", field: "Data0", type: "el-switch" },
    { label: "锁", field: "Data1", type: "lock-selector" },
    { label: "自动关闭", field: "Data2", type: "el-input-number" },
    { label: "无伤害免疫", field: "Data3", type: "el-switch" },
    { label: "开启文本", field: "Data4", type: "el-input" },
    { label: "关闭文本", field: "Data5", type: "el-input" },
    { label: "忽略寻路", field: "Data6", type: "el-input" },
    { label: "条件", field: "Data7", type: "el-input" },
    { label: "不透明", field: "Data8", type: "el-input" },
    { label: "GiganticAOI", field: "Data9", type: "el-input" },
    { label: "InfiniteAOI", field: "Data10", type: "el-input" },
  ], // GAMEOBJECT_TYPE_DOOR
  [
    { label: "startOpen", field: "Data0", type: "el-input" },
    { label: "锁", field: "Data1", type: "lock-selector" },
    { label: "自动关闭", field: "Data2", type: "el-input-number" },
    { label: "关联陷阱", field: "Data3", type: "game-object-selector" },
    { label: "无伤害免疫", field: "Data4", type: "el-switch" },
    { label: "更大", field: "Data5", type: "el-switch" },
    { label: "开启文本", field: "Data6", type: "el-input" },
    { label: "关闭文本", field: "Data7", type: "el-input" },
    { label: "losOK", field: "Data8", type: "el-switch" },
    { label: "条件", field: "Data9", type: "el-input" },
  ], // GAMEOBJECT_TYPE_BUTTON
  [
    { label: "锁", field: "Data0", type: "lock-selector" },
    { label: "任务列表", field: "Data1", type: "quest-template-selector" },
    {
      label: "页面材料",
      field: "Data2",
      type: "page-text-material-selector",
    },
    { label: "对话", field: "Data3", type: "gossip-menu-selector" },
    { label: "customAnim", field: "Data4", type: "el-switch" },
    { label: "无伤害免疫", field: "Data5", type: "el-switch" },
    { label: "开启文本", field: "Data6", type: "broadcast-text-selector" },
    { label: "losOK", field: "Data7", type: "el-switch" },
    { label: "骑乘可用", field: "Data8", type: "el-switch" },
    { label: "更大", field: "Data9", type: "el-switch" },
    { label: "条件", field: "Data10", type: "el-input" },
    { label: "骑乘不可用", field: "Data11", type: "el-input" },
  ], // GAMEOBJECT_TYPE_QUESTGIVER
  [
    { label: "锁", field: "Data0", type: "lock-selector" },
    {
      label: "物品掉落",
      field: "Data1",
      type: "game-object-loot-template-selector",
    },
    { label: "补货时间", field: "Data2", type: "el-input-number" },
    { label: "消耗品", field: "Data3", type: "el-switch" },
    { label: "最少补货", field: "Data4", type: "el-input" },
    { label: "最多补货", field: "Data5", type: "el-input" },
    { label: "掉落事件", field: "Data6", type: "event-script-selector" },
    {
      label: "关联陷阱",
      field: "Data7",
      type: "game-object-template-selector",
    },
    { label: "任务", field: "Data8", type: "quest-template-selector" },
    { label: "等级", field: "Data9", type: "el-input-number" },
    { label: "losOK", field: "Data10", type: "el-switch" },
    { label: "leaveLoot", field: "Data11", type: "el-switch" },
    { label: "离开战斗", field: "Data12", type: "el-switch" },
    { label: "log loot", field: "Data13", type: "el-switch" },
    { label: "开启文本", field: "Data14", type: "el-input" },
    { label: "使用掉落组规则", field: "Data15", type: "el-switch" },
    { label: "floating tooltip", field: "Data16", type: "el-input" },
    { label: "条件", field: "Data17", type: "el-input" },
    { label: "经验等级", field: "Data18", type: "el-input" },
    { label: "经验难度", field: "Data19", type: "el-input" },
    { label: "掉落等级", field: "Data20", type: "el-input" },
    { label: "Group Xp", field: "Data21", type: "el-input" },
    { label: "伤害免疫", field: "Data22", type: "el-switch" },
    { label: "trivialSkillLow", field: "Data23", type: "el-input" },
  ], // GAMEOBJECT_TYPE_CHEST
  [], // GAMEOBJECT_TYPE_BINDER
  [
    { label: "悬浮提示", field: "Data0", type: "el-switch" },
    { label: "高亮", field: "Data1", type: "el-switch" },
    { label: "serverOnly", field: "Data2", type: "el-switch" },
    { label: "更大", field: "Data3", type: "el-switch" },
    { label: "悬浮水面", field: "Data4", type: "el-switch" },
    { label: "任务", field: "Data5", type: "quest-template-selector" },
    { label: "条件", field: "Data6", type: "el-input" },
    { label: "LargeAOI", field: "Data7", type: "el-input" },
    { label: "驻扎工会颜色", field: "Data8", type: "el-input" },
  ], // GAMEOBJECT_TYPE_GENERIC
  [
    { label: "锁", field: "Data0", type: "lock-selector" },
    { label: "等级", field: "Data1", type: "el-input-number" },
    { label: "直径", field: "Data2", type: "el-input-number" },
    { label: "技能", field: "Data3", type: "spell-selector" },
    { label: "类型", field: "Data4", type: "el-input" },
    { label: "冷却时间", field: "Data5", type: "el-input-number" },
    { label: "unknown", field: "Data6", type: "el-input" },
    { label: "开始延迟", field: "Data7", type: "el-input-number" },
    { label: "serverOnly", field: "Data8", type: "el-switchr" },
    { label: "stealthed", field: "Data9", type: "el-switch" },
    { label: "更大", field: "Data10", type: "el-switch" },
    { label: "stealthAffected", field: "Data11", type: "el-switch" },
    { label: "开启文本", field: "Data12", type: "el-input" },
    { label: "关闭文本", field: "Data13", type: "el-input" },
    { label: "忽略图腾", field: "Data14", type: "el-input" },
    { label: "条件", field: "Data15", type: "el-input" },
    { label: "playerCast", field: "Data16", type: "el-input" },
    { label: "SummonerTriggered", field: "Data17", type: "el-input" },
    { label: "requireLOS", field: "Data18", type: "el-input" },
  ], // GAMEOBJECT_TYPE_TRAP
  [
    { label: "座位数量", field: "Data0", type: "el-input-number" },
    { label: "角度", field: "Data1", type: "el-input-number" },
    { label: "仅创造者可用", field: "Data2", type: "el-switch" },
    { label: "触发事件", field: "Data3", type: "spell-selector" },
    { label: "条件", field: "Data4", type: "el-input" },
  ], // GAMEOBJECT_TYPE_CHAIR
  [
    {
      label: "类型",
      field: "Data0",
      type: "spell-focus-object-selector",
    },
    { label: "直径", field: "Data1", type: "el-input-number" },
    {
      label: "关联陷阱",
      field: "Data2",
      type: "game-object-template-selector",
    },
    { label: "serverOnly", field: "Data3", type: "el-switch" },
    { label: "任务", field: "Data4", type: "quest-template-selector" },
    { label: "更大", field: "Data5", type: "el-switch" },
    { label: "悬浮提示", field: "Data6", type: "el-switch" },
    { label: "悬浮水面", field: "Data7", type: "el-input" },
    { label: "条件", field: "Data8", type: "el-input" },
  ], // GAMEOBJECT_TYPE_SPELL_FOCUS
  [
    { label: "页面", field: "Data0", type: "page-text-selector" },
    { label: "语言", field: "Data1", type: "language-selector" },
    {
      label: "页面材料",
      field: "Data2",
      type: "page-text-material-selector",
    },
    { label: "骑乘可用", field: "Data3", type: "el-input" },
    { label: "条件", field: "Data4", type: "el-input" },
    { label: "骑乘不可用", field: "Data5", type: "el-input" },
  ], // GAMEOBJECT_TYPE_TEXT
  [
    { label: "锁", field: "Data0", type: "lock-selector" },
    { label: "任务", field: "Data1", type: "quest-template-selector" },
    { label: "事件", field: "Data2", type: "event-script-selector" },
    { label: "reinitialTime", field: "Data3", type: "el-input-number" },
    { label: "customAnim", field: "Data4", type: "el-input" },
    { label: "消耗品", field: "Data5", type: "el-switch" },
    { label: "冷却时间", field: "Data6", type: "el-input-number" },
    { label: "页面", field: "Data7", type: "page-text-selector" },
    { label: "语言", field: "Data8", type: "language-selector" },
    {
      label: "页面材料",
      field: "Data9",
      type: "page-text-material-selector",
    },
    { label: "技能", field: "Data10", type: "spell-selector" },
    { label: "无伤害免疫", field: "Data11", type: "el-switch" },
    {
      label: "关联陷阱",
      field: "Data12",
      type: "game-object-template-selector",
    },
    { label: "更大", field: "Data13", type: "el-switch" },
    { label: "开启文本", field: "Data14", type: "el-input" },
    { label: "关闭文本", field: "Data15", type: "el-input" },
    { label: "losOK", field: "Data16", type: "el-switch" },
    { label: "unknown", field: "Data17", type: "el-input" },
    { label: "unknown", field: "Data18", type: "el-input" },
    { label: "对话", field: "Data19", type: "el-input" },
    { label: "允许多人交互", field: "Data20", type: "el-input" },
    { label: "悬浮水面", field: "Data21", type: "el-input" },
    { label: "条件", field: "Data22", type: "el-input" },
    { label: "playerCast", field: "Data23", type: "el-input" },
  ], // GAMEOBJECT_TYPE_GOOBER
  [
    { label: "Timeto2ndfloor", field: "Data0", type: "el-input-number" },
    { label: "startOpen", field: "Data1", type: "el-input" },
    { label: "自动关闭", field: "Data2", type: "el-input" },
    { label: "Reached1stfloor", field: "Data3", type: "el-input" },
    { label: "Reached2ndfloor", field: "Data4", type: "el-input" },
    { label: "SpawnMap", field: "Data5", type: "el-input" },
    { label: "Timeto3rdfloor", field: "Data6", type: "el-input-number" },
    { label: "Reached3rdfloor", field: "Data7", type: "el-input" },
    { label: "Timeto4rdfloor", field: "Data8", type: "el-input-number" },
    { label: "Reached4rdfloor", field: "Data9", type: "el-input" },
    { label: "Timeto5rdfloor", field: "Data10", type: "el-input-number" },
    { label: "Reached5rdfloor", field: "Data11", type: "el-input" },
    { label: "Timeto6rdfloor", field: "Data12", type: "el-input-number" },
    { label: "Reached6rdfloor", field: "Data13", type: "el-input" },
    { label: "Timeto7rdfloor", field: "Data14", type: "el-input-number" },
    { label: "Reached7rdfloor", field: "Data15", type: "el-input" },
    { label: "Timeto8rdfloor", field: "Data16", type: "el-input-number" },
    { label: "Reached8rdfloor", field: "Data17", type: "el-input" },
    { label: "Timeto9rdfloor", field: "Data18", type: "el-input-number" },
    { label: "Reached9rdfloor", field: "Data19", type: "el-input" },
    { label: "Timeto10rdfloor", field: "Data20", type: "el-input-number" },
    { label: "Reached10rdfloor", field: "Data21", type: "el-input" },
    { label: "onlychargeheightcheck", field: "Data22", type: "el-input" },
    { label: "onlychargetimecheck", field: "Data23", type: "el-input" },
  ], // GAMEOBJECT_TYPE_TRANSPORT
  [
    { label: "锁", field: "Data0", type: "el-input" },
    { label: "半径", field: "Data1", type: "el-input-number" },
    { label: "最小伤害", field: "Data2", type: "el-input-number" },
    { label: "最大伤害", field: "Data3", type: "el-input-number" },
    { label: "伤害类型", field: "Data4", type: "el-input" },
    { label: "自动关闭", field: "Data5", type: "el-input" },
    { label: "开启文本", field: "Data6", type: "el-input" },
    { label: "关闭文本", field: "Data7", type: "el-input" },
  ], // GAMEOBJECT_TYPE_AREADAMAGE
  [
    { label: "锁", field: "Data0", type: "el-input" },
    { label: "相机", field: "Data1", type: "el-input" },
    { label: "事件", field: "Data2", type: "el-input" },
    { label: "开启文本", field: "Data3", type: "el-input" },
    { label: "条件", field: "Data4", type: "el-input" },
  ], // GAMEOBJECT_TYPE_CAMERA
  [], // GAMEOBJECT_TYPE_MAPOBJECT
  [
    { label: "交通路线", field: "Data0", type: "taxi-path-selector" },
    { label: "移动速度", field: "Data1", type: "el-input-number" },
    { label: "加速度", field: "Data2", type: "el-input-number" },
    { label: "开始事件", field: "Data3", type: "el-input" },
    { label: "停止事件", field: "Data4", type: "el-input" },
    { label: "transportPhysics", field: "Data5", type: "el-input" },
    { label: "SpawnMap", field: "Data6", type: "el-input" },
    { label: "worldState1", field: "Data7", type: "el-input" },
    { label: "allowstopping", field: "Data8", type: "el-input" },
    { label: "InitStopped", field: "Data9", type: "el-input" },
    { label: "TrueInfiniteAOI", field: "Data10", type: "el-input" },
  ], // GAMEOBJECT_TYPE_MOTRANSPORT
  [], // GAMEOBJECT_TYPE_DUELFLAG
  [], // GAMEOBJECT_TYPE_FISHINGNODE
  [
    { label: "casters", field: "Data0", type: "el-input" },
    { label: "技能", field: "Data1", type: "spell-selector" },
    { label: "animSpell", field: "Data2", type: "spell-selector" },
    { label: "ritualPersistent", field: "Data3", type: "el-switch" },
    { label: "casterTargetSpell", field: "Data4", type: "spell-selector" },
    { label: "casterTargetSpellTargets", field: "Data5", type: "el-switch" },
    { label: "castersGrouped", field: "Data6", type: "el-switch" },
    { label: "ritualNoTargetCheck", field: "Data7", type: "el-input" },
    { label: "条件", field: "Data8", type: "el-input" },
  ], // GAMEOBJECT_TYPE_RITUAL
  [], // GAMEOBJECT_TYPE_MAILBOX
  [{ label: "拍卖行", field: "Data0", type: "auction-house-selector" }], // GAMEOBJECT_TYPE_AUCTIONHOUSE
  [
    { label: "生物", field: "Data0", type: "creature-template-selector" },
    { label: "unknown", field: "Data1", type: "el-input" },
  ], // GAMEOBJECT_TYPE_GUARDPOST
  [
    { label: "技能", field: "Data0", type: "spell-selector" },
    { label: "充能", field: "Data1", type: "el-input-number" },
    { label: "仅队伍", field: "Data2", type: "el-switch" },
    { label: "骑乘可用", field: "Data3", type: "el-switch" },
    { label: "GiganticAOI", field: "Data4", type: "el-input" },
    { label: "条件", field: "Data5", type: "el-input" },
    { label: "playerCast", field: "Data6", type: "el-input" },
    { label: "骑乘不可用", field: "Data7", type: "el-switch" },
  ], // GAMEOBJECT_TYPE_SPELLCASTER
  [
    { label: "最低等级", field: "Data0", type: "el-input-number" },
    { label: "最高等级", field: "Data1", type: "el-input-number" },
    { label: "区域", field: "Data2", type: "area-table-selector" },
  ], // GAMEOBJECT_TYPE_MEETINGSTONE
  [
    { label: "锁", field: "Data0", type: "lock-selector" },
    { label: "pickupSpell", field: "Data1", type: "spell-selector" },
    { label: "半径", field: "Data2", type: "el-input-number" },
    { label: "returnAura", field: "Data3", type: "spell-selector" },
    { label: "returnSpell", field: "Data4", type: "spell-selector" },
    { label: "无伤害免疫", field: "Data5", type: "el-switch" },
    { label: "开启文本", field: "Data6", type: "el-input" },
    { label: "losOK", field: "Data7", type: "el-switch" },
    { label: "条件", field: "Data8", type: "el-input" },
    { label: "playerCast", field: "Data9", type: "el-input" },
    { label: "GiganticAOI", field: "Data10", type: "el-input" },
    { label: "InfiniteAOI", field: "Data11", type: "el-input" },
    { label: "冷却时间", field: "Data12", type: "el-input-number" },
  ], // GAMEOBJECT_TYPE_TRANSPORT
  [
    { label: "半径", field: "Data0", type: "el-input-number" },
    {
      label: "物品掉落",
      field: "Data1",
      type: "game-object-loot-template-selector",
    },
    { label: "最少补货", field: "Data2", type: "el-input-number" },
    { label: "最多补货", field: "Data3", type: "el-input-number" },
    { label: "锁", field: "Data4", type: "el-input" },
  ], // GAMEOBJECT_TYPE_FISHINGHOLE
  [
    { label: "锁", field: "Data0", type: "lock-selector" },
    { label: "事件", field: "Data1", type: "el-input" },
    { label: "pickupSpell", field: "Data2", type: "spell-selector" },
    { label: "无伤害免疫", field: "Data3", type: "el-switch" },
    { label: "开启文本", field: "Data4", type: "el-input" },
    { label: "playerCast", field: "Data5", type: "el-input" },
    { label: "ExpireDuration", field: "Data6", type: "el-input" },
    { label: "GiganticAOI", field: "Data7", type: "el-input" },
    { label: "InfiniteAOI", field: "Data8", type: "el-input" },
    { label: "冷却时间", field: "Data9", type: "el-input-number" },
  ], // GAMEOBJECT_TYPE_FLAGDROP
  [{ label: "areaTrigger", field: "Data0", type: "el-input" }], // GAMEOBJECT_TYPE_MINIGAME
  [], // GAMEOBJECT_TYPE_LOTTERYKIOSK
  [
    { label: "半径", field: "Data0", type: "el-input-number" },
    { label: "技能", field: "Data1", type: "el-input" },
    { label: "worldState1", field: "Data2", type: "el-input" },
    { label: "worldState2", field: "Data3", type: "el-input" },
    { label: "winEventID1", field: "Data4", type: "el-input" },
    { label: "winEventID2", field: "Data5", type: "el-input" },
    { label: "contestedEventID1", field: "Data6", type: "el-input" },
    { label: "contestedEventID2", field: "Data7", type: "el-input" },
    { label: "progressEventID1", field: "Data8", type: "el-input" },
    { label: "progressEventID2", field: "Data9", type: "el-input" },
    { label: "neutralEventID1", field: "Data10", type: "el-input" },
    { label: "neutralEventID2", field: "Data11", type: "el-input" },
    { label: "neutralPercent", field: "Data12", type: "el-input-number" },
    { label: "worldstate3", field: "Data13", type: "el-input" },
    { label: "minSuperiority", field: "Data14", type: "el-input-number" },
    { label: "maxSuperiority", field: "Data15", type: "el-input-number" },
    { label: "minTime", field: "Data16", type: "el-input-number" },
    { label: "maxTime", field: "Data17", type: "el-input-number" },
    { label: "更大", field: "Data18", type: "el-switch" },
    { label: "高亮", field: "Data19", type: "el-input" },
    { label: "startingValue", field: "Data20", type: "el-input" },
    { label: "unidirectional", field: "Data21", type: "el-input" },
    { label: "killbonustime", field: "Data22", type: "el-input" },
    { label: "speedWorldState1", field: "Data23", type: "el-input" },
  ], // GAMEOBJECT_TYPE_CAPTUREPOINT
  [
    { label: "startOpen", field: "Data0", type: "el-switch" },
    { label: "半径", field: "Data1", type: "el-input-number" },
    { label: "光环1", field: "Data2", type: "spell-selector" },
    { label: "条件1", field: "Data3", type: "el-input" },
    { label: "光环2", field: "Data4", type: "spell-selector" },
    { label: "条件2", field: "Data5", type: "el-input" },
    { label: "serverOnly", field: "Data6", type: "el-input" },
  ], // GAMEOBJECT_TYPE_AURAGENERATOR
  [
    { label: "地图", field: "Data0", type: "map-selector" },
    { label: "难度", field: "Data1", type: "el-input" },
    { label: "英雄难度", field: "Data2", type: "el-input" },
    { label: "史诗难度", field: "Data3", type: "el-input" },
    { label: "传奇难度", field: "Data4", type: "el-input" },
    { label: "HeroicAttachment", field: "Data5", type: "el-input" },
    { label: "ChallengeAttachment", field: "Data6", type: "el-input" },
    { label: "DifficultyAnimations", field: "Data7", type: "el-input" },
    { label: "LargeAOI", field: "Data8", type: "el-input" },
    { label: "GiganticAOI", field: "Data9", type: "el-input" },
    { label: "Legacy", field: "Data10", type: "el-input" },
  ], // GAMEOBJECT_TYPE_DUNGEONDIFFICULTY
  [
    { label: "高度", field: "Data0", type: "el-input-number" },
    { label: "高度偏移", field: "Data1", type: "el-input-number" },
    { label: "SitAnimKit", field: "Data2", type: "el-input" },
  ], // GAMEOBJECT_TYPE_BARBER_CHAIR
  [
    { label: "intactNumHits", field: "Data0", type: "el-input-number" },
    { label: "creditProxyCreature", field: "Data1", type: "el-input" },
    { label: "state1Name", field: "Data2", type: "el-input" },
    { label: "intactEvent", field: "Data3", type: "el-input" },
    { label: "damagedDisplayId", field: "Data4", type: "el-input" },
    { label: "damagedNumHits", field: "Data5", type: "el-input" },
    { label: "empty3", field: "Data6", type: "el-input" },
    { label: "empty4", field: "Data7", type: "el-input" },
    { label: "empty5", field: "Data8", type: "el-input" },
    { label: "damagedEvent", field: "Data9", type: "el-input" },
    { label: "destroyedDisplayId", field: "Data10", type: "el-input" },
    { label: "empty7", field: "Data11", type: "el-input" },
    { label: "empty8", field: "Data12", type: "el-input-number" },
    { label: "empty9", field: "Data13", type: "el-input" },
    { label: "destroyedEvent", field: "Data14", type: "el-input-number" },
    { label: "empty10", field: "Data15", type: "el-input-number" },
    { label: "debuildingTimeSecs", field: "Data16", type: "el-input-number" },
    { label: "empty11", field: "Data17", type: "el-input-number" },
    { label: "destructibleData", field: "Data18", type: "el-switch" },
    { label: "rebuildingEvent", field: "Data19", type: "el-input" },
    { label: "empty12", field: "Data20", type: "el-input" },
    { label: "empty13", field: "Data21", type: "el-input" },
    { label: "damageEvent", field: "Data22", type: "el-input" },
    { label: "empty14", field: "Data23", type: "el-input" },
  ], // GAMEOBJECT_TYPE_DESTRUCTIBLE_BUILDING
  [], // GAMEOBJECT_TYPE_GUILD_BANK
  [
    { label: "whenToPause", field: "Data0", type: "el-input-number" },
    { label: "startOpen", field: "Data1", type: "el-input" },
    { label: "自动关闭", field: "Data2", type: "el-input" },
    { label: "BlocksPathsDown", field: "Data3", type: "el-input" },
    { label: "PathBlockerBump", field: "Data4", type: "el-input" },
  ], // GAMEOBJECT_TYPE_DESTRUCTIBLE_BUILDING
];

const flags = [
  {
    index: 0,
    flag: 1,
    name: "正在使用",
    comment: "物体正在使用，动画播放完之前不能交互。",
  },
  {
    index: 1,
    flag: 2,
    name: "被锁住",
    comment: "锁住物品，面板上会显示“已锁”，需要钥匙技能等打开。",
  },
  {
    index: 2,
    flag: 4,
    name: "不能交互",
    comment: "不能点击，不能交互。",
  },
  {
    index: 3,
    flag: 8,
    name: "不能传送",
    comment: "物体不能传送，比如船、电梯和车。",
  },
  {
    index: 4,
    flag: 16,
    name: "不可选中",
    comment: "不可选中，GM模式下也不行。",
  },
  {
    index: 5,
    flag: 32,
    name: "从不刷新",
    comment: "从不刷新，比如有开关模式的物体（门）。",
  },
  {
    index: 6,
    flag: 64,
    name: "被触发",
    comment: "被触发的，比如召唤出的物体，被其他技能或者事件触发。",
  },
  {
    index: 7,
    flag: 128,
    name: "未知",
    comment: "未知",
  },
  {
    index: 8,
    flag: 256,
    name: "未知",
    comment: "未知",
  },
  {
    index: 9,
    flag: 512,
    name: "被伤害",
    comment: "物体被围攻伤害",
  },
  {
    index: 10,
    flag: 1024,
    name: "被破坏",
    comment: "物体已被破坏",
  },
  {
    index: 11,
    flag: 2048,
    name: "未知",
    comment: "未知",
  },
  {
    index: 12,
    flag: 4096,
    name: "未知",
    comment: "未知",
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
    name: "未知",
    comment: "未知",
  },
  {
    index: 15,
    flag: 32768,
    name: "未知",
    comment: "未知",
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
    name: "未知",
    comment: "未知",
  },
  {
    index: 18,
    flag: 262144,
    name: "未知",
    comment: "未知",
  },
  {
    index: 19,
    flag: 524288,
    name: "未知",
    comment: "未知",
  },
  {
    index: 20,
    flag: 1048576,
    name: "未知",
    comment: "未知",
  },
  {
    index: 21,
    flag: 2097152,
    name: "未知",
    comment: "未知",
  },
  {
    index: 22,
    flag: 4194304,
    name: "未知",
    comment: "未知",
  },
];

export { types, datas, flags };
