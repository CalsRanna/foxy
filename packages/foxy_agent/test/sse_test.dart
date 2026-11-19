import 'dart:convert';

import 'package:foxy_agent/src/sse.dart';
import 'package:test/test.dart';

void main() {
  test('yields one data payload per blank-line separated event', () async {
    final body = 'event: a\ndata: {"x":1}\n\nevent: b\ndata: {"y":2}\n\n';

    final events = await sseDataEvents(Stream.value(utf8.encode(body)))
        .toList();

    expect(events, ['{"x":1}', '{"y":2}']);
  });

  test('reassembles events split across chunks', () async {
    final body = 'event: a\ndata: {"x":1}\n\nevent: b\ndata: hel\ndata: lo\n\n';
    final bytes = utf8.encode(body);
    final chunks = [
      bytes.sublist(0, 7),
      bytes.sublist(7, 23),
      bytes.sublist(23),
    ];

    final events = await sseDataEvents(Stream.fromIterable(chunks)).toList();

    expect(events, ['{"x":1}', 'hel\nlo']);
  });

  test('handles CRLF line endings', () async {
    final body = 'event: a\r\ndata: {"x":1}\r\n\r\n';

    final events = await sseDataEvents(Stream.value(utf8.encode(body)))
        .toList();

    expect(events, ['{"x":1}']);
  });

  test('ignores comments and event names', () async {
    final body = ': keep-alive\nevent: ping\ndata: {}\n\n';

    final events = await sseDataEvents(Stream.value(utf8.encode(body)))
        .toList();

    expect(events, ['{}']);
  });
}
