import 'dart:io';
import 'dart:isolate';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/game_asset/game_icon_extract_worker.dart';
import 'package:foxy/infrastructure/game_asset/game_icon_extractor.dart';
import 'package:foxy/use_case/game_asset/extract_game_icons_use_case.dart';
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

  test('取消后立即重试：旧取消定时器不会杀死新任务', () async {
    final useCase = buildUseCase();

    // 任务 A：启动后等待 control port 就绪（200ms 足够 isolate 启动并
    // 上报 control），再取消。脚本 worker 收到 cancel 立即发取消结果，
    // A 快速结束（此时取消定时器仍挂起，窗口 500ms）。
    final stopwatch = Stopwatch()..start();
    final first = useCase.execute(
      ExtractGameIconsInput(clientDir: clientRoot.path),
    );
    await Future<void>.delayed(const Duration(milliseconds: 200));
    await useCase.cancel();
    final firstResult = await first;
    expect(firstResult.cancelled, isTrue);
    // 自检：A 必须走「收到 cancel 快速退出」路径（而非 1800ms 慢退），
    // 否则后续时序失效，本测试会假阴性——这里让它显式失败。
    expect(
      stopwatch.elapsedMilliseconds < 1000,
      isTrue,
      reason: '任务 A 应快速退出（control port 未就绪导致 cancel 未送达）',
    );

    // 任务 B：定时器触发前启动，脚本 worker 需要 1800ms 才完成——
    // 定时器（若存在）在 B 运行期间触发。旧实现会杀掉 B 的 isolate，
    // B 的 completer 永不完成（旧 exitPort 无兜底）；新实现不杀。
    final second = useCase.execute(
      ExtractGameIconsInput(clientDir: clientRoot.path),
    );

    // 等待越过 cancelGraceMs 窗口（确保旧定时器已触发），再等 B 完成。
    final secondResult = await second.timeout(const Duration(seconds: 10));
    expect(secondResult.success, isTrue);
    expect(secondResult.cancelled, isFalse);
    expect(useCase.isRunning, isFalse);
  });

  test('取消后重试，再取消，仍能第三次正常启动', () async {
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

    // 第二次取消后仍可启动第三次任务（BusyException 不得残留）。
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
