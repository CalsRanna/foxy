import 'dart:convert';

import 'package:foxy_agent/src/agent_config.dart';
import 'package:foxy_agent/src/agent_exception.dart';
import 'package:foxy_agent/src/json.dart';
import 'package:foxy_agent/src/sse.dart';
import 'package:http/http.dart' as http;

/// Low-level Responses protocol client: one streamed request, events as JSON.
final class ResponsesClient {
  ResponsesClient({required this.config, http.Client? httpClient})
    : _http = httpClient ?? http.Client();

  final AgentProviderConfig config;

  final http.Client _http;

  /// Sends [body] and yields each SSE event's JSON payload in order.
  Stream<JsonMap> streamResponse(JsonMap body) async* {
    final request = http.Request('POST', config.endpoint)
      ..headers.addAll({
        'Content-Type': 'application/json; charset=utf-8',
        'Accept': 'text/event-stream',
        'Authorization': 'Bearer ${config.apiKey}',
        ...config.headers,
      })
      ..body = jsonEncode(body);

    final response = await _http.send(request);
    if (response.statusCode != 200) {
      final text = await response.stream.bytesToString();
      throw AgentHttpException(statusCode: response.statusCode, body: text);
    }

    await for (final data in sseDataEvents(response.stream)) {
      if (data == '[DONE]') {
        return;
      }
      final decoded = jsonDecode(data);
      if (decoded is JsonMap) {
        yield decoded;
      }
    }
  }

  /// Releases the underlying HTTP client.
  void close() => _http.close();
}
