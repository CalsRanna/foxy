import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/model/agent/agent_chat_session.dart';
import 'package:foxy/use_case/agent/agent_chat_use_case.dart';
import 'package:foxy/use_case/agent/agent_provider_config_use_case.dart';
import 'package:foxy/use_case/agent/agent_read_only_data_source.dart';
import 'package:foxy/view_model/form/field_controller.dart';
import 'package:foxy_agent/foxy_agent.dart';
import 'package:get_it/get_it.dart';
import 'package:signals/signals.dart';

/// Creates the chat runner for one send. Injectable so tests can script agent
/// events without a provider.
typedef AgentChatFactory = AgentChatUseCase Function({
  required AgentProviderConfig provider,
  required TableCatalog catalog,
  required ReadOnlyDataSource dataSource,
});

/// State for the AI agent page: session list, active conversation, streaming
/// run state and provider settings.
class AgentViewModel with FieldControllerMixin {
  AgentViewModel({
    AgentProviderConfigUseCase? configUseCase,
    AgentReadOnlyDataSource? dataSource,
    AgentChatFactory? chatFactory,
  }) : _configUseCase =
           configUseCase ?? GetIt.instance.get<AgentProviderConfigUseCase>(),
       _dataSource =
           dataSource ?? GetIt.instance.get<AgentReadOnlyDataSource>(),
       _chatFactory = chatFactory ?? _createChat;

  static const _maxTitleLength = 24;

  final AgentProviderConfigUseCase _configUseCase;

  final AgentReadOnlyDataSource _dataSource;

  final AgentChatFactory _chatFactory;

  final sessions = signal<List<AgentChatSession>>([]);

  final activeSessionId = signal<String?>(null);

  final messages = signal<List<AgentChatMessage>>([]);

  final provider = signal<AgentProviderConfig?>(null);

  final running = signal(false);

  late final draftController = registerController(StringFieldController());

  StreamSubscription<AgentEvent>? _subscription;

  AgentChatUseCase? _chat;

  _AgentRun? _run;

  var _initialized = false;

  AgentChatSession? get activeSession {
    final id = activeSessionId.value;
    if (id == null) return null;
    return sessions.value.where((session) => session.id == id).firstOrNull;
  }

  Future<void> initSignals() async {
    if (_initialized) return;
    _initialized = true;
    try {
      provider.value = await _configUseCase.load();
    } catch (error) {
      LoggerUtil.instance.e('load agent provider config failed: $error');
    }
    if (sessions.value.isEmpty) {
      createSession();
    }
  }

  void createSession() {
    final session = AgentChatSession(
      id: '${DateTime.now().microsecondsSinceEpoch}',
      title: '新会话',
    );
    sessions.value = [session, ...sessions.value];
    activeSessionId.value = session.id;
    messages.value = const [];
  }

  void selectSession(String id) {
    final session = sessions.value.where((item) => item.id == id).firstOrNull;
    if (session == null) return;
    activeSessionId.value = id;
    messages.value = List.of(session.messages);
  }

  void deleteSession(String id) {
    if (running.value && id == activeSessionId.value) return;
    final remaining = sessions.value.where((item) => item.id != id).toList();
    sessions.value = remaining;
    if (id != activeSessionId.value) return;
    if (remaining.isEmpty) {
      createSession();
      return;
    }
    selectSession(remaining.first.id);
  }

  Future<void> saveProvider(AgentProviderConfig config) async {
    await _configUseCase.save(config);
    provider.value = config;
  }

  Future<void> send() async {
    if (running.value) return;
    final config = provider.value;
    final session = activeSession;
    final text = draftController.collect().trim();
    if (config == null || session == null || text.isEmpty) return;
    draftController.init('');
    if (session.messages.isEmpty) {
      session.title = _titleFor(text);
    }
    session.messages.add(
      AgentChatMessage(role: AgentChatRole.user, text: text),
    );
    final run = _AgentRun(session);
    run.assistant = _appendAssistant(run);
    _run = run;
    _touch(session);
    running.value = true;
    try {
      final catalog = await _dataSource.getCatalog();
      if (!running.value) return;
      final chat = _chatFactory(
        provider: config,
        catalog: catalog,
        dataSource: _dataSource,
      );
      _chat = chat;
      _subscription = chat
          .run(session.session, text)
          .listen(
            (event) => _handleEvent(event, run),
            onError: (Object error) {
              LoggerUtil.instance.e('agent run failed: $error');
              _appendError(run, FoxyExceptions.message(error));
              _finishRun(run);
            },
            onDone: () => _finishRun(run),
            cancelOnError: true,
          );
    } catch (error) {
      _appendError(run, FoxyExceptions.message(error));
      _finishRun(run);
    }
  }

