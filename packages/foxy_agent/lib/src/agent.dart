import 'dart:convert';

import 'package:foxy_agent/src/agent_config.dart';
import 'package:foxy_agent/src/agent_event.dart';
import 'package:foxy_agent/src/agent_exception.dart';
import 'package:foxy_agent/src/agent_session.dart';
import 'package:foxy_agent/src/agent_tool.dart';
import 'package:foxy_agent/src/json.dart';
import 'package:foxy_agent/src/responses_client.dart';
import 'package:http/http.dart' as http;

/// UI-independent agent loop over the Responses protocol.
///
/// One [run] appends the user message to the session, requests a streamed
/// response, executes requested tools concurrently, feeds the results back,
/// and repeats until the model answers without tool calls. Errors are reported
/// as [AgentFailedEvent] before the stream closes.
final class FoxyAgent {
  /// Provider connection settings.
  final AgentProviderConfig provider;

  /// System instructions defining the agent's role and constraints.
  final String instructions;

  /// Extra fields merged into every request body (e.g. `temperature`,
  /// `include`), for provider-specific options.
  final Map<String, Object?> extraRequestBody;

  final Map<String, AgentTool> _tools;

  final ResponsesClient _client;

  FoxyAgent({
    required this.provider,
    required this.instructions,
    required List<AgentTool> tools,
    this.extraRequestBody = const {},
    http.Client? httpClient,
  }) : _tools = {for (final tool in tools) tool.name: tool},
       _client = ResponsesClient(config: provider, httpClient: httpClient) {
    if (_tools.length != tools.length) {
      throw ArgumentError('Tool names must be unique.');
    }
  }

  /// Releases the underlying HTTP client.
  void close() => _client.close();

  /// Runs one user turn and emits events as they happen.
  Stream<AgentEvent> run(AgentSession session, String userMessage) async* {
    session.addUserMessage(userMessage);
    try {
      for (;;) {
        final streamedItems = <JsonMap>[];
        JsonMap? response;
        await for (final event in _client.streamResponse(
          _requestBody(session),
        )) {
          switch (event['type']) {
            case 'response.output_text.delta':
              {
                final delta = event['delta'];
                if (delta is String && delta.isNotEmpty) {
                  yield AgentTextDeltaEvent(delta);
                }
              }
            case 'response.output_item.done':
              {
                final item = event['item'];
                if (item is JsonMap) {
                  streamedItems.add(item);
                }
              }
            case 'response.completed':
              {
                final completed = event['response'];
                if (completed is JsonMap) {
                  response = completed;
                }
              }
            case 'response.failed':
              throw AgentException(_failureMessage(event, 'Response failed.'));
            case 'response.incomplete':
              throw AgentException(
                _failureMessage(event, 'Response incomplete.'),
              );
            case 'error':
              {
                final message = event['message'];
                throw AgentException(
                  message is String ? message : 'Provider stream error.',
                );
              }
          }
        }
        if (response == null) {
          throw const AgentException(
            'Stream ended without a response.completed event.',
          );
        }
        final status = response['status'];
        if (status is String && status != 'completed') {
          throw AgentException('Response finished with status $status.');
        }
        final items = _outputItems(response, streamedItems);
        session.addItems(items);
        final calls = items
            .where((item) => item['type'] == 'function_call')
            .toList();
        if (calls.isEmpty) {
          yield const AgentCompletedEvent();
          return;
        }
        final pending = <Future<AgentToolResultEvent>>[];
        for (final call in calls) {
          final callId = _stringField(call, 'call_id');
          final name = _stringField(call, 'name');
          yield AgentToolCallEvent(
            callId: callId,
            name: name,
            arguments: _parseArguments(call['arguments']) ?? const {},
          );
          pending.add(
            _executeTool(
              callId: callId,
              name: name,
              rawArguments: call['arguments'],
            ),
          );
        }
        for (final future in pending) {
          final result = await future;
          session.addItems([
            {
              'type': 'function_call_output',
              'call_id': result.callId,
              'output': result.output,
            },
          ]);
          yield result;
        }
      }
    } on AgentException catch (error) {
      yield AgentFailedEvent(error.message);
    } on http.ClientException catch (error) {
      yield AgentFailedEvent('Network error: ${error.message}');
    } catch (error) {
      yield AgentFailedEvent(error.toString());
    }
  }

  Future<AgentToolResultEvent> _executeTool({
    required String callId,
    required String name,
    required Object? rawArguments,
  }) async {
    final tool = _tools[name];
    if (tool == null) {
      return AgentToolResultEvent(
        callId: callId,
        name: name,
        output: 'Unknown tool: $name.',
        isError: true,
      );
    }
    final arguments = _parseArguments(rawArguments);
    if (arguments == null) {
      return AgentToolResultEvent(
        callId: callId,
        name: name,
        output: 'Tool arguments are not a valid JSON object.',
        isError: true,
      );
    }
    try {
      final result = await tool.call(arguments);
      return AgentToolResultEvent(
        callId: callId,
        name: name,
        output: result is String ? result : jsonEncode(result),
        isError: false,
      );
    } catch (error) {
      return AgentToolResultEvent(
        callId: callId,
        name: name,
        output: 'Tool failed: $error',
        isError: true,
      );
    }
  }

  String _failureMessage(JsonMap event, String fallback) {
    final response = event['response'];
    if (response is JsonMap) {
      final error = response['error'];
      if (error is JsonMap) {
        final message = error['message'];
        if (message is String && message.isNotEmpty) {
          return message;
        }
      }
      final details = response['incomplete_details'];
      if (details is JsonMap) {
        final reason = details['reason'];
        if (reason is String && reason.isNotEmpty) {
          return 'Response incomplete: $reason.';
        }
      }
    }
    return fallback;
  }

  List<JsonMap> _outputItems(JsonMap response, List<JsonMap> streamed) {
    final output = response['output'];
    if (output is List<Object?>) {
      final items = output.whereType<JsonMap>().toList();
      if (items.isNotEmpty) {
        return items;
      }
    }
    return streamed;
  }

  JsonMap? _parseArguments(Object? raw) {
    if (raw is JsonMap) {
      return raw;
    }
    if (raw is! String) {
      return null;
    }
    try {
      final decoded = jsonDecode(raw);
      return decoded is JsonMap ? decoded : null;
    } on FormatException {
      return null;
    }
  }

  JsonMap _requestBody(AgentSession session) => {
    'model': provider.model,
    'instructions': instructions,
    'input': session.items,
    if (_tools.isNotEmpty)
      'tools': [for (final tool in _tools.values) _toolDefinition(tool)],
    'stream': true,
    // The client owns the conversation; never let the provider retain it.
    'store': false,
    ...extraRequestBody,
  };

  String _stringField(JsonMap item, String key) {
    final value = item[key];
    return value is String ? value : '';
  }

  JsonMap _toolDefinition(AgentTool tool) => {
    'type': 'function',
    'name': tool.name,
    'description': tool.description,
    'parameters': tool.inputSchema,
  };
}
