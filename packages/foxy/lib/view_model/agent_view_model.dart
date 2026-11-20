import 'dart:async';
import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:foxy/infrastructure/agent/agent_session_store.dart';
import 'package:foxy/infrastructure/logging/logger_util.dart';
import 'package:foxy/model/agent/agent_chat_session.dart';
import 'package:foxy/use_case/agent/agent_chat_use_case.dart';
import 'package:foxy/use_case/agent/agent_provider_config_use_case.dart';
import 'package:foxy/use_case/agent/agent_read_only_data_source.dart';
import 'package:foxy/use_case/agent/generate_agent_session_title.dart';
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

typedef AgentTitleGenerator = Future<String?> Function(
  AgentProviderConfig provider,
  String message,
);

/// State for the AI agent page: session list, active conversation, streaming
/// run state and provider settings.
///
/// Sessions persist as JSONL files (see [AgentSessionStore]); the list holds
/// lightweight metadata and content loads lazily when a session is selected.
class AgentViewModel with FieldControllerMixin {
  static const _defaultTitle = '新会话';

  final AgentProviderConfigUseCase _configUseCase;

  final AgentReadOnlyDataSource _dataSource;

  final AgentChatFactory _chatFactory;

  final AgentTitleGenerator _titleGenerator;

  final AgentSessionStore _sessionStore;

  final sessions = signal<List<AgentChatSessionMeta>>([]);

  final activeSessionId = signal<String?>(null);

  final messages = signal<List<AgentChatMessage>>([]);

  final running = signal(false);

  final ready = signal(false);

  late final draftController = registerController(StringFieldController());

  final Map<String, AgentChatSession> _loaded = {};
  final Map<String?, String> _drafts = {};

  StreamSubscription<AgentEvent>? _subscription;

  AgentChatUseCase? _chat;

  _AgentRun? _run;

  var _selectionToken = 0;

  var _initialized = false;

  AgentViewModel({
    AgentProviderConfigUseCase? configUseCase,
    AgentReadOnlyDataSource? dataSource,
    AgentChatFactory? chatFactory,
    AgentTitleGenerator titleGenerator = generateAgentSessionTitle,
    AgentSessionStore? sessionStore,
  }) : _configUseCase =
           configUseCase ?? GetIt.instance.get<AgentProviderConfigUseCase>(),
       _dataSource =
           dataSource ?? GetIt.instance.get<AgentReadOnlyDataSource>(),
       _chatFactory = chatFactory ?? _createChat,
       _titleGenerator = titleGenerator,
       _sessionStore = sessionStore ?? GetIt.instance.get<AgentSessionStore>();

  AgentChatSession? get activeSession {
    final id = activeSessionId.value;
    if (id == null) return null;
    return _loaded[id];
  }

  String? get activeTitle {
    final id = activeSessionId.value;
    if (id == null) return null;
    return sessions.value.where((meta) => meta.id == id).firstOrNull?.title;
  }

  ReadonlySignal<AgentProviderConfig?> get provider => _configUseCase.provider;

  Future<void> deleteSession(String id) async {
    if (_run?.session.id == id) return;
    _loaded.remove(id);
    sessions.value = sessions.value.where((meta) => meta.id != id).toList();
    await _sessionStore.deleteSession(id);
    if (id == activeSessionId.value) {
      final next = sessions.value.firstOrNull;
      if (next == null) {
        startNewSession();
      } else {
        await selectSession(next.id);
      }
    }
    _drafts.remove(id);
  }

  void dispose() {
    _selectionToken++;
    _subscription?.cancel();
    _subscription = null;
    _chat?.close();
    _chat = null;
    final run = _run;
    if (run != null) _persistReasoningSegment(run);
    _run = null;
    running.value = false;
    disposeControllers();
  }

  Future<void> initSignals() async {
    if (_initialized) return;
    _initialized = true;
    final selectionToken = _selectionToken;
    try {
      await _configUseCase.load();
    } catch (error) {
      LoggerUtil.instance.e('load agent provider config failed: $error');
    }
    try {
      sessions.value = await _sessionStore.list();
    } catch (error) {
      LoggerUtil.instance.e('list agent sessions failed: $error');
    }
    final latest = sessions.value.firstOrNull;
    if (latest != null && selectionToken == _selectionToken) {
      await selectSession(latest.id);
    }
    ready.value = true;
  }

  bool isReasoningInProgress(AgentChatMessage message) =>
      identical(_run?.reasoning, message);

  bool isToolInProgress(AgentChatMessage message) =>
      _run?.pendingToolCalls.values.contains(message) ?? false;

  Future<void> selectSession(String id) async {
    final cached = _loaded[id];
    if (cached != null) {
      _activateSession(cached);
      return;
    }
    final token = ++_selectionToken;
    AgentChatSession? loaded;
    try {
      loaded = await _sessionStore.load(id);
    } catch (error) {
      LoggerUtil.instance.e('load agent session failed: $error');
      return;
    }
    if (token != _selectionToken || loaded == null) return;
    _loaded[id] = loaded;
    _activateSession(loaded);
  }

