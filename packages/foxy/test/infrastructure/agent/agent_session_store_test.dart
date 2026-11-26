import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/infrastructure/agent/agent_session_store.dart';
import 'package:foxy/model/agent/agent_chat_session.dart';
import 'package:path/path.dart' as p;

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

  test('moves the legacy session directory into data/session', () async {
    await store.createSession('s1');
    await store.appendMessage('s1', AgentChatRole.user, '原始问题');
    await store.appendItem('s1', {'role': 'user', 'content': '原始问题'});
    await store.appendItem('s1', {'type': 'function_call', 'call_id': 'c1'});
    await store.appendItem('s1', {
      'type': 'function_call_output',
      'call_id': 'c1',
      'output': '结果',
    });
    await store.saveTitle('s1', '生成标题');

    final previousDir = Directory.current;
    final AgentSessionStore migrated;
    try {
      Directory.current = tempDir;
      migrated = AgentSessionStore();
    } finally {
      Directory.current = previousDir;
    }

    expect(Directory(p.join(tempDir.path, 'session')).existsSync(), isFalse);
    expect((await migrated.list()).single.title, '生成标题');
    final loaded = (await migrated.load('s1'))!;
    expect(loaded.messages.single.text, '原始问题');
    expect(loaded.session.items.last['call_id'], 'c1');

    await migrated.createSession('s2');
    expect(
      File(p.join(tempDir.path, 'data', 'session', 's2.jsonl')).existsSync(),
      isTrue,
    );
  });

  test('round-trips messages and items with a legacy session ID', () async {
    const id = '0123456789abcdef0123456789abcdef';
    await store.createSession(id);
    await store.appendMessage(id, AgentChatRole.user, '掉落亚麻布的 10 级以下生物');
    await store.appendItem(id, {'role': 'user', 'content': '掉落亚麻布的 10 级以下生物'});
    await store.appendMessage(id, AgentChatRole.assistant, '我先查一下。');
    await store.appendItem(id, {
      'type': 'function_call',
      'call_id': 'c1',
      'name': 'query_rows',
      'arguments': '{}',
    });
    await store.appendItem(id, {
      'type': 'function_call_output',
      'call_id': 'c1',
      'output': '结果',
    });

    expect((await store.list()).single.id, id);
    final loaded = await store.load(id);

    expect(loaded, isNotNull);
    expect(loaded!.title, '掉落亚麻布的 10 级以下生物');
    expect(loaded.messages.map((message) => message.role), [
      AgentChatRole.user,
      AgentChatRole.assistant,
    ]);
    expect(loaded.session.items.map((item) => item['type']), [
      null,
      'function_call',
      'function_call_output',
    ]);
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

  test('restores generated titles in the list and transcript', () async {
    await store.createSession('s1');
    await store.appendMessage('s1', AgentChatRole.user, '原始问题');
    await store.saveTitle('s1', '生成标题');

    final reopened = AgentSessionStore(
      root: Directory('${tempDir.path}/session'),
    );
    expect((await reopened.list()).single.title, '生成标题');
    expect((await reopened.load('s1'))!.title, '生成标题');

    await reopened.deleteSession('s1');
    await reopened.saveTitle('s1', '删除后返回的标题');
    await reopened.createSession('s1');
    expect((await reopened.list()).single.title, '新会话');
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

  test(
    'repairs unanswered tool calls when replaying a saved session',
    () async {
      const user = {'role': 'user', 'content': 'query'};
      const completed = {'type': 'function_call', 'call_id': 'completed'};
      const output = {
        'type': 'function_call_output',
        'call_id': 'completed',
        'output': 'result',
      };
      const reasoning = {'type': 'reasoning', 'id': 'rs_1', 'summary': []};
      const interrupted = {'type': 'function_call', 'call_id': 'interrupted'};
      const diagnostic = {'role': 'assistant', 'content': 'Foxy 运行诊断：本轮未完成'};
      const followUp = {'role': 'user', 'content': 'retry'};
      const lastCall = {
        'type': 'function_call',
        'call_id': 'interrupted_again',
      };
      const interruption =
          'Tool execution was interrupted before a result was saved.';
      await store.createSession('s1');
      await store.appendMessage(
        's1',
        AgentChatRole.user,
        'query',
        inputItem: user,
      );
      await store.appendMessage('s1', AgentChatRole.tool, '调用 query_sql');
      for (final item in [
        completed,
        reasoning,
        interrupted,
        output,
        diagnostic,
        followUp,
        lastCall,
      ]) {
        await store.appendItem('s1', item);
      }

      final restored = (await store.load('s1'))!;

      expect(restored.session.items, [
        user,
        completed,
        reasoning,
        interrupted,
        output,
        {
          'type': 'function_call_output',
          'call_id': 'interrupted',
          'output': interruption,
        },
        diagnostic,
        followUp,
        lastCall,
        {
          'type': 'function_call_output',
          'call_id': 'interrupted_again',
          'output': interruption,
        },
      ]);
      expect(restored.messages.last.text, '调用 query_sql');
    },
  );

  test('delete removes the session file', () async {
    await store.createSession('s1');

    await store.deleteSession('s1');

    expect(await store.load('s1'), isNull);
    expect(await store.list(), isEmpty);
  });
}
