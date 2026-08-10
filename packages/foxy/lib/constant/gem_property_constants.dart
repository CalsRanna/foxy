abstract final class GemPropertyConstants {
  /// GemProperties.dbc `Type` values consumed as `SocketColor` masks.
  static const gemPropertyColorOptions = <int, String>{
    0x01: '多彩',
    0x02: '红色',
    0x04: '黄色',
    0x08: '蓝色',
    0x06: '橙色（红色 + 黄色）',
    0x0a: '紫色（红色 + 蓝色）',
    0x0c: '绿色（黄色 + 蓝色）',
    0x0e: '棱彩（红色 + 黄色 + 蓝色）',
  };
}
