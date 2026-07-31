import 'dart:typed_data';

import 'package:warcrafty/warcrafty.dart';

/// MPQ 归档的只读抽象，供图标提取器注入（测试可替换为内存假实现）。
abstract interface class GameMpqSource {
  /// 归档内全部文件路径（`\` 分隔）。
  List<String> get files;

  /// 提取归档内文件为内存字节。
  Uint8List extract(String name);

  void close();
}

/// 基于 warcrafty（纯 Dart MPQ）的实现。
final class WarcraftyMpqSource implements GameMpqSource {
  WarcraftyMpqSource(String archivePath)
    : _archive = MpqArchive.open(archivePath);

  final MpqArchive _archive;

  @override
  List<String> get files => _archive.files;

  @override
  Uint8List extract(String name) => _archive.extract(name);

  @override
  void close() => _archive.close();
}
