/// Per-file count progress.
class GameIconExtractCount extends GameIconExtractProgress {
  final String fileName;
  final int completed;
  final int total;

  const GameIconExtractCount({
    required this.fileName,
    required this.completed,
    required this.total,
  });
}

/// Extraction result.
class GameIconExtractionResult extends GameIconExtractProgress {
  final int extracted;
  final int skipped;
  final int failed;
  final List<String> errors;
  final bool cancelled;

  const GameIconExtractionResult({
    required this.extracted,
    required this.skipped,
    required this.failed,
    required this.errors,
    required this.cancelled,
  });

  bool get success => !cancelled && failed == 0;
}

/// Extraction progress event.
sealed class GameIconExtractProgress {
  const GameIconExtractProgress();
}

/// Phase status (scanning / preparing).
class GameIconExtractStatus extends GameIconExtractProgress {
  final String message;

  const GameIconExtractStatus(this.message);
}
