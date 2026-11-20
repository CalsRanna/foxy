import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:foxy/use_case/agent/generate_agent_session_title.dart';
import 'package:foxy_agent/foxy_agent.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  test('generates a title from only the first user message', () async {
    final client = MockClient((request) async {
      final body = jsonDecode(request.body) as Map<String, Object?>;
      expect(request.url, _provider.endpoint);
      expect(body['model'], 'test-model');
      expect(body['input'], [
        {'role': 'user', 'content': '查一下亚麻布的掉落来源'},
      ]);
      expect(body, isNot(contains('tools')));

      return http.Response(
        '''data: {"type":"response.output_text.delta","delta":"亚麻布"}

data: {"type":"response.output_text.delta","delta":"掉落查询"}

data: {"type":"response.completed","response":{"status":"completed"}}

''',
        200,
        headers: {'content-type': 'text/event-stream; charset=utf-8'},
      );
    });

    final title = await generateAgentSessionTitle(
      _provider,
      '查一下亚麻布的掉落来源',
      httpClient: client,
    );

    expect(title, '亚麻布掉落查询');
  });

  test('does not return a title after a provider failure', () async {
    final client = MockClient((_) async => http.Response('Unavailable', 503));

    expect(
      await generateAgentSessionTitle(_provider, '查询', httpClient: client),
      isNull,
    );
  });
}

const _provider = AgentProviderConfig(
  baseUrl: 'https://example.test/v1',
  apiKey: 'test-key',
  model: 'test-model',
);
