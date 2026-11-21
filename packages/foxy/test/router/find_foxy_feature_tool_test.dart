import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/entity/feature_entity.dart';
import 'package:foxy/router/find_foxy_feature_tool.dart';
import 'package:foxy/router/router.dart';
import 'package:foxy/router/router_menu.dart';
import 'package:foxy/router/setting_entry.dart';
import 'package:foxy/router/setting_section.dart';
import 'package:foxy/use_case/agent/agent_chat_use_case.dart';
import 'package:foxy_agent/foxy_agent.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  final creature = _module(RouterMenu.creatureTemplate, '生物');
  final tool = FindFoxyFeatureTool([creature]);

  group('find_foxy_feature', () {
    test('indexes every menu using its registered route', () async {
      final sidebar = RouterMenu.sidebarMenus(const []);
      final catalog = FindFoxyFeatureTool(
        RouterMenu.values
            .where((menu) => !sidebar.contains(menu))
            .map((menu) => _module(menu, '${menu.label}卡片'))
            .toList(),
      );
      final registeredRoutes = FoxyRouter.router.routes
          .expand((route) => route.children ?? [])
          .map((route) => route.name);

      await Future.wait(
        RouterMenu.values.map((menu) async {
          expect(registeredRoutes, contains(menu.route.routeName));
          expect(await catalog.call({'query': menu.route.routeName}), {
            'features': [
              containsPair('path', [
                if (!sidebar.contains(menu)) ...[
                  RouterMenu.more.label,
                  '${menu.label}卡片',
                ],
                menu.label,
              ]),
            ],
          });
        }),
      );
    });

    test(
      'uses the pinned sidebar entry or the actual More card name',
      () async {
        final gem = _module(RouterMenu.gemProperty, '宝石属性配置');
        const query = {'query': 'foxy.dbc_gem_properties'};
        final unpinned = FindFoxyFeatureTool([gem]);
        final pinned = FindFoxyFeatureTool([gem.copyWith(isPinned: true)]);

        expect(await unpinned.call(query), {
          'features': [
            containsPair('path', ['更多', '宝石属性配置', '宝石属性列表']),
          ],
        });
        expect(await pinned.call(query), {
          'features': [
            containsPair('path', ['宝石属性列表']),
          ],
        });
        expect(
          await pinned.call({'query': '宝石属性详情'}),
          await pinned.call(query),
        );
      },
    );

    test('indexes settings sections and their visible controls', () async {
      await Future.wait(
        SettingSection.values.map((section) async {
          expect(await tool.call({'query': section.label}), {
            'features': [
              containsPair('path', ['设置', section.label]),
            ],
          });
        }),
      );
      await Future.wait(
        SettingEntry.values.map((entry) async {
          expect(await tool.call({'query': entry.actionLabel}), {
            'features': [
              containsPair(
                'path',
                containsAllInOrder([
                  '设置',
                  entry.section.label,
                  entry.actionLabel,
                ]),
              ),
            ],
          });
        }),
      );
      expect(await tool.call({'query': '服务端目录'}), {
        'features': [
          containsPair('path', ['设置', '游戏环境', '目录设置', '服务端目录']),
        ],
      });
    });

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
        dataSource: _UnusedSqlDataSource(),
        featureTool: tool,
        httpClient: MockClient((request) async {
          requests++;
          final body = jsonDecode(request.body) as Map<String, Object?>;
          if (requests == 1) {
            final tools = (body['tools'] as List<Object?>)
                .cast<Map<String, Object?>>();
            expect(
              tools.map((tool) => tool['name']),
              unorderedEquals([
                'list_tables',
                'describe_table',
                'describe_field_values',
                'describe_references',
                'server_time',
                'query_sql',
                'explain_sql',
                'find_foxy_feature',
              ]),
            );
            expect(body['instructions'], contains('读取记录统一用 query_sql'));
            expect(
              body['instructions'],
              isNot(matches(r'query_rows|get_row|count_rows|aggregate_rows')),
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

FeatureEntity _module(RouterMenu menu, String name) => FeatureEntity(
  id: menu.index,
  name: name,
  description: '测试模块',
  icon: '',
  routerMenu: menu.name,
  createdAt: DateTime(2026),
  updatedAt: DateTime(2026),
);

class _UnusedSqlDataSource extends Fake
    implements
        ReadOnlyDataSource,
        ReadOnlySqlDataSource,
        SqlDiagnosticsDataSource {}

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
