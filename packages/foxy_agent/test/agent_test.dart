import 'dart:convert';

import 'package:foxy_agent/foxy_agent.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:test/test.dart';

void main() {
  test('executes a tool call and completes the run', () async {
    final requests = <http.Request>[];
    final tool = _FakeTool(name: 'list_creatures', result: {'count': 2});
    final client = _scriptedClient([
      _callRound([
        _functionCall('list_creatures', {'maxLevel': 10}),
      ], text: 'Looking...'),
      _textRound('Found 2 creatures.'),
    ], requests);
    final agent = _buildAgent(client, tools: [tool]);
    final session = AgentSession();

    final events = await agent.run(session, 'find creatures').toList();

    expect(events.whereType<AgentTextDeltaEvent>().map((event) => event.text), [
      'Looking...',
      'Found 2 creatures.',
    ]);
    expect(events.whereType<AgentToolCallEvent>().single.callId, 'call_1');
    expect(tool.calls, [
      {'maxLevel': 10},
    ]);
    final result = events.whereType<AgentToolResultEvent>().single;
    expect(result.isError, isFalse);
    expect(jsonDecode(result.output), {'count': 2});
    expect(events.last, isA<AgentCompletedEvent>());

    expect(requests, hasLength(2));
    expect(requests.first.url.toString(), 'https://example.test/v1/responses');
    expect(requests.first.headers['Authorization'], 'Bearer test-key');
    final firstBody = jsonDecode(
      utf8.decode(requests.first.bodyBytes),
    ) as Map<String, Object?>;
    expect(firstBody['model'], 'test-model');
    expect(firstBody['stream'], true);
    expect(firstBody['store'], false);
    expect(firstBody.containsKey('reasoning'), isFalse);
    expect(firstBody['instructions'], 'You are a test agent.');
    final tools = (firstBody['tools'] as List<Object?>)
        .cast<Map<String, Object?>>();
    expect(tools.single['type'], 'function');
    expect(tools.single['name'], 'list_creatures');
    expect(firstBody['input'], [
      {'role': 'user', 'content': 'find creatures'},
    ]);

    final secondBody = jsonDecode(
      utf8.decode(requests.last.bodyBytes),
    ) as Map<String, Object?>;
    final input = (secondBody['input'] as List<Object?>)
        .cast<Map<String, Object?>>();
    expect(
      input.where((item) => item['type'] == 'function_call'),
      hasLength(1),
    );
    final output = input.singleWhere(
      (item) => item['type'] == 'function_call_output',
    );
    expect(output['call_id'], 'call_1');
    expect(jsonDecode(output['output']! as String), {'count': 2});
    expect(session.items, hasLength(4));
  });

  test('streams reasoning separately and can request a summary', () async {
    final requests = <http.Request>[];
    const reasoning = {
      'id': 'rs_1',
      'type': 'reasoning',
      'summary': [
        {'type': 'summary_text', 'text': 'Inspect schema.'},
        {'type': 'summary_text', 'text': 'Read rows.'},
      ],
    };
    final client = _scriptedClient([
      _sse([
        {'type': 'response.output_item.added', 'item': reasoning},
        for (final (part, delta) in [
          (0, 'Inspect '),
          (0, 'schema.'),
          (1, 'Read rows.'),
        ])
          {
            'type': 'response.reasoning_summary_text.delta',
            'item_id': 'rs_1',
            'summary_index': part,
            'delta': delta,
          },
        {'type': 'response.output_item.done', 'item': reasoning},
        {'type': 'response.output_text.delta', 'delta': 'Done.'},
        {
          'type': 'response.completed',
          'response': {
            'output': [reasoning],
          },
        },
      ]),
    ], requests);
    final agent = _buildAgent(client, requestReasoningSummary: true);
    final session = AgentSession();

    final events = await agent.run(session, 'go').toList();

    expect(events, [
      isA<AgentReasoningStartedEvent>(),
      isA<AgentReasoningDeltaEvent>().having(
        (event) => event.text,
        'text',
        'Inspect ',
      ),
      isA<AgentReasoningDeltaEvent>().having(
        (event) => event.text,
        'text',
        'schema.',
      ),
      isA<AgentReasoningDeltaEvent>().having(
        (event) => event.text,
        'text',
        '\n\nRead rows.',
      ),
      isA<AgentReasoningDoneEvent>().having(
        (event) => event.text,
        'text',
        isEmpty,
      ),
      isA<AgentTextDeltaEvent>(),
      isA<AgentCompletedEvent>(),
    ]);
    expect(session.items.last, reasoning);
    final body = jsonDecode(requests.single.body) as Map<String, Object?>;
    expect(body['reasoning'], {'summary': 'auto'});
  });

  test('reads reasoning text from deltas and completed items', () async {
    final client = _scriptedClient([
      _sse([
        {
          'type': 'response.reasoning_text.delta',
          'item_id': 'rs_streamed',
          'delta': 'Streamed reasoning.',
        },
        {
          'type': 'response.completed',
          'response': {
            'output': [
              {'id': 'rs_streamed', 'type': 'reasoning'},
              {
                'id': 'rs_completed',
                'type': 'reasoning',
                'content': [
                  {'type': 'reasoning_text', 'text': 'Final reasoning.'},
                ],
              },
            ],
          },
        },
      ]),
    ], <http.Request>[]);

    final events = await _buildAgent(client).run(AgentSession(), 'go').toList();

    expect(
      events.whereType<AgentReasoningDeltaEvent>().single.text,
      'Streamed reasoning.',
    );
    expect(
      events.whereType<AgentReasoningDoneEvent>().map((event) => event.text),
      ['', 'Final reasoning.'],
    );
    expect(events.last, isA<AgentCompletedEvent>());
  });

  test('executes parallel tool calls and returns every output', () async {
    final requests = <http.Request>[];
    final creatures = _FakeTool(name: 'list_creatures', result: {'count': 2});
    final schema = _FakeTool(
      name: 'get_table_schema',
      result: {'columns': <Object?>[]},
    );
    final client = _scriptedClient([
      _callRound([
        _functionCall('list_creatures', {'maxLevel': 10}, callId: 'call_1'),
        _functionCall('get_table_schema', {
          'table': 'creature',
        }, callId: 'call_2'),
      ]),
      _textRound('Done.'),
    ], requests);
    final agent = _buildAgent(client, tools: [creatures, schema]);

    final events = await agent.run(AgentSession(), 'go').toList();

    expect(
      events.whereType<AgentToolResultEvent>().map((event) => event.callId),
      ['call_1', 'call_2'],
    );
    expect(creatures.calls, hasLength(1));
    expect(schema.calls, hasLength(1));
    final body = jsonDecode(
      utf8.decode(requests.last.bodyBytes),
    ) as Map<String, Object?>;
    final input = (body['input'] as List<Object?>).cast<Map<String, Object?>>();
    final outputs = input
        .where((item) => item['type'] == 'function_call_output')
        .toList();
    expect(outputs.map((item) => item['call_id']), ['call_1', 'call_2']);
    expect(events.last, isA<AgentCompletedEvent>());
  });

  test('reports tool failures back to the model', () async {
    final requests = <http.Request>[];
    final tool = _FakeTool(name: 'boom', error: StateError('kaput'));
    final client = _scriptedClient([
      _callRound([_functionCall('boom', const {})]),
      _textRound('Sorry.'),
    ], requests);
    final agent = _buildAgent(client, tools: [tool]);

    final events = await agent.run(AgentSession(), 'go').toList();

    final result = events.whereType<AgentToolResultEvent>().single;
    expect(result.isError, isTrue);
    expect(result.output, contains('kaput'));
    expect(events.last, isA<AgentCompletedEvent>());
  });

  test('reports unknown tools as errors', () async {
    final requests = <http.Request>[];
    final client = _scriptedClient([
      _callRound([_functionCall('missing', const {})]),
      _textRound('Sorry.'),
    ], requests);
    final agent = _buildAgent(client);

    final events = await agent.run(AgentSession(), 'go').toList();

    final result = events.whereType<AgentToolResultEvent>().single;
    expect(result.isError, isTrue);
    expect(result.output, contains('Unknown tool'));
    expect(events.last, isA<AgentCompletedEvent>());
  });

  test('rejects invalid tool arguments', () async {
    final requests = <http.Request>[];
    final tool = _FakeTool(name: 'list_creatures', result: const {});
    final call = <String, Object?>{
      'type': 'function_call',
      'id': 'fc_x',
      'call_id': 'call_x',
      'name': 'list_creatures',
      'arguments': 'not-json',
    };
    final client = _scriptedClient([
      _callRound([call]),
      _textRound('Sorry.'),
    ], requests);
    final agent = _buildAgent(client, tools: [tool]);

    final events = await agent.run(AgentSession(), 'go').toList();

    final result = events.whereType<AgentToolResultEvent>().single;
    expect(result.isError, isTrue);
    expect(result.output, contains('not a valid JSON object'));
    expect(tool.calls, isEmpty);
  });

  test('continues through tool rounds without a cap', () async {
    final requests = <http.Request>[];
    final tool = _FakeTool(name: 'again', result: 'ok');
    const rounds = 10;
    final client = _scriptedClient([
      for (var i = 1; i <= rounds; i++)
        _callRound([_functionCall('again', const {}, callId: 'call_$i')]),
      _textRound('done'),
    ], requests);
    final agent = _buildAgent(client, tools: [tool]);

    final events = await agent.run(AgentSession(), 'go').toList();

    expect(tool.calls, hasLength(rounds));
    expect(requests, hasLength(rounds + 1));
    expect(events.last, isA<AgentCompletedEvent>());
  });

  test('fails when the stream ends without completion', () async {
    final client = _scriptedClient([
      _sse([
        {'type': 'response.output_text.delta', 'delta': 'hi'},
      ]),
    ], <http.Request>[]);
    final agent = _buildAgent(client);

    final events = await agent.run(AgentSession(), 'go').toList();

    expect(events.last, isA<AgentFailedEvent>());
    expect(
      (events.last as AgentFailedEvent).message,
      contains('response.completed'),
    );
  });

  test('fails with provider HTTP errors', () async {
    final client = MockClient((_) async => http.Response('bad key', 401));
    final agent = _buildAgent(client);

    final events = await agent.run(AgentSession(), 'go').toList();

    expect(events.last, isA<AgentFailedEvent>());
    expect(
      (events.last as AgentFailedEvent).message,
      'Provider returned HTTP 401.',
    );
  });

  test('rejects duplicate tool names', () {
    expect(
      () => _buildAgent(
        MockClient((_) async => http.Response('', 200)),
        tools: [
          _FakeTool(name: 'same'),
          _FakeTool(name: 'same'),
        ],
      ),
      throwsArgumentError,
    );
  });
}

