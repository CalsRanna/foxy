import 'dart:isolate';

import 'game_icon_extractor.dart';
import 'game_mpq_source.dart';

/// Background-isolate entry point: runs the icon extraction and reports
/// progress/results via [GameIconExtractWorkerArgs.sendPort]. Message
/// protocol:
///
/// - `('control', SendPort)` → cancel port (terminates early per file after
///   receiving `'cancel'`)
/// - `('progress', GameIconExtractProgress)` → progress events
/// - `('result', GameIconExtractionResult)` → final result
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

typedef GameIconExtractWorkerArgs = ({
  SendPort sendPort,
  String clientDir,
  String outputDir,
});
