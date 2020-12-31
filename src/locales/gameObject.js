const flags = [
  {
    index: 0,
    flag: 1,
    name: "正在使用",
    comment: "物体正在使用，动画播放完之前不能交互。"
  },
  {
    index: 1,
    flag: 2,
    name: "被锁住",
    comment: "锁住物品，面板上会显示“已锁”，需要钥匙技能等打开。"
  },
  {
    index: 2,
    flag: 4,
    name: "不能交互",
    comment: "不能点击，不能交互。"
  },
  {
    index: 3,
    flag: 8,
    name: "不能传送",
    comment: "物体不能传送，比如船、电梯和车。"
  },
  {
    index: 4,
    flag: 16,
    name: "不可选中",
    comment: "不可选中，GM模式下也不行。"
  },
  {
    index: 5,
    flag: 32,
    name: "从不刷新",
    comment: "从不刷新，比如有开关模式的物体（门）。"
  },
  {
    index: 6,
    flag: 64,
    name: "被触发",
    comment: "被触发的，比如召唤出的物体，被其他技能或者事件触发。"
  },
  {
    index: 7,
    flag: 128,
    name: "未知",
    comment: ""
  },
  {
    index: 8,
    flag: 256,
    name: "未知",
    comment: ""
  },
  {
    index: 9,
    flag: 512,
    name: "被伤害",
    comment: "物体被围攻伤害"
  },
  {
    index: 10,
    flag: 1024,
    name: "被破坏",
    comment: "物体已被破坏"
  },
  {
    index: 11,
    flag: 2048,
    name: "未知",
    comment: ""
  },
  {
    index: 12,
    flag: 4096,
    name: "未知",
    comment: ""
  },
  {
    index: 13,
    flag: 8192,
    name: "未知",
    comment: ""
  },
  {
    index: 14,
    flag: 16384,
    name: "未知",
    comment: ""
  },
  {
    index: 15,
    flag: 32768,
    name: "未知",
    comment: ""
  },
  {
    index: 16,
    flag: 65536,
    name: "未知",
    comment: ""
  },
  {
    index: 17,
    flag: 131072,
    name: "未知",
    comment: ""
  },
  {
    index: 18,
    flag: 262144,
    name: "未知",
    comment: ""
  },
  {
    index: 19,
    flag: 524288,
    name: "未知",
    comment: ""
  },
  {
    index: 20,
    flag: 1048576,
    name: "未知",
    comment: ""
  },
  {
    index: 21,
    flag: 2097152,
    name: "未知",
    comment: ""
  },
  {
    index: 22,
    flag: 4194304,
    name: "未知",
    comment: ""
  }
];

export { flags };