FoxyAgent _buildAgent(
  http.Client client, {
  List<AgentTool> tools = const [],
  bool requestReasoningSummary = false,
}) => FoxyAgent(
  provider: AgentProviderConfig(
    baseUrl: 'https://example.test/v1',
    apiKey: 'test-key',
    model: 'test-model',
    requestReasoningSummary: requestReasoningSummary,
  ),
  instructions: 'You are a test agent.',
  tools: tools,
  httpClient: client,
);

String _callRound(
  List<Map<String, Object?>> calls, {
  String text = '',
}) => _sse([
  if (text.isNotEmpty) {'type': 'response.output_text.delta', 'delta': text},
  for (final call in calls) {'type': 'response.output_item.done', 'item': call},
  {
    'type': 'response.completed',
    'response': {'id': 'resp_call', 'status': 'completed', 'output': calls},
  },
]);

Map<String, Object?> _functionCall(
  String name,
  Map<String, Object?> arguments, {
  String callId = 'call_1',
}) => {
  'type': 'function_call',
  'id': 'fc_$callId',
  'call_id': callId,
  'name': name,
  'arguments': jsonEncode(arguments),
};

http.Client _scriptedClient(List<String> bodies, List<http.Request> log) {
  return MockClient((request) async {
    log.add(request);
    final index = log.length - 1;
    if (index >= bodies.length) {
      throw StateError('Unexpected request #${index + 1}.');
    }
    return http.Response(
      bodies[index],
      200,
      headers: {'content-type': 'text/event-stream; charset=utf-8'},
    );
  });
}

String _sse(List<Map<String, Object?>> events) => events
    .map((event) => 'event: ${event['type']}\ndata: ${jsonEncode(event)}\n\n')
    .join();

String _textRound(String text) => _sse([
  {'type': 'response.output_text.delta', 'delta': text},
  {
    'type': 'response.completed',
    'response': {
      'id': 'resp_text',
      'status': 'completed',
      'output': [
        {
          'type': 'message',
          'id': 'msg_1',
          'role': 'assistant',
          'content': [
            {'type': 'output_text', 'text': text},
          ],
        },
      ],
    },
  },
]);

final class _FakeTool extends AgentTool {
  @override
  final String name;

  final Object? result;

  final Object? error;

  final List<Map<String, Object?>> calls = [];

  _FakeTool({required this.name, this.result, this.error});

  @override
  String get description => 'Test tool.';

  @override
  Map<String, Object?> get inputSchema => const {
    'type': 'object',
    'properties': <String, Object?>{},
  };

  @override
  Future<Object?> call(Map<String, Object?> arguments) async {
    calls.add(arguments);
    final failure = error;
    if (failure != null) {
      throw failure;
    }
    return result;
  }
}
