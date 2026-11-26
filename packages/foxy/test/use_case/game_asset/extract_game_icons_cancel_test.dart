import 'dart:io';
import 'dart:isolate';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/use_case/game_asset/extract_game_icons_use_case.dart';
import 'package:foxy_game_file/foxy_game_file.dart';
import 'package:path/path.dart' as p;

/// Regression test for the cancel-then-retry race: the fallback timer in
/// [ExtractGameIconsUseCase.cancel] used to read the mutable
/// `_activeIsolate` field, so a retry started within the grace window had
/// its isolate force-killed by the *old* timer and the new task never
/// settled (permanent BusyException thereafter).
///
/// A scripted worker entry makes the timing deterministic: cancelling it
/// terminates it immediately, otherwise it reports success after a fixed
/// delay — so the second task is guaranteed to still be running when the
/// stale cancel timer fires.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late Directory tempDir;
  late Directory clientRoot;
  late Directory outputDir;
  late _TempConfigUtil configUtil;

  setUp(() {
    tempDir = Directory.systemTemp.createTempSync('foxy_icon_cancel_test_');
    clientRoot = Directory(p.join(tempDir.path, 'client'))..createSync();
    outputDir = Directory(p.join(tempDir.path, 'out'))..createSync();
    configUtil = _TempConfigUtil(tempDir.path);
  });

  tearDown(() {
    tempDir.deleteSync(recursive: true);
  });

  ExtractGameIconsUseCase buildUseCase({
    Duration cancelGraceMs = const Duration(milliseconds: 500),
  }) {
    return ExtractGameIconsUseCase(
      configUtil: configUtil,
      outputDir: outputDir.path,
      cancelGraceMs: cancelGraceMs,
      workerEntry: _scriptedWorker,
    );
  }

  test('A previous cancellation timer cannot kill an immediate retry', () async {
    final useCase = buildUseCase();

    // Give the isolate 200 ms to report its control port before canceling job A.
    // The scripted worker reports cancellation immediately, so job A ends
    // while its 500 ms grace timer would still be pending.
    final stopwatch = Stopwatch()..start();
    final first = useCase.execute(
      ExtractGameIconsInput(clientDir: clientRoot.path),
    );
    await Future<void>.delayed(const Duration(milliseconds: 200));
    await useCase.cancel();
    final firstResult = await first;
    expect(firstResult.cancelled, isTrue);
    // Verify that job A exits on cancel before the 1800 ms slow path.
    // Otherwise the remaining steps would not exercise the intended timing.
    expect(
      stopwatch.elapsedMilliseconds < 1000,
      isTrue,
      reason: '任务 A 应快速退出（control port 未就绪导致 cancel 未送达）',
    );

    // Start job B before the old timer can fire. Its worker completes in 1800 ms.
    // A leftover timer would fire during job B and kill its isolate.
    // The old exit handler left job B's completion future pending.
    final second = useCase.execute(
      ExtractGameIconsInput(clientDir: clientRoot.path),
    );

    // Wait past the cancellation grace period, then wait for job B to complete.
    final secondResult = await second.timeout(const Duration(seconds: 10));
    expect(secondResult.success, isTrue);
    expect(secondResult.cancelled, isFalse);
    expect(useCase.isRunning, isFalse);
  });

  test('Canceling twice still allows a third attempt to start', () async {
    final useCase = buildUseCase();

    Future<GameIconExtractionResult> runAndCancel() async {
      final task = useCase.execute(
        ExtractGameIconsInput(clientDir: clientRoot.path),
      );
      await Future<void>.delayed(const Duration(milliseconds: 200));
      await useCase.cancel();
      return task.timeout(const Duration(seconds: 10));
    }

    await runAndCancel();
    await runAndCancel();

    // A third job can start after the second cancellation without a BusyException.
    final third = await useCase
        .execute(ExtractGameIconsInput(clientDir: clientRoot.path))
        .timeout(const Duration(seconds: 10));
    expect(third.success, isTrue);
    expect(useCase.isRunning, isFalse);
  });
}

/// Scripted worker: honours the control protocol, terminates immediately on
/// 'cancel', otherwise reports a successful result after 1800ms (long
/// enough to outlive the cancel timer in the tests above).
Future<void> _scriptedWorker(GameIconExtractWorkerArgs args) async {
  final sendPort = args.sendPort;
  final cancelPort = ReceivePort();
  var sent = false;
  void sendResult(GameIconExtractionResult result) {
    if (sent) return;
    sent = true;
    sendPort.send(('result', result));
  }

  final subscription = cancelPort.listen((message) {
    if (message == 'cancel') {
      sendResult(
        const GameIconExtractionResult(
          extracted: 0,
          skipped: 0,
          failed: 0,
          errors: [],
          cancelled: true,
        ),
      );
    }
  });
  sendPort.send(('control', cancelPort.sendPort));

  await Future<void>.delayed(const Duration(milliseconds: 1800));
  sendResult(
    const GameIconExtractionResult(
      extracted: 1,
      skipped: 0,
      failed: 0,
      errors: [],
      cancelled: false,
    ),
  );
  await subscription.cancel();
  cancelPort.close();
}

/// ConfigUtil pointing at a temp directory (so tests never pollute the
/// project-root config.yaml).
final class _TempConfigUtil extends ConfigUtil {
  final String _dir;

  _TempConfigUtil(this._dir);

  @override
  String get configPath => p.join(_dir, 'config.yaml');
}