  void stop() {
    final run = _run;
    if (!running.value || run == null) return;
    _subscription?.cancel();
    _subscription = null;
    _finishRun(run);
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
    _chat?.close();
    _chat = null;
    _run = null;
    running.value = false;
    disposeControllers();
  }

  static AgentChatUseCase _createChat({
    required AgentProviderConfig provider,
    required TableCatalog catalog,
    required ReadOnlyDataSource dataSource,
  }) => AgentChatUseCase(
    provider: provider,
    catalog: catalog,
    dataSource: dataSource,
  );

  void _handleEvent(AgentEvent event, _AgentRun run) {
    switch (event) {
      case AgentTextDeltaEvent(:final text):
        final assistant = run.assistant ??= _appendAssistant(run);
        assistant.text += text;
        run.hasText = true;
        _publish(run.session);
      case AgentToolCallEvent(:final name, :final arguments):
        // Close the current text segment so the next deltas render after the
        // tool lines instead of merging into the bubble above them.
        _clearEmptyAssistant(run);
        run.session.messages.add(
          AgentChatMessage(
            role: AgentChatRole.tool,
            text: '调用 $name${_compactArguments(arguments)}',
          ),
        );
        _publish(run.session);
      case AgentToolResultEvent(isError: true, :final output):
        run.session.messages.add(
          AgentChatMessage(role: AgentChatRole.tool, text: '工具失败：$output'),
        );
        _publish(run.session);
      case AgentToolResultEvent():
        break;
      case AgentCompletedEvent():
        _finishRun(run);
      case AgentFailedEvent(:final message):
        _appendError(run, message);
        _finishRun(run);
    }
  }

  void _finishRun(_AgentRun run) {
    if (!running.value) return;
    running.value = false;
    _subscription = null;
    _chat?.close();
    _chat = null;
    _run = null;
    _clearEmptyAssistant(run);
    if (!run.hasText) {
      run.session.messages.add(
        AgentChatMessage(role: AgentChatRole.assistant, text: '（无回复）'),
      );
    }
    _publish(run.session);
  }

  AgentChatMessage _appendAssistant(_AgentRun run) {
    final message = AgentChatMessage(role: AgentChatRole.assistant, text: '');
    run.session.messages.add(message);
    return message;
  }

  /// Drops the active assistant bubble when it never received text, so a
  /// tool-only segment leaves no empty bubble behind.
  void _clearEmptyAssistant(_AgentRun run) {
    final assistant = run.assistant;
    run.assistant = null;
    if (assistant == null || assistant.text.isNotEmpty) return;
    run.session.messages.remove(assistant);
  }

  void _appendError(_AgentRun run, String message) {
    final assistant = run.assistant ??= _appendAssistant(run);
    final prefix = assistant.text.isEmpty ? '' : '${assistant.text}\n\n';
    assistant.text = '$prefix错误：$message';
    run.hasText = true;
    _publish(run.session);
  }

  void _touch(AgentChatSession session) {
    final rest = sessions.value.where((item) => item.id != session.id);
    sessions.value = [session, ...rest];
    _publish(session);
  }

  void _publish(AgentChatSession session) {
    if (session.id != activeSessionId.value) return;
    messages.value = List.of(session.messages);
  }

  String _titleFor(String text) {
    final line = text.split('\n').first.trim();
    return line.length <= _maxTitleLength
        ? line
        : '${line.substring(0, _maxTitleLength)}...';
  }

  String _compactArguments(Map<String, Object?> arguments) {
    if (arguments.isEmpty) return '';
    final text = jsonEncode(arguments);
    return ' ${text.length <= 80 ? text : '${text.substring(0, 80)}...'}';
  }
}

/// Per-run transcript state: which assistant bubble is currently receiving
/// text, and whether any text was rendered at all.
final class _AgentRun {
  _AgentRun(this.session);

  final AgentChatSession session;

  /// The assistant bubble receiving streamed text; cleared after a tool call
  /// so the next text segment starts a new bubble after the tool lines.
  AgentChatMessage? assistant;

  /// Whether any assistant text (answer or error) was rendered.
  var hasText = false;
}
