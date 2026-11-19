import 'dart:convert';

/// Decodes a `text/event-stream` byte stream into event `data` payloads.
///
/// Multi-line `data:` fields are joined with `\n`; `event:`, `id:`, `retry:`
/// and comment lines are ignored. A trailing event without a blank line is
/// still emitted when the stream closes.
Stream<String> sseDataEvents(Stream<List<int>> byteStream) async* {
  final lines = byteStream
      .transform(utf8.decoder)
      .transform(const LineSplitter());
  final dataLines = <String>[];
  await for (final line in lines) {
    if (line.isEmpty) {
      if (dataLines.isNotEmpty) {
        yield dataLines.join('\n');
        dataLines.clear();
      }
      continue;
    }
    if (line.startsWith('data:')) {
      var value = line.substring('data:'.length);
      if (value.startsWith(' ')) {
        value = value.substring(1);
      }
      dataLines.add(value);
    }
  }
  if (dataLines.isNotEmpty) {
    yield dataLines.join('\n');
  }
}
