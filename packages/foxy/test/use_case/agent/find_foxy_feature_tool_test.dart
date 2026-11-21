import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/use_case/agent/agent_chat_use_case.dart';
import 'package:foxy/use_case/agent/find_foxy_feature_tool.dart';
import 'package:foxy_agent/foxy_agent.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  const tool = FindFoxyFeatureTool();

  group('find_foxy_feature', () {
    test(
      'finds the merchant tab by keyword and qualified table name',
      () async {
        final result = await tool.call({'query': ' NPC 商人 '});
        expect(result, {
          'features': [
            {
              'name': 'NPC 商人',
              'path': ['更多', '生物', '生物列表', '生物详情', '商人'],
              'steps': allOf(contains('编号（entry）'), contains('双击现有行编辑')),
            },
          ],
        });
        expect(await tool.call({'query': 'ACORE_WORLD.NPC_VENDOR'}), result);
      },
    );

    test('finds the DBC import entry and reports what it changes', () async {
      expect(await tool.call({'query': '导入 DBC'}), {
        'features': [
          {
            'name': '导入 DBC 文件',
            'path': ['设置', '数据工具', '导入 DBC'],
            'steps': allOf(contains('开始导入'), contains('覆盖 Foxy 数据库中的对应表')),
          },
        ],
      });
    });

    test('returns no GUI path for an unsupported table', () async {
      expect(await tool.call({'query': 'acore_auth.account_banned'}), {
        'features': isEmpty,
      });
    });

    test('rejects a blank query', () async {
      expect(await tool.call({'query': '  '}), contains('non-empty'));
    });
  });

  test(
    'chat advertises the GUI tool and returns its output to the model',
    () async {
      var requests = 0;
      final chat = AgentChatUseCase(
        provider: const AgentProviderConfig(
          baseUrl: 'https://example.test/v1',
          apiKey: 'test-key',
          model: 'test-model',
        ),
        catalog: const TableCatalog([]),
        dataSource: _UnusedDataSource(),
        httpClient: MockClient((request) async {
          requests++;
          final body = jsonDecode(request.body) as Map<String, Object?>;
          if (requests == 1) {
            final tools = (body['tools'] as List<Object?>)
                .cast<Map<String, Object?>>();
            expect(
              tools.map((tool) => tool['name']),
              containsAll(['query_rows', 'find_foxy_feature']),
            );
            expect(body['instructions'], contains('调用 find_foxy_feature'));
            return _completedResponse([
              {
                'type': 'function_call',
                'call_id': 'find_feature',
                'name': 'find_foxy_feature',
                'arguments': jsonEncode({'query': 'npc_vendor'}),
              },
            ]);
          }

          final input = body['input'] as List<Object?>;
          final output = input.last as Map<String, Object?>;
          expect(output['type'], 'function_call_output');
          expect(output['call_id'], 'find_feature');
          expect(jsonDecode(output['output'] as String), {
            'features': [
              containsPair('path', ['更多', '生物', '生物列表', '生物详情', '商人']),
            ],
          });
          return _completedResponse([]);
        }),
      );
      addTearDown(chat.close);

      final events = await chat.run(AgentSession(), '去哪里编辑 NPC 商人？').toList();

      expect(events.last, isA<AgentCompletedEvent>());
      expect(requests, 2);
    },
  );
}

class _UnusedDataSource extends Fake implements ReadOnlyDataSource {}

http.Response _completedResponse(List<Map<String, Object?>> output) {
  final event = {
    'type': 'response.completed',
    'response': {'status': 'completed', 'output': output},
  };
  return http.Response(
    'data: ${jsonEncode(event)}\n\n',
    200,
    headers: {'content-type': 'text/event-stream; charset=utf-8'},
  );
}
