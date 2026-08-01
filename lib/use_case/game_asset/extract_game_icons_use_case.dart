import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/game_asset/game_icon_extract_worker.dart';
import 'package:foxy/infrastructure/game_asset/game_icon_extractor.dart';
import 'package:foxy/infrastructure/game_asset/game_icon_paths.dart';

final class ExtractGameIconsInput {
  final String clientDir;
  final void Function(GameIconExtractProgress progress)? onProgress;

  const ExtractGameIconsInput({required this.clientDir, this.onProgress});
}

/// 从客户端 MPQ 提取游戏图标：校验客户端目录、持久化 `client_dir` 配置、
/// 在后台 isolate 执行提取（进度经 SendPort 回报），支持取消。
final class ExtractGameIconsUseCase {
  final ConfigUtil _configUtil;

  /// 提取产物输出目录（测试注入临时目录；默认运行时当前目录下 data/icon）。
  final String outputDir;

  var _cancelGeneration = 0;
  var _executing = false;
  Isolate? _activeIsolate;
  SendPort? _controlPort;
  Completer<GameIconExtractionResult>? _activeCompleter;

  ExtractGameIconsUseCase({
    required ConfigUtil configUtil,
    String? outputDir,
  }) : _configUtil = configUtil,
       outputDir = outputDir ?? GameIconPaths.iconDir;

  bool get isRunning => _executing;

  Future<GameIconExtractionResult> execute(ExtractGameIconsInput input) async {
    if (_executing) {
      throw StateError('已有图标提取任务正在运行');
    }

    final clientDir = input.clientDir.trim();
    if (clientDir.isEmpty) {
      throw ArgumentError.value(clientDir, 'clientDir', '请先选择客户端目录');
    }
    if (!await Directory(clientDir).exists()) {
      throw FileSystemException('客户端目录不存在', clientDir);
    }

    final cancelGeneration = _cancelGeneration;
    _executing = true;
    try {
      await _configUtil.update({'client_dir': clientDir});
      if (cancelGeneration != _cancelGeneration) return _cancelledResult;
      final result = await _spawnWorker(
        clientDir,
        input.onProgress,
        cancelGeneration,
      );
      if (result.success && !result.cancelled) {
        // 完整提取成功标记，供首次设置引导判定「提取图标」步骤完成。
        await _configUtil.update({'icons_extracted': true});
      }
      return result;
    } finally {
      _executing = false;
    }
  }

  Future<void> cancel() async {
    _cancelGeneration++;
    _controlPort?.send('cancel');
    // 优雅取消：worker 每文件检查标志后自行终止。5 秒兜底强制终止，
    // 覆盖 worker 卡死（如归档损坏导致长时间挂起）的极端情况。
    final completer = _activeCompleter;
    if (completer != null && !completer.isCompleted) {
      Future.delayed(const Duration(seconds: 5), () {
        _activeIsolate?.kill(priority: Isolate.immediate);
        _activeIsolate = null;
        _controlPort = null;
        if (!completer.isCompleted) completer.complete(_cancelledResult);
      });
    }
  }

  Future<GameIconExtractionResult> _spawnWorker(
    String clientDir,
    void Function(GameIconExtractProgress progress)? onProgress,
    int cancelGeneration,
  ) async {
    final receivePort = ReceivePort();
    final errorPort = ReceivePort();
    final exitPort = ReceivePort();
    final completer = Completer<GameIconExtractionResult>();
    _activeCompleter = completer;

    final isolate = await Isolate.spawn(
      runGameIconExtractWorker,
      (
        sendPort: receivePort.sendPort,
        clientDir: clientDir,
        outputDir: outputDir,
      ),
      onError: errorPort.sendPort,
      onExit: exitPort.sendPort,
    );
    _activeIsolate = isolate;
    _controlPort = null;

    var settled = false;
    void settle(GameIconExtractionResult result) {
      if (settled) return;
      settled = true;
      if (cancelGeneration == _cancelGeneration) {
        completer.complete(result);
      } else {
        completer.complete(_cancelledResult);
      }
    }

    final messageSubscription = receivePort.listen((message) {
      switch (message) {
        case ('control', SendPort controlPort):
          _controlPort = controlPort;
          if (_cancelGeneration != cancelGeneration) {
            controlPort.send('cancel');
          }
        case ('progress', GameIconExtractProgress progress):
          onProgress?.call(progress);
        case ('result', GameIconExtractionResult result):
          settle(result);
      }
    });
    // 端口必须挂监听才能消费消息；worker 异常走 onError。
    errorPort.listen((error) {
      settle(
        GameIconExtractionResult(
          extracted: 0,
          skipped: 0,
          failed: 0,
          errors: ['提取进程异常: $error'],
          cancelled: false,
        ),
      );
    });
    exitPort.listen((_) {});

    final result = await completer.future;
    await messageSubscription.cancel();
    receivePort.close();
    errorPort.close();
    exitPort.close();
    if (identical(_activeIsolate, isolate)) {
      _activeIsolate = null;
      _controlPort = null;
      _activeCompleter = null;
    }
    return result;
  }

  static final GameIconExtractionResult _cancelledResult =
      GameIconExtractionResult(
        extracted: 0,
        skipped: 0,
        failed: 0,
        errors: const [],
        cancelled: true,
      );
}
