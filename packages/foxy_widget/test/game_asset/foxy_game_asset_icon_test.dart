import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:foxy_widget/foxy_widget.dart';
import 'package:path/path.dart' as p;

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory iconDir;

  setUp(() {
    // GameIconPaths resolves against the runtime working directory
    // (data/icon under the package root); stage the fixture BLPs there.
    iconDir = Directory(p.join(Directory.current.path, 'data', 'icon'))
      ..createSync(recursive: true);
    for (final name in [
      'foxy_fixture_dxt1',
      'foxy_fixture_dxt3',
      'foxy_fixture_dxt5',
    ]) {
      File('test/fixture/icons/$name.blp')
          .copySync(p.join(iconDir.path, '$name.blp'));
    }
  });

  tearDown(() {
    // Remove the staged data/icon directory (and its parent) created in
    // setUp.
    Directory(p.dirname(iconDir.path)).deleteSync(recursive: true);
  });

  Widget iconApp({String rawPath = 'foxy_fixture_dxt1', double size = 40}) {
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
    final stream = FoxyBlpIconProvider(rawPath: name)
        .resolve(const ImageConfiguration());
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

  testWidgets('A loaded icon displays a RawImage', (tester) async {
    await tester.runAsync(() => preload('foxy_fixture_dxt1'));
    await tester.pumpWidget(iconApp());
    await tester.pumpAndSettle();
    expect(find.byType(RawImage), findsOneWidget);
  });

  testWidgets('A missing icon displays a placeholder', (tester) async {
    await tester.pumpWidget(iconApp(rawPath: 'no_such_icon'));
    // Use runAsync for the missing-file check because it requires real file I/O.
    // The errorBuilder displays the placeholder icon.
    await tester.runAsync(
      () => Future<void>.delayed(const Duration(milliseconds: 50)),
    );
    await tester.pumpAndSettle();
    expect(find.byType(RawImage), findsNothing);
    expect(find.byType(Icon), findsOneWidget);
  });

  testWidgets('A visible icon repaints safely after cache eviction', (
    tester,
  ) async {
    await tester.runAsync(() => preload('foxy_fixture_dxt1'));
    await tester.pumpWidget(iconApp());
    await tester.pumpAndSettle();
    expect(find.byType(RawImage), findsOneWidget);

    // Evict dxt1 from the keep-alive cache while it is still visible, with
    // includeLive set to false. ImageCache retains the live texture just as
    // _checkCacheSize would when evicting the same path for capacity.
    await tester.runAsync(() async {
      await preload('foxy_fixture_dxt3');
      final evicted = PaintingBinding.instance.imageCache.evict(
        const FoxyBlpIconKey('foxy_fixture_dxt1'),
        includeLive: false,
      );
      expect(evicted, isTrue);
    });

    // Resize to force layout and paint. Before the fix, paintImage asserted
    // with "Cannot paint an image that is disposed".
    await tester.pumpWidget(iconApp(size: 48));
    expect(find.byType(RawImage), findsOneWidget);

    // Unmount without triggering an image lifetime error.
    await tester.pumpWidget(const SizedBox());
  });

  testWidgets('Changing the icon loads the replacement', (tester) async {
    await tester.runAsync(() async {
      await preload('foxy_fixture_dxt1');
      await preload('foxy_fixture_dxt3');
    });
    await tester.pumpWidget(iconApp());
    await tester.pumpAndSettle();
    expect(find.byType(RawImage), findsOneWidget);

    await tester.pumpWidget(iconApp(rawPath: 'foxy_fixture_dxt3'));
    await tester.pumpAndSettle();
    expect(find.byType(RawImage), findsOneWidget);
  });
}