  Future<void> send() async {
    if (!ready.value || running.value) return;
    final config = provider.value;
    final text = draftController.collect().trim();
    if (config == null || text.isEmpty) return;
    final session = activeSession ?? _createSession();
    draftController.init('');
    final firstMessage = session.messages.isEmpty;
    if (firstMessage) {
      session.title = AgentChatSession.titleFrom(text);
    }
    session.messages.add(
      AgentChatMessage(role: AgentChatRole.user, text: text),
    );
    final run = _AgentRun(session);
    run.assistant = _appendAssistant(run);
    run.persistedItemCount = session.session.items.length;
    _run = run;
    _touch(session);
    unawaited(
      _sessionStore.appendMessage(session.id, AgentChatRole.user, text),
    );
    running.value = true;
    if (firstMessage) unawaited(_nameSession(session, config, text));
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

  void startNewSession() => _activateSession(null);

  void stop() {
    final run = _run;
    if (!running.value || run == null) return;
    _subscription?.cancel();
    _subscription = null;
    _finishRun(run);
  }

  void _activateSession(AgentChatSession? session) {
    _selectionToken++;
    final previousId = activeSessionId.value;
    final nextId = session?.id;
    if (previousId != nextId) {
      _drafts[previousId] = draftController.collect();
      draftController.init(_drafts[nextId] ?? '');
    }
    activeSessionId.value = nextId;
    messages.value = session == null ? const [] : List.of(session.messages);
  }

  AgentChatMessage _appendAssistant(_AgentRun run) {
    final message = AgentChatMessage(role: AgentChatRole.assistant, text: '');
    run.session.messages.add(message);
    return message;
  }

  void _appendError(_AgentRun run, String message) {
    _persistReasoningSegment(run);
    final assistant = run.assistant ??= _appendAssistant(run);
    final prefix = assistant.text.isEmpty ? '' : '${assistant.text}\n\n';
    assistant.text = '$prefix错误：$message';
    run.hasText = true;
    _publish(run.session);
  }

  AgentChatMessage _appendReasoning(
    _AgentRun run, {
    bool beforeAssistant = false,
  }) {
    final reasoning = AgentChatMessage(role: AgentChatRole.reasoning, text: '');
    final messages = run.session.messages;
    final assistant = run.assistant;
    if (beforeAssistant && assistant != null) {
      messages.insert(messages.indexOf(assistant), reasoning);
    } else {
      _persistAssistantSegment(run);
      messages.add(reasoning);
    }
    return reasoning;
  }

  /// Drops the active assistant bubble when it never received text, so a
  /// tool-only segment leaves no empty bubble behind.
  void _clearEmptyAssistant(_AgentRun run) {
    final assistant = run.assistant;
    run.assistant = null;
    if (assistant == null || assistant.text.isNotEmpty) return;
    run.session.messages.remove(assistant);
  }

  String _compactArguments(Map<String, Object?> arguments) {
    if (arguments.isEmpty) return '';
    final text = jsonEncode(arguments);
    return ' ${text.length <= 80 ? text : '${text.substring(0, 80)}...'}';
  }

  AgentChatSession _createSession() {
    final id = '${DateTime.now().microsecondsSinceEpoch}';
    final session = AgentChatSession(id: id, title: _defaultTitle);
    _loaded[id] = session;
    _activateSession(session);
    _drafts.remove(null);
    unawaited(_sessionStore.createSession(id));
    return session;
  }

  void _finishRun(_AgentRun run) {
    if (!running.value) return;
    running.value = false;
    _subscription = null;
    _chat?.close();
    _chat = null;
    _run = null;
    _persistNewItems(run);
    _persistReasoningSegment(run);
    final assistant = run.assistant;
    _clearEmptyAssistant(run);
    if (!run.hasText) {
      const fallback = '（无回复）';
      run.session.messages.add(
        AgentChatMessage(role: AgentChatRole.assistant, text: fallback),
      );
      unawaited(
        _sessionStore.appendMessage(
          run.session.id,
          AgentChatRole.assistant,
          fallback,
        ),
      );
    } else if (assistant != null && assistant.text.isNotEmpty) {
      unawaited(
        _sessionStore.appendMessage(
          run.session.id,
          AgentChatRole.assistant,
          assistant.text,
        ),
      );
    }
    _publish(run.session);
  }

  void _handleEvent(AgentEvent event, _AgentRun run) {
    switch (event) {
      case AgentReasoningStartedEvent():
        _persistReasoningSegment(run);
        run.reasoning = _appendReasoning(run);
        _publish(run.session);
      case AgentReasoningDeltaEvent(:final text):
        final reasoning = run.reasoning ??= _appendReasoning(run);
        reasoning.text += text;
        _publish(run.session);
      case AgentReasoningDoneEvent(:final text):
        if (text.isNotEmpty) {
          final reasoning = run.reasoning ??= _appendReasoning(
            run,
            beforeAssistant: true,
          );
          reasoning.text = text;
        }
        _persistReasoningSegment(run);
        _publish(run.session);
      case AgentTextDeltaEvent(:final text):
        _persistReasoningSegment(run);
        final assistant = run.assistant ??= _appendAssistant(run);
        assistant.text += text;
        run.hasText = true;
        _publish(run.session);
      case AgentToolCallEvent(:final callId, :final name, :final arguments):
        _persistReasoningSegment(run);
        // Close the current text segment so the next deltas render after the
        // tool lines instead of merging into the bubble above them.
        _persistAssistantSegment(run);
        final line = '调用 $name${_compactArguments(arguments)}';
        final message = AgentChatMessage(role: AgentChatRole.tool, text: line);
        run.pendingToolCalls[callId] = message;
        run.session.messages.add(message);
        unawaited(
          _sessionStore.appendMessage(run.session.id, AgentChatRole.tool, line),
        );
        _persistNewItems(run);
        _publish(run.session);
      case AgentToolResultEvent(:final callId, :final isError, :final output):
        run.pendingToolCalls.remove(callId);
        if (isError) {
          final line = '工具失败：$output';
          run.session.messages.add(
            AgentChatMessage(role: AgentChatRole.tool, text: line),
          );
          unawaited(
            _sessionStore.appendMessage(
              run.session.id,
              AgentChatRole.tool,
              line,
            ),
          );
          _persistNewItems(run);
        }
        _publish(run.session);
      case AgentCompletedEvent():
        _finishRun(run);
      case AgentFailedEvent(:final message):
        _appendError(run, message);
        _finishRun(run);
    }
  }

  Future<void> _nameSession(
    AgentChatSession session,
    AgentProviderConfig provider,
    String message,
  ) async {
    try {
      final title = await _titleGenerator(provider, message);
      if (title == null || !identical(_loaded[session.id], session)) return;
      session.title = title;
      sessions.value = [
        for (final meta in sessions.value)
          if (meta.id == session.id)
            AgentChatSessionMeta(
              id: meta.id,
              title: title,
              updatedAt: meta.updatedAt,
            )
          else
            meta,
      ];
      await _sessionStore.saveTitle(session.id, title);
    } catch (error) {
      LoggerUtil.instance.w('generate agent session title failed: $error');
    }
  }

  /// Persists the current assistant text segment (if any) and starts a new
  /// one on the next text event.
  void _persistAssistantSegment(_AgentRun run) {
    final assistant = run.assistant;
    if (assistant != null && assistant.text.isNotEmpty) {
      unawaited(
        _sessionStore.appendMessage(
          run.session.id,
          AgentChatRole.assistant,
          assistant.text,
        ),
      );
    }
    _clearEmptyAssistant(run);
  }

  /// Appends protocol items the agent loop added since the last flush, so a
  /// restart keeps the conversation state in sync with the transcript.
  void _persistNewItems(_AgentRun run) {
    final items = run.session.session.items;
    if (items.length <= run.persistedItemCount) return;
    final fresh = items.sublist(run.persistedItemCount);
    run.persistedItemCount = items.length;
    unawaited(
      Future.wait(
        fresh.map((item) => _sessionStore.appendItem(run.session.id, item)),
      ),
    );
  }

  void _persistReasoningSegment(_AgentRun run) {
    final reasoning = run.reasoning;
    if (reasoning == null) return;
    run.reasoning = null;
    if (reasoning.text.isEmpty) {
      run.session.messages.remove(reasoning);
      return;
    }
    unawaited(
      _sessionStore.appendMessage(
        run.session.id,
        reasoning.role,
        reasoning.text,
      ),
    );
  }

  void _publish(AgentChatSession session) {
    if (session.id != activeSessionId.value) return;
    messages.value = List.of(session.messages);
  }

  void _touch(AgentChatSession session) {
    final meta = AgentChatSessionMeta(
      id: session.id,
      title: session.title,
      updatedAt: DateTime.now(),
    );
    final rest = sessions.value.where((item) => item.id != session.id);
    sessions.value = [meta, ...rest];
    _publish(session);
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
}

/// Per-run transcript state: which assistant bubble is currently receiving
/// text, whether any text was rendered, and how many protocol items were
/// already flushed to disk.
final class _AgentRun {
  final AgentChatSession session;
  late final pendingToolCalls = <String, AgentChatMessage>{};

  /// The assistant bubble receiving streamed text; cleared after a tool call
  /// so the next text segment starts a new bubble after the tool lines.
  AgentChatMessage? assistant;

  AgentChatMessage? reasoning;

  /// Whether any assistant text (answer or error) was rendered.
  var hasText = false;

  /// Number of `AgentSession.items` already persisted for this run.
  var persistedItemCount = 0;

  _AgentRun(this.session);
}
