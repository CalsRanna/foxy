import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/game_asset/game_icon_cache.dart';
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
    File('test/fixture/icons/fixture_dxt1.blp').copySync(
      p.join(iconDir.path, 'fixture_dxt1.blp'),
    );
    File('test/fixture/icons/fixture_dxt3.blp').copySync(
      p.join(iconDir.path, 'fixture_dxt3.blp'),
    );
  });

  tearDown(() {
    // Remove the staged data/icon directory (and its parent) created in
    // setUp.
    Directory(p.dirname(iconDir.path)).deleteSync(recursive: true);
  });

  String blp(String name) => p.join(iconDir.path, '$name.blp');

  Widget iconApp(
    GameIconCache cache, {
    String rawPath = 'fixture_dxt1',
    double size = 40,
  }) {
    return MaterialApp(
      home: Center(
        child: FoxyGameAssetIcon(
          rawPath: 'Interface\\Icons\\$rawPath',
          size: size,
          cache: cache,
        ),
      ),
    );
  }

  testWidgets('图标原件被缓存驱逐后,已显示的图标重绘不崩溃', (tester) async {
    final cache = GameIconCache(maxEntries: 1);
    // File IO cannot complete inside testWidgets' fake-async zone, so
    // pre-decode through runAsync; the widget's own load then hits the
    // cache and returns synchronously. The preload handle is kept alive
    // until the end and released there.
    late ui.Image preloaded;
    await tester.runAsync(() async {
      preloaded = (await cache.load(blp('fixture_dxt1')))!;
    });

    await tester.pumpWidget(iconApp(cache));
    await tester.pumpAndSettle();
    expect(find.byType(RawImage), findsOneWidget);

    // Evict the fixture_dxt1 original: with capacity 1, loading dxt3
    // pushes it out and disposes it.
    await tester.runAsync(() async {
      final evicted = await cache.load(blp('fixture_dxt3'));
      evicted!.dispose();
    });
    expect(cache.contains(blp('fixture_dxt1')), isFalse);

    // Changing the size forces a relayout/repaint. Before the fix the
    // State held the disposed original and paintImage asserted "Cannot
    // paint an image that is disposed"; with the fix the State holds its
    // own clone, unaffected by the eviction.
    await tester.pumpWidget(iconApp(cache, size: 48));
    expect(find.byType(RawImage), findsOneWidget);

    // Unmounting disposes the clone; must not throw.
    await tester.pumpWidget(const SizedBox());
    preloaded.dispose();
  });

  testWidgets('换图标时释放旧图并加载新图', (tester) async {
    final cache = GameIconCache(maxEntries: 2);
    late ui.Image preloaded;
    late ui.Image preloadedOther;
    await tester.runAsync(() async {
      preloaded = (await cache.load(blp('fixture_dxt1')))!;
      preloadedOther = (await cache.load(blp('fixture_dxt3')))!;
    });

    await tester.pumpWidget(iconApp(cache));
    await tester.pumpAndSettle();
    expect(find.byType(RawImage), findsOneWidget);

    // Switch to dxt3: the State releases the old clone and loads the new
    // icon from cache.
    await tester.pumpWidget(iconApp(cache, rawPath: 'fixture_dxt3'));
    await tester.pumpAndSettle();
    expect(find.byType(RawImage), findsOneWidget);

    await tester.pumpWidget(const SizedBox());
    preloaded.dispose();
    preloadedOther.dispose();
  });
}
