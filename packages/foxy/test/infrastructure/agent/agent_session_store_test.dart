import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/agent/agent_session_store.dart';
import 'package:foxy/model/agent/agent_chat_session.dart';

void main() {
  late Directory tempDir;
  late AgentSessionStore store;

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('foxy_agent_session_test');
    store = AgentSessionStore(root: Directory('${tempDir.path}/session'));
  });

  tearDown(() async {
    await tempDir.delete(recursive: true);
  });

  test('round-trips messages and items', () async {
    await store.createSession('s1');
    await store.appendMessage('s1', AgentChatRole.user, '掉落亚麻布的 10 级以下生物');
    await store.appendItem('s1', {
      'role': 'user',
      'content': '掉落亚麻布的 10 级以下生物',
    });
    await store.appendMessage('s1', AgentChatRole.assistant, '我先查一下。');
    await store.appendItem('s1', {
      'type': 'function_call',
      'call_id': 'c1',
      'name': 'query_rows',
      'arguments': '{}',
    });

    final loaded = await store.load('s1');

    expect(loaded, isNotNull);
    expect(loaded!.title, '掉落亚麻布的 10 级以下生物');
    expect(loaded.messages.map((message) => message.role), [
      AgentChatRole.user,
      AgentChatRole.assistant,
    ]);
    expect(loaded.session.items, hasLength(2));
    expect(loaded.session.items.last['type'], 'function_call');
  });

  test('list derives titles and orders by recency', () async {
    await store.createSession('s1');
    await store.appendMessage('s1', AgentChatRole.user, '第一个会话');
    await store.createSession('s2');
    await store.appendMessage('s2', AgentChatRole.user, '第二个会话');

    final metas = await store.list();

    expect(metas.map((meta) => meta.id), ['s2', 's1']);
    expect(metas.first.title, '第二个会话');
  });

  test('ignores a partially written trailing line', () async {
    await store.createSession('s1');
    await store.appendMessage('s1', AgentChatRole.user, 'hello');
    final file = File('${tempDir.path}/session/s1.jsonl');
    await file.writeAsString(
      '{"type":"message","role":"assist',
      mode: FileMode.append,
    );

    final loaded = await store.load('s1');

    expect(loaded!.messages, hasLength(1));
    expect(loaded.messages.single.text, 'hello');
  });

  test('repairs a user message without its protocol item', () async {
    await store.createSession('s1');
    await store.appendMessage('s1', AgentChatRole.user, 'hello');

    final loaded = await store.load('s1');

    expect(loaded!.session.items, [
      {'role': 'user', 'content': 'hello'},
    ]);
  });

  test('delete removes the session file', () async {
    await store.createSession('s1');

    await store.deleteSession('s1');

    expect(await store.load('s1'), isNull);
    expect(await store.list(), isEmpty);
  });
}
