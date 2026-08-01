import 'dart:typed_data';

import 'package:warcrafty/warcrafty.dart';

/// MPQ 归档的只读抽象，供图标提取器注入（测试可替换为内存假实现）。
abstract interface class GameMpqSource {
  /// 归档内全部文件路径（`\` 分隔）。
  List<String> get files;

  void close();

  /// 提取归档内文件为内存字节。
  Uint8List extract(String name);
}

/// 基于 warcrafty（纯 Dart MPQ）的实现。
final class WarcraftyMpqSource implements GameMpqSource {
  final MpqArchive _archive;

  WarcraftyMpqSource(String archivePath)
    : _archive = MpqArchive.open(archivePath);

  @override
  List<String> get files => _archive.files;

  @override
  void close() => _archive.close();

  @override
  Uint8List extract(String name) => _archive.extract(name);
}
