import 'dart:io';
import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/game_asset/game_icon_extractor.dart';
import 'package:foxy/infrastructure/game_asset/game_icon_paths.dart';
import 'package:foxy/infrastructure/game_asset/game_mpq_source.dart';
import 'package:path/path.dart' as p;

void main() {
  late Directory tempDir;
  late Directory clientRoot;
  late Directory outputDir;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('foxy_icons_test_');
    clientRoot = Directory(p.join(tempDir.path, 'client'));
    clientRoot.createSync(recursive: true);
    outputDir = Directory(p.join(tempDir.path, 'out'));
    outputDir.createSync();
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  List<int> content(int marker) => [marker, 1, 2, 3];

  group('findLocaleDataDir', () {
    test('按偏好顺序命中 zhCN', () {
      _buildFakeClient(
        clientRoot,
        locale: 'enUS',
        archives: {'locale-enUS.MPQ': {}},
      );
      _buildFakeClient(
        clientRoot,
        locale: 'zhCN',
        archives: {'locale-zhCN.MPQ': {}},
      );
      final dir = GameIconExtractor.findLocaleDataDir(clientRoot.path);
      expect(p.basename(dir!), 'zhCN');
    });

    test('无偏好命中时取第一个含 MPQ 的 locale 目录', () {
      _buildFakeClient(
        clientRoot,
        locale: 'frFR',
        archives: {'locale-frFR.MPQ': {}},
      );
      final dir = GameIconExtractor.findLocaleDataDir(clientRoot.path);
      expect(p.basename(dir!), 'frFR');
    });

    test('非客户端目录返回 null', () {
      expect(GameIconExtractor.findLocaleDataDir(tempDir.path), isNull);
      expect(
        GameIconExtractor.findLocaleDataDir(p.join(clientRoot.path, '不存在')),
        isNull,
      );
    });
  });

  group('archiveChain', () {
    test('locale 目录全 MPQ 按类别排序（自定义 patch 最后）', () {
      final dataDir = _buildFakeClient(
        clientRoot,
        archives: {
          'patch-zhCN-2.MPQ': {},
          'patch-zhCN.MPQ': {},
          'locale-zhCN.MPQ': {},
          'patch-Z.MPQ': {}, // 自定义名 patch
          'zzz_custom.MPQ': {},
        },
      );
      final chain = GameIconExtractor.archiveChain(
        p.join(clientRoot.path, 'Data'),
        dataDir.path,
        'zhCN',
      );
      expect(chain.map(p.basename).toList(), [
        'locale-zhCN.MPQ', // 1 locale 基础
        'patch-zhCN.MPQ', // 3 locale patch
        'patch-zhCN-2.MPQ',
        'patch-Z.MPQ', // 4 自定义
        'zzz_custom.MPQ',
      ]);
    });

    test('根目录官方大包最低优先级，且被 locale 覆盖', () {
      _buildFakeClient(
        clientRoot,
        locale: 'zhCN',
        archives: {'locale-zhCN.MPQ': {}},
      );
      final dataDir = Directory(p.join(clientRoot.path, 'Data'));
      // 根目录放官方大包
      for (final name in ['common.MPQ', 'patch.MPQ', 'patch-2.MPQ']) {
        File(p.join(dataDir.path, name)).writeAsBytesSync([0]);
      }
      final chain = GameIconExtractor.archiveChain(
        dataDir.path,
        p.join(dataDir.path, 'zhCN'),
        'zhCN',
      );
      expect(chain.map(p.basename).toList(), [
        'common.MPQ',
        'patch.MPQ',
        'patch-2.MPQ',
        'locale-zhCN.MPQ',
      ]);
    });

    test('根目录自定义 MPQ 最高优先级', () {
      _buildFakeClient(
        clientRoot,
        locale: 'zhCN',
        archives: {'locale-zhCN.MPQ': {}},
      );
      final dataDir = Directory(p.join(clientRoot.path, 'Data'));
      File(p.join(dataDir.path, 'custom-icons.MPQ')).writeAsBytesSync([0]);
      final chain = GameIconExtractor.archiveChain(
        dataDir.path,
        p.join(dataDir.path, 'zhCN'),
        'zhCN',
      );
      expect(chain.map(p.basename).toList(), [
        'locale-zhCN.MPQ',
        'custom-icons.MPQ',
      ]);
    });
  });

  group('extract', () {
    test('高优先级归档覆盖同名图标', () {
      _buildFakeClient(
        clientRoot,
        archives: {
          'locale-zhCN.MPQ': {r'Interface\Icons\INV_Foo.blp': content(1)},
          'patch-zhCN.MPQ': {
            r'Interface\Icons\Inv_Foo.blp': content(2), // 大小写不同
          },
        },
      );
      final result = _extractor(clientRoot, outputDir, {
        'locale-zhCN.MPQ': {r'Interface\Icons\INV_Foo.blp': content(1)},
        'patch-zhCN.MPQ': {r'Interface\Icons\Inv_Foo.blp': content(2)},
      }).extract();

      expect(result.success, isTrue);
      expect(result.extracted, 1);
      final dest = File(p.join(outputDir.path, 'inv_foo.blp'));
      expect(dest.existsSync(), isTrue);
      expect(dest.readAsBytesSync(), content(2)); // 高优先级胜出
    });

    test('收录 Spellbook 并以纯名扁平落盘（含 .tga 路径归一）', () {
      _buildFakeClient(
        clientRoot,
        archives: {
          'locale-zhCN.MPQ': {
            r'Interface\Icons\INV_Shoulder_94.blp': content(1),
            r'Interface\Spellbook\UI-Glyph-Rune-1.blp': content(2),
          },
        },
      );
      final result = _extractor(clientRoot, outputDir, {
        'locale-zhCN.MPQ': {
          r'Interface\Icons\INV_Shoulder_94.blp': content(1),
          r'Interface\Spellbook\UI-Glyph-Rune-1.blp': content(2),
        },
      }).extract();

      expect(result.success, isTrue);
      expect(result.extracted, 2);
      // DBC 里的 .tga 残留路径归一到同一纯名
      expect(
        GameIconPaths.normalizeIconName(r'Interface\Icons\INV_Shoulder_94.tga'),
        'inv_shoulder_94',
      );
      expect(
        File(p.join(outputDir.path, 'inv_shoulder_94.blp')).existsSync(),
        isTrue,
      );
      expect(
        File(p.join(outputDir.path, 'ui-glyph-rune-1.blp')).existsSync(),
        isTrue,
      );
    });

    test('已存在产物跳过，重复执行幂等', () {
      _buildFakeClient(
        clientRoot,
        archives: {
          'locale-zhCN.MPQ': {r'Interface\Icons\INV_Foo.blp': content(1)},
        },
      );
      final extractor = _extractor(clientRoot, outputDir, {
        'locale-zhCN.MPQ': {r'Interface\Icons\INV_Foo.blp': content(1)},
      });
      File(p.join(outputDir.path, 'inv_foo.blp')).writeAsBytesSync(content(9));

      final result = extractor.extract();
      expect(result.extracted, 0);
      expect(result.skipped, 1);
      expect(result.success, isTrue);
      expect(
        File(p.join(outputDir.path, 'inv_foo.blp')).readAsBytesSync(),
        content(9),
      );
    });

    test('归档打开失败计入错误但不阻断其他归档', () {
      _buildFakeClient(
        clientRoot,
        archives: {
          'locale-zhCN.MPQ': {r'Interface\Icons\INV_Foo.blp': content(1)},
          'patch-zhCN.MPQ': {r'Interface\Icons\INV_Bar.blp': content(2)},
        },
      );
      final result = _extractor(clientRoot, outputDir, {
        'locale-zhCN.MPQ': {r'Interface\Icons\INV_Foo.blp': content(1)},
        // patch-zhCN.MPQ 缺失 → openSource 抛错
      }).extract();

      expect(result.extracted, 1);
      expect(result.failed, 1);
      expect(result.errors.single, contains('patch-zhCN.MPQ'));
      expect(result.success, isFalse);
    });

    test('取消：提前终止并标记 cancelled', () {
      _buildFakeClient(
        clientRoot,
        archives: {
          'locale-zhCN.MPQ': {
            r'Interface\Icons\INV_Aaa.blp': content(1),
            r'Interface\Icons\INV_Bbb.blp': content(2),
            r'Interface\Icons\INV_Ccc.blp': content(3),
          },
        },
      );
      // 扫描阶段调用 1 次 + 每文件 1 次；在第 2 个文件处触发取消。
      var cancelledAfter = 2;
      final result = _extractor(clientRoot, outputDir, {
        'locale-zhCN.MPQ': {
          r'Interface\Icons\INV_Aaa.blp': content(1),
          r'Interface\Icons\INV_Bbb.blp': content(2),
          r'Interface\Icons\INV_Ccc.blp': content(3),
        },
      }).extract(isCancelled: () => cancelledAfter-- <= 0);

      expect(result.cancelled, isTrue);
      expect(result.extracted, 1);
      expect(
        result.skipped + result.extracted + result.failed,
        1,
        reason: '取消后不再继续提取',
      );
    });

    test('根目录自定义 MPQ 覆盖官方 locale 包的同名图标', () {
      _buildFakeClient(
        clientRoot,
        archives: {
          'locale-zhCN.MPQ': {r'Interface\Icons\INV_Foo.blp': content(1)},
        },
      );
      // 根目录自定义 patch（自定义客户端最常见形态）
      final dataDir = Directory(p.join(clientRoot.path, 'Data'));
      final customArchives = <String, Map<String, List<int>>>{
        'zzz_custom.MPQ': {
          r'Interface\Icons\INV_Foo.blp': content(9),
          r'Interface\Icons\INV_Custom_Only.blp': content(7),
        },
      };
      File(p.join(dataDir.path, 'zzz_custom.MPQ')).writeAsBytesSync([0]);
      final result = _extractor(clientRoot, outputDir, {
        ...{
          'locale-zhCN.MPQ': {r'Interface\Icons\INV_Foo.blp': content(1)},
        },
        ...customArchives,
      }).extract();

      expect(result.success, isTrue);
      expect(result.extracted, 2);
      // 官方图标被自定义包覆盖
      expect(
        File(p.join(outputDir.path, 'inv_foo.blp')).readAsBytesSync(),
        content(9),
      );
      // 自定义包新增图标被收录
      expect(
        File(p.join(outputDir.path, 'inv_custom_only.blp')).existsSync(),
        isTrue,
      );
    });

    test('非客户端目录返回失败结果', () {
      final result = _extractor(tempDir, outputDir, const {}).extract();
      expect(result.success, isFalse);
      expect(result.failed, 1);
      expect(result.errors.single, contains('Data'));
    });
  });
}

