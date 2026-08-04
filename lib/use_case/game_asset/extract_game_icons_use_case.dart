import 'dart:async';
import 'dart:io';
import 'dart:isolate';

import 'package:foxy/infrastructure/config/config_util.dart';
import 'package:foxy/infrastructure/errors/foxy_exceptions.dart';
import 'package:foxy/infrastructure/game_asset/game_icon_extract_worker.dart';
import 'package:foxy/infrastructure/game_asset/game_icon_extractor.dart';
import 'package:foxy/infrastructure/game_asset/game_icon_paths.dart';

final class ExtractGameIconsInput {
  final String clientDir;
  final void Function(GameIconExtractProgress progress)? onProgress;

  const ExtractGameIconsInput({required this.clientDir, this.onProgress});
}

/// Extracts game icons from the client MPQs: validates the client
/// directory, persists the `client_dir` config, runs the extraction on a
/// background isolate (progress reported via SendPort), and supports
/// cancellation.
final class ExtractGameIconsUseCase {
  static final GameIconExtractionResult _cancelledResult =
      GameIconExtractionResult(
        extracted: 0,
        skipped: 0,
        failed: 0,
        errors: const [],
        cancelled: true,
      );

  final ConfigUtil _configUtil;

  /// Output directory for extracted files (tests inject a temp directory;
  /// default is data/icon under the runtime working directory).
  final String outputDir;
  var _cancelGeneration = 0;
  var _executing = false;
  Isolate? _activeIsolate;
  SendPort? _controlPort;

  Completer<GameIconExtractionResult>? _activeCompleter;

  ExtractGameIconsUseCase({required ConfigUtil configUtil, String? outputDir})
    : _configUtil = configUtil,
      outputDir = outputDir ?? GameIconPaths.iconDir;

  bool get isRunning => _executing;

  Future<void> cancel() async {
    _cancelGeneration++;
    _controlPort?.send('cancel');
    // Graceful cancel: the worker checks a flag per file and terminates
    // itself. A 5-second fallback force-kills, covering extremes where the
    // worker hangs (e.g. a corrupted archive stalling for a long time).
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

  Future<GameIconExtractionResult> execute(ExtractGameIconsInput input) async {
    if (_executing) {
      throw BusyException('an icon extraction task is already running');
    }

    final clientDir = input.clientDir.trim();
    if (clientDir.isEmpty) {
      throw ArgumentError.value(
        clientDir,
        'clientDir',
        'select the client directory first',
      );
    }
    if (!await Directory(clientDir).exists()) {
      throw FileSystemException('client directory does not exist', clientDir);
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
        // Full-extraction success marker, letting the first-setup wizard
        // decide the "extract icons" step is complete.
        await _configUtil.update({'icons_extracted': true});
      }
      return result;
    } finally {
      _executing = false;
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
    // The port needs a listener to consume messages; worker errors go
    // through onError.
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
}
