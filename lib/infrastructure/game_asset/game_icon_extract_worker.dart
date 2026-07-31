import 'dart:isolate';

import 'game_icon_extractor.dart';
import 'game_mpq_source.dart';

typedef GameIconExtractWorkerArgs = ({
  SendPort sendPort,
  String clientDir,
  String outputDir,
});

/// 后台 isolate 入口：执行图标提取并通过 [GameIconExtractWorkerArgs.sendPort]
/// 回报进度与结果。消息协议：
///
/// - `('control', SendPort)` → 取消端口（收到 `'cancel'` 后逐文件提前终止）
/// - `('progress', GameIconExtractProgress)` → 进度事件
/// - `('result', GameIconExtractionResult)` → 最终结果
Future<void> runGameIconExtractWorker(GameIconExtractWorkerArgs args) async {
  final (sendPort: sendPort, clientDir: clientDir, outputDir: outputDir) = args;
  final cancelPort = ReceivePort();
  var cancelled = false;
  final cancelSubscription = cancelPort.listen((message) {
    if (message == 'cancel') cancelled = true;
  });
  sendPort.send(('control', cancelPort.sendPort));

  final extractor = GameIconExtractor(
    openSource: (archivePath) => WarcraftyMpqSource(archivePath),
    clientDir: clientDir,
    outputDir: outputDir,
  );
  final result = extractor.extract(
    onProgress: (progress) => sendPort.send(('progress', progress)),
    isCancelled: () => cancelled,
  );
  sendPort.send(('result', result));

  await cancelSubscription.cancel();
  cancelPort.close();
}