/// 在临时目录中搭建伪客户端结构：`client/Data/<locale>/<归档>.MPQ`。
Directory _buildFakeClient(
  Directory root, {
  String locale = 'zhCN',
  Map<String, Map<String, List<int>>> archives = const {},
}) {
  final dataDir = Directory(p.join(root.path, 'Data', locale));
  dataDir.createSync(recursive: true);
  archives.forEach((name, files) {
    File(p.join(dataDir.path, name)).writeAsBytesSync([0]);
  });
  return dataDir;
}

/// 构造提取器：openSource 按归档名返回内存假源。
GameIconExtractor _extractor(
  Directory clientRoot,
  Directory outputDir,
  Map<String, Map<String, List<int>>> archives, {
  Map<String, _FakeMpqSource>? created,
}) {
  return GameIconExtractor(
    openSource: (archivePath) {
      final name = p.basename(archivePath);
      final files = archives[name];
      if (files == null) {
        // 模拟真实环境下归档损坏/无法打开。
        throw StateError('cannot open archive: $name');
      }
      final source = _FakeMpqSource(files);
      created?[name] = source;
      return source;
    },
    clientDir: clientRoot.path,
    outputDir: outputDir.path,
  );
}

/// 内存 MPQ 假源。
final class _FakeMpqSource implements GameMpqSource {
  /// 归档内路径（`\` 分隔）→ 内容字节。内容首字节 = 标记值，用于验证覆盖。
  final Map<String, List<int>> _files;

  bool closed = false;
  int extractCalls = 0;
  _FakeMpqSource(this._files);

  @override
  List<String> get files => _files.keys.toList();

  @override
  void close() {
    closed = true;
  }

  @override
  Uint8List extract(String name) {
    extractCalls++;
    final data = _files[name];
    if (data == null) {
      throw StateError('not found: $name');
    }
    return Uint8List.fromList(data);
  }
}
