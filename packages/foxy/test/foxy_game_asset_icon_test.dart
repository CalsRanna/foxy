import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/game_asset/blp_icon_provider.dart';
import 'package:foxy/widget/foxy_game_asset_icon.dart';
import 'package:path/path.dart' as p;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory iconDir;

  setUp(() {
    // GameIconPaths resolves against the runtime working directory
    // (data/icon under the package root); stage the fixture BLPs there.
    iconDir = Directory(p.join(Directory.current.path, 'data', 'icon'))
      ..createSync(recursive: true);
    for (final name in ['fixture_dxt1', 'fixture_dxt3', 'fixture_dxt5']) {
      File('test/fixture/icons/$name.blp').copySync(
        p.join(iconDir.path, '$name.blp'),
      );
    }
  });

  tearDown(() {
    // Remove the staged data/icon directory (and its parent) created in
    // setUp.
    Directory(p.dirname(iconDir.path)).deleteSync(recursive: true);
  });

  Widget iconApp({String rawPath = 'fixture_dxt1', double size = 40}) {
    return MaterialApp(
      home: Center(
        child: FoxyGameAssetIcon(
          rawPath: 'Interface\\Icons\\$rawPath',
          size: size,
        ),
      ),
    );
  }

  /// Preloads an icon into the image cache (real IO, outside the widget
  /// test's fake-async zone) so the widget's resolve hits the cache.
  ///
  /// Resolving through [ImageProvider.resolve] is required: the cache only
  /// moves a completed image into its keep-alive store via the internal
  /// pending-image listener, which a direct loadImage call bypasses.
  Future<void> preload(String name) async {
    final stream = BlpIconProvider(rawPath: name).resolve(
      const ImageConfiguration(),
    );
    final completer = Completer<ImageInfo?>();
    late ImageStreamListener listener;
    listener = ImageStreamListener(
      (info, synchronousCall) {
        if (!completer.isCompleted) completer.complete(info);
      },
      onError: (error, stackTrace) {
        if (!completer.isCompleted) completer.complete(null);
      },
    );
    stream.addListener(listener);
    final info = await completer.future;
    // The delivered image is a clone; releasing it does not affect the
    // completer's current image.
    info?.dispose();
    // With the listener removed, the cache's keep-alive handle keeps the
    // image resident for the widget's resolve.
    stream.removeListener(listener);
  }

  testWidgets('成功图标显示 RawImage', (tester) async {
    await tester.runAsync(() => preload('fixture_dxt1'));
    await tester.pumpWidget(iconApp());
    await tester.pumpAndSettle();
    expect(find.byType(RawImage), findsOneWidget);
  });

  testWidgets('缺失图标显示占位图标', (tester) async {
    // 文件 IO 无法在 fake-async 区完成,先在真实异步区触发一次缺失路径
    // (记录负缓存);之后 widget 的 resolve 命中负缓存,错误同步到达
    // errorBuilder,无需 IO。
    await tester.runAsync(() => preload('no_such_icon'));
    await tester.pumpWidget(iconApp(rawPath: 'no_such_icon'));
    await tester.pumpAndSettle();
    expect(find.byType(RawImage), findsNothing);
    expect(find.byType(Icon), findsOneWidget);
  });

  testWidgets('图标被缓存驱逐后,仍在显示的图标重绘不崩溃', (tester) async {
    await tester.runAsync(() => preload('fixture_dxt1'));
    await tester.pumpWidget(iconApp());
    await tester.pumpAndSettle();
    expect(find.byType(RawImage), findsOneWidget);

    // 从 keep-alive 缓存驱逐 dxt1(includeLive: false:正在显示、有 live
    // 引用的图片只释放缓存句柄,底层纹理被 ImageCache 保活 —— 与
    // _checkCacheSize 的容量驱逐同一路径)。
    await tester.runAsync(() async {
      await preload('fixture_dxt3');
      final evicted = PaintingBinding.instance.imageCache.evict(
        const BlpIconKey('fixture_dxt1'),
        includeLive: false,
      );
      expect(evicted, isTrue);
    });

    // 改尺寸强制一帧重排重绘:修复前这里会 paintImage 断言
    // "Cannot paint an image that is disposed"。
    await tester.pumpWidget(iconApp(size: 48));
    expect(find.byType(RawImage), findsOneWidget);

    // 卸载无泄漏报错。
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('换图标时正常加载新图标', (tester) async {
    await tester.runAsync(() async {
      await preload('fixture_dxt1');
      await preload('fixture_dxt3');
    });
    await tester.pumpWidget(iconApp());
    await tester.pumpAndSettle();
    expect(find.byType(RawImage), findsOneWidget);

    await tester.pumpWidget(iconApp(rawPath: 'fixture_dxt3'));
    await tester.pumpAndSettle();
    expect(find.byType(RawImage), findsOneWidget);
  });
}
